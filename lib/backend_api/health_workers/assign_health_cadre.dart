import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/auth/login_api.dart';
import 'add_cadre_modal.dart';

// Function to show the assign cadre modal
void showAssignCadreModal(
  BuildContext context,
  Map<String, dynamic> worker,
  bool isDarkMode,
) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder:
        (context) => AssignCadreModal(worker: worker, isDarkMode: isDarkMode),
  );
}

class AssignCadreModal extends StatefulWidget {
  final Map<String, dynamic> worker;
  final bool isDarkMode;

  const AssignCadreModal({
    super.key,
    required this.worker,
    required this.isDarkMode,
  });

  @override
  _AssignCadreModalState createState() => _AssignCadreModalState();
}

class _AssignCadreModalState extends State<AssignCadreModal> {
  bool _isLoading = true;
  bool _isAssigning = false;
  bool _hasError = false;
  String _errorMessage = '';
  List<Map<String, dynamic>> _cadres = [];
  List<Map<String, dynamic>> _filteredCadres = [];
  String? _selectedCadreID;
  String _searchQuery = '';

  // Get the current cadre ID if the worker already has one
  String? get _currentCadreID {
    if (widget.worker['cadID'] != null) {
      return widget.worker['cadID'].toString();
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    _fetchCadres();
  }

  // Fetch cadres from API
  Future<void> _fetchCadres() async {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    try {
      // Get the authentication token
      final token = await LoginApi.getAuthToken();
      if (token == null) {
        throw Exception('User not authenticated');
      }

      final response = await http
          .get(
            Uri.parse('http://127.0.0.1:8000/api/v1/cadres'),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['data'] == null) {
          throw Exception('Invalid response format: missing data field');
        }

        final List<dynamic> cadresData = data['data'];
        if (cadresData.isEmpty) {
          setState(() {
            _cadres = [];
            _filteredCadres = [];
          });
          return;
        }

        // Convert to List<Map<String, dynamic>>
        _cadres =
            cadresData.map((cadre) {
              if (cadre is! Map<String, dynamic>) {
                throw Exception('Invalid cadre data format');
              }
              return cadre;
            }).toList();

        // Filter out the current cadre if worker already has one
        if (_currentCadreID != null) {
          _cadres =
              _cadres
                  .where(
                    (cadre) => cadre['cadID'].toString() != _currentCadreID,
                  )
                  .toList();
        }

        _filteredCadres = List.from(_cadres);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in again');
      } else if (response.statusCode == 500) {
        final errorData = json.decode(response.body);
        throw Exception(
          errorData['message'] ?? 'Server error occurred while fetching cadres',
        );
      } else {
        throw Exception('Failed to load cadres: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        _hasError = true;
        _errorMessage = e.toString();
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Filter cadres based on search query
  void _filterCadres(String query) {
    if (!mounted) return;

    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCadres = List.from(_cadres);
      } else {
        final searchTerm = query.toLowerCase();
        _filteredCadres =
            _cadres.where((cadre) {
              // Safely get and convert values to lowercase strings
              final name = (cadre['name'] ?? '').toString().toLowerCase();
              final description =
                  (cadre['description'] ?? '').toString().toLowerCase();
              final qualification =
                  (cadre['qualification'] ?? '').toString().toLowerCase();

              // Check if any field contains the search term
              return name.contains(searchTerm) ||
                  description.contains(searchTerm) ||
                  qualification.contains(searchTerm);
            }).toList();
      }
    });
  }

  // Assign cadre to health worker - Updated to match Laravel backend
  Future<void> _assignCadre() async {
    if (_selectedCadreID == null) {
      CustomSnackBar.showError(context, 'Please select a cadre');
      return;
    }

    setState(() {
      _isAssigning = true;
    });

    try {
      // Get the authentication token
      final token = await LoginApi.getAuthToken();
      if (token == null) {
        throw Exception('User not authenticated');
      }

      final response = await http
          .post(
            Uri.parse(
              'http://127.0.0.1:8000/api/v1/healthworkers/${widget.worker['hwID']}/assign',
            ),
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
              'Authorization': 'Bearer $token',
            },
            body: json.encode({'cadID': int.parse(_selectedCadreID!)}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        CustomSnackBar.showSuccess(
          context,
          data['message'] ?? 'Cadre assigned successfully',
        );
        Navigator.pop(context, true);
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Please log in again');
      } else if (response.statusCode == 404) {
        final errorData = json.decode(response.body);
        throw Exception(
          errorData['message'] ?? 'Health worker or cadre not found',
        );
      } else if (response.statusCode == 422) {
        final errorData = json.decode(response.body);
        throw Exception(
          errorData['message'] ??
              'Health worker already assigned to this cadre',
        );
      } else {
        final errorData = json.decode(response.body);
        throw Exception(errorData['message'] ?? 'Failed to assign cadre');
      }
    } catch (e) {
      CustomSnackBar.showError(context, 'Error: ${e.toString()}');
    } finally {
      setState(() {
        _isAssigning = false;
      });
    }
  }

  // Navigate to add new cadre form
  void _navigateToAddCadre() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => AddCadreModal(
            isDarkMode: widget.isDarkMode,
            onCadreAdded: () {
              _fetchCadres(); // Refresh the cadre list
            },
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = widget.isDarkMode ? AppTheme.navy : Colors.white;
    final textColor = widget.isDarkMode ? Colors.white : Colors.black87;
    final accentColor =
        widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            // Header
            Container(
              padding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
              decoration: BoxDecoration(
                color:
                    widget.isDarkMode
                        ? AppTheme.navy.withOpacity(0.8)
                        : accentColor.withOpacity(0.1),
                borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Assign Cadre to ${widget.worker['name'] ?? 'Health Worker'}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: accentColor,
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close, color: accentColor),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ),

            // Content
            Expanded(
              child:
                  _isLoading
                      ? Center(
                        child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation<Color>(
                            accentColor,
                          ),
                        ),
                      )
                      : _hasError
                      ? _buildErrorView(accentColor, textColor)
                      : _buildFormContent(
                        accentColor,
                        textColor,
                        backgroundColor,
                      ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildErrorView(Color accentColor, Color textColor) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 60, color: accentColor),
            SizedBox(height: 16),
            Text(
              'Error loading cadres',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: textColor,
              ),
            ),
            SizedBox(height: 8),
            Text(
              _errorMessage,
              textAlign: TextAlign.center,
              style: TextStyle(color: textColor.withOpacity(0.7)),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _fetchCadres,
              style: ElevatedButton.styleFrom(backgroundColor: accentColor),
              child: Text('Retry'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFormContent(
    Color accentColor,
    Color textColor,
    Color backgroundColor,
  ) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Current cadre info (if any)
          if (_currentCadreID != null) ...[
            Container(
              padding: EdgeInsets.all(12),
              decoration: BoxDecoration(
                color:
                    widget.isDarkMode
                        ? Colors.blue.withOpacity(0.1)
                        : Colors.blue.withOpacity(0.05),
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: Colors.blue.withOpacity(0.3),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, color: Colors.blue),
                  SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'Worker is currently assigned to cadre: ${widget.worker['cadreName'] ?? 'Unknown'}',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],

          // Search field
          TextField(
            onChanged: _filterCadres,
            style: TextStyle(color: textColor),
            decoration: InputDecoration(
              hintText: 'Search cadres...',
              hintStyle: TextStyle(color: textColor.withOpacity(0.5)),
              prefixIcon: Icon(Icons.search, color: accentColor),
              filled: true,
              fillColor:
                  widget.isDarkMode
                      ? AppTheme.navy.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 16,
              ),
            ),
          ),
          SizedBox(height: 16),

          // Dropdown for cadres
          Container(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(
              color:
                  widget.isDarkMode
                      ? AppTheme.navy.withOpacity(0.5)
                      : Colors.grey.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: accentColor.withOpacity(0.3), width: 1),
            ),
            child: DropdownButtonHideUnderline(
              child: DropdownButton<String>(
                value: _selectedCadreID,
                hint: Text(
                  'Select a cadre',
                  style: TextStyle(color: textColor.withOpacity(0.5)),
                ),
                icon: Icon(Icons.arrow_drop_down, color: accentColor),
                isExpanded: true,
                dropdownColor: backgroundColor,
                style: TextStyle(color: textColor),
                items:
                    _filteredCadres.isEmpty
                        ? [
                          DropdownMenuItem<String>(
                            value: null,
                            child: Text(
                              _searchQuery.isEmpty
                                  ? 'No cadres available'
                                  : 'No results for "$_searchQuery"',
                              style: TextStyle(
                                color: textColor.withOpacity(0.5),
                              ),
                            ),
                          ),
                        ]
                        : _filteredCadres.map((cadre) {
                          return DropdownMenuItem<String>(
                            value: cadre['cadID'].toString(),
                            child: Text(
                              cadre['name'],
                              style: TextStyle(color: textColor),
                            ),
                          );
                        }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedCadreID = value;
                  });
                },
              ),
            ),
          ),

