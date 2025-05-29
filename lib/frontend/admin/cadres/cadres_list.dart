import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/cadres/cadres_api.dart';
import 'package:wellnessbridge/frontend/admin/cadres/add_cadre.dart';
import 'package:wellnessbridge/frontend/admin/cadres/edit_cadre.dart';

class CadresList extends StatefulWidget {
  const CadresList({super.key});

  @override
  _CadresListState createState() => _CadresListState();
}

class _CadresListState extends State<CadresList> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _cadres = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool _hasMorePages = true;

  @override
  void initState() {
    super.initState();
    _loadCadres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadCadres() async {
    if (_isLoading) return;

    setState(() => _isLoading = true);

    try {
      final response = await CadresApi.getCadres(
        page: _currentPage,
        itemsPerPage: _itemsPerPage,
      );

      setState(() {
        // Handle both paginated and non-paginated responses
        if (response['data'] is List) {
          _cadres = List<Map<String, dynamic>>.from(response['data']);
          _hasMorePages = false;
        } else {
          _cadres = List<Map<String, dynamic>>.from(response['data']['data']);
          _hasMorePages =
              response['data']['current_page'] < response['data']['last_page'];
        }
      });
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, e.toString());
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  Future<void> _deleteCadre(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text('Are you sure you want to delete this cadre?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed != true) return;

    try {
      await CadresApi.deleteCadre(id);
      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Cadre deleted successfully');
        _loadCadres(); // Reload the list after deletion
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, e.toString());
      }
    }
  }

  Widget _buildDetailRow(String label, String value, bool isDarkMode) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: isDarkMode ? AppTheme.amber : AppTheme.navy,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                color: isDarkMode ? Colors.white70 : Colors.black87,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _viewCadreDetails(Map<String, dynamic> cadre) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    showDialog(
      context: context,
      builder:
          (context) => Dialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.4,
              padding: const EdgeInsets.all(16),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    cadre['name'] ?? 'No Name',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: isDarkMode ? AppTheme.amber : AppTheme.navy,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildDetailRow(
                    'Description',
                    cadre['description'] ?? 'N/A',
                    isDarkMode,
                  ),
                  _buildDetailRow(
                    'Qualification',
                    cadre['qualification'] ?? 'N/A',
                    isDarkMode,
                  ),
                  _buildDetailRow(
                    'Created At',
                    _formatDate(cadre['created_at']),
                    isDarkMode,
                  ),
                  _buildDetailRow(
                    'Updated At',
                    _formatDate(cadre['updated_at']),
                    isDarkMode,
                  ),
                  const SizedBox(height: 16),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text(
                        'Close',
                        style: TextStyle(
                          color:
                              isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
    );
  }

  String _formatDate(String? dateStr) {
    if (dateStr == null) return 'N/A';
    try {
      final date = DateTime.parse(dateStr);
      return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute}';
    } catch (e) {
      return 'Invalid Date';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: const Text('Cadres'),
        backgroundColor: isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        foregroundColor: isDarkMode ? AppTheme.amber : Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    style: TextStyle(
                      color: isDarkMode ? Colors.white : Colors.black87,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Search cadres...',
                      hintStyle: TextStyle(
                        color:
                            isDarkMode
                                ? Colors.white.withOpacity(0.6)
                                : Colors.black54,
                      ),
                      prefixIcon: Icon(
                        Icons.search,
                        color: isDarkMode ? AppTheme.amber : AppTheme.blue,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
                          width: 2,
                        ),
                      ),
                      filled: true,
                      fillColor:
                          isDarkMode
                              ? AppTheme.navy.withOpacity(0.5)
                              : Colors.grey.withOpacity(0.1),
                    ),
                    onChanged: (value) {
                      setState(() {
                        // Implement search functionality
                        if (value.isEmpty) {
                          _loadCadres();
                        } else {
                          _cadres =
                              _cadres.where((cadre) {
                                final name =
                                    cadre['name']?.toString().toLowerCase() ??
                                    '';
                                final description =
                                    cadre['description']
                                        ?.toString()
                                        .toLowerCase() ??
                                    '';
                                final qualification =
                                    cadre['qualification']
                                        ?.toString()
                                        .toLowerCase() ??
                                    '';
                                final searchLower = value.toLowerCase();
                                return name.contains(searchLower) ||
                                    description.contains(searchLower) ||
                                    qualification.contains(searchLower);
                              }).toList();
                        }
                      });
                    },
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => AddCadre(isDarkMode: isDarkMode),
                      ),
                    );
                    if (result == true) {
                      _loadCadres();
                    }
                  },
                  icon: const Icon(Icons.add, color: Colors.white),
                  label: const Text('Add Cadre'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _isLoading
                    ? const Center(child: CircularProgressIndicator())
                    : _cadres.isEmpty
                    ? Center(
                      child: Text(
                        'No cadres found',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black54,
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _cadres.length + (_hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _cadres.length) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ElevatedButton(
                                onPressed: () {
                                  _currentPage++;
                                  _loadCadres();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      isDarkMode
                                          ? AppTheme.blue
                                          : AppTheme.rustOrange,
                                  foregroundColor: Colors.white,
                                ),
                                child: const Text('Load More'),
                              ),
                            ),
                          );
                        }

                        final cadre = _cadres[index];
                        return Container(
                          width: MediaQuery.of(context).size.width * 0.4,
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Card(
                            color: isDarkMode ? AppTheme.navy : Colors.white,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor:
                                            isDarkMode
                                                ? AppTheme.amber
                                                : AppTheme.blue,
                                        foregroundColor: Colors.white,
                                        child: Text(
                                          (cadre['name']?[0] ?? '?')
                                              .toUpperCase(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cadre['name'] ?? 'No Name',
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize:
                                                    AppTheme.subtitleFontSize,
                                                color:
                                                    isDarkMode
                                                        ? AppTheme.amber
                                                        : AppTheme.navy,
                                              ),
                                            ),
                                            Text(
                                              cadre['qualification'] ??
                                                  'No Qualification',
                                              style: TextStyle(
                                                fontSize: AppTheme.bodyFontSize,
                                                color:
                                                    isDarkMode
                                                        ? Colors.white70
                                                        : Colors.black87,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    cadre['description'] ??
                                        'No description provided.',
                                    style: TextStyle(
                                      fontSize: AppTheme.bodyFontSize,
                                      color:
                                          isDarkMode
                                              ? Colors.white70
                                              : Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      TextButton.icon(
                                        onPressed:
                                            () => _viewCadreDetails(cadre),
                                        icon: Icon(
                                          Icons.visibility,
                                          color:
                                              isDarkMode
                                                  ? AppTheme.blue
                                                  : AppTheme.rustOrange,
                                        ),
                                        label: Text(
                                          'View',
                                          style: TextStyle(
                                            color:
                                                isDarkMode
                                                    ? AppTheme.blue
                                                    : AppTheme.rustOrange,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        onPressed: () async {
                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => EditCadre(
                                                    cadre: cadre,
                                                    isDarkMode: isDarkMode,
                                                  ),
                                            ),
                                          );
                                          if (result == true) {
                                            _loadCadres();
                                          }
                                        },
                                        icon: Icon(
                                          Icons.edit,
                                          color:
                                              isDarkMode
                                                  ? AppTheme.amber
                                                  : AppTheme.blue,
                                        ),
                                        label: Text(
                                          'Edit',
                                          style: TextStyle(
                                            color:
                                                isDarkMode
                                                    ? AppTheme.amber
                                                    : AppTheme.blue,
                                          ),
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      TextButton.icon(
                                        onPressed:
                                            () => _deleteCadre(cadre['cadID']),
                                        icon: const Icon(
                                          Icons.delete,
                                          color: Colors.red,
                                        ),
                                        label: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