          SizedBox(height: 24),

          // Action buttons
          Row(
            children: [
              // Add New Cadre button
              Expanded(
                child: OutlinedButton.icon(
                  icon: Icon(Icons.add),
                  label: Text('Add New Cadre'),
                  onPressed: _navigateToAddCadre,
                  style: OutlinedButton.styleFrom(
                    foregroundColor: accentColor,
                    side: BorderSide(color: accentColor),
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                ),
              ),
              SizedBox(width: 12),

              // Assign button
              Expanded(
                child: ElevatedButton(
                  onPressed: _isAssigning ? null : _assignCadre,
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        widget.isDarkMode ? AppTheme.navy : AppTheme.amber,
                    padding: EdgeInsets.symmetric(vertical: 12),
                  ),
                  child:
                      _isAssigning
                          ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          )
                          : Text('Assign Cadre'),
                ),
              ),
            ],
          ),

          // View cadre details button
          if (_selectedCadreID != null) ...[
            SizedBox(height: 16),
            TextButton.icon(
              icon: Icon(Icons.info_outline),
              label: Text('View Cadre Details'),
              onPressed: () {
                // Find the selected cadre
                final selectedCadre = _cadres.firstWhere(
                  (cadre) => cadre['cadID'].toString() == _selectedCadreID,
                  orElse: () => {},
                );

                if (selectedCadre.isNotEmpty) {
                  _showCadreDetails(selectedCadre);
                }
              },
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
          ],
        ],
      ),
    );
  }

  void _showCadreDetails(Map<String, dynamic> cadre) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            backgroundColor: widget.isDarkMode ? AppTheme.navy : Colors.white,
            title: Text(
              cadre['name'] ?? 'Cadre Details',
              style: TextStyle(
                color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildDetailItem('ID', cadre['cadID'].toString()),
                  _buildDetailItem(
                    'Qualification',
                    cadre['qualification'] ?? 'N/A',
                  ),
                  _buildDetailItem(
                    'Description',
                    cadre['description'] ?? 'N/A',
                  ),
                  if (cadre['created_at'] != null)
                    _buildDetailItem(
                      'Created',
                      _formatDate(cadre['created_at']),
                    ),
                  if (cadre['updated_at'] != null)
                    _buildDetailItem(
                      'Updated',
                      _formatDate(cadre['updated_at']),
                    ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text(
                  'Close',
                  style: TextStyle(
                    color:
                        widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                  ),
                ),
              ),
            ],
          ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
              fontSize: 14,
            ),
          ),
          SizedBox(height: 4),
          Text(
            value,
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white : Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  String _formatDate(String dateString) {
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString;
    }
  }
}
