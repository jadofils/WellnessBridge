import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/birth_property/get_birth_property_api.dart';
import 'package:wellnessbridge/backend_api/birth_property/search_birth_property_api.dart';
import 'package:wellnessbridge/backend_api/birth_property/delete_birth_property_api.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'dart:async';
import 'package:wellnessbridge/frontend/admin/birth_property/view_birth_property.dart';
import 'package:wellnessbridge/frontend/admin/birth_property/edit_birth_property.dart';

class BirthPropertyList extends StatefulWidget {
  const BirthPropertyList({super.key});

  @override
  State<BirthPropertyList> createState() => _BirthPropertyListState();
}

class _BirthPropertyListState extends State<BirthPropertyList> {
  bool _isLoading = true;
  List<dynamic> _properties = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  final TextEditingController _searchController = TextEditingController();
  bool _isDarkMode = false;
  Timer? _debounce;
  bool _hasNextPage = true;

  @override
  void initState() {
    super.initState();
    _loadProperties();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> _loadProperties() async {
    try {
      setState(() => _isLoading = true);
      final response = await GetBirthPropertyApi.getBirthProperties(
        page: _currentPage,
        perPage: _itemsPerPage,
      );
      setState(() {
        _properties = response['data']['data'] ?? [];
        _hasNextPage = response['data']['next_page_url'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to load properties: $e');
    }
  }

  Future<void> _searchProperties(String query) async {
    if (query.isEmpty) {
      setState(() => _currentPage = 1);
      await _loadProperties();
      return;
    }

    try {
      setState(() => _isLoading = true);
      final response = await SearchBirthPropertyApi.searchBirthProperties(
        query,
      );
      setState(() {
        _properties = response['data']['data'] ?? [];
        _hasNextPage = response['data']['next_page_url'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to search properties: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchProperties(query);
    });
  }

  Future<void> _deleteProperty(int id) async {
    final bool? confirm = await showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          title: Row(
            children: [
              Icon(Icons.warning_amber_rounded, color: AppTheme.rustOrange),
              const SizedBox(width: 8),
              Text(
                'Delete Birth Property',
                style: TextStyle(
                  color: AppTheme.navy,
                  fontSize: AppTheme.subtitleFontSize,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete this birth property? This action cannot be undone.',
            style: TextStyle(
              color: AppTheme.blue,
              fontSize: AppTheme.bodyFontSize,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: AppTheme.blue,
                  fontSize: AppTheme.buttonFontSize,
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(true),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.rustOrange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Text(
                'Delete',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: AppTheme.buttonFontSize,
                ),
              ),
            ),
          ],
        );
      },
    );

    if (confirm == true) {
      try {
        await DeleteBirthPropertyApi.deleteBirthProperty(id);
        if (mounted) {
          CustomSnackBar.showSuccess(
            context,
            'Birth property deleted successfully',
          );
          _loadProperties(); // Refresh the list
        }
      } catch (e) {
        if (mounted) {
          CustomSnackBar.showError(
            context,
            'Failed to delete birth property: $e',
          );
        }
      }
    }
  }

  void _navigateToAddEditForm(
    BuildContext context, {
    int? birthPropertyId,
    int? childId,
  }) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditBirthProperty(
              birthPropertyId: birthPropertyId ?? 0,
              childId: childId,
            ),
      ),
    );

    if (result == true) {
      _loadProperties();
    }
  }

  @override
  Widget build(BuildContext context) {
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor:
            _isDarkMode
                ? AppTheme.nightBackgroundColor
                : AppTheme.sunBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Birth Properties',
            style: TextStyle(
              color: Colors.white,
              fontSize: AppTheme.titleFontSize,
              fontWeight: FontWeight.bold,
            ),
          ),
          backgroundColor: _isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
          elevation: 0,
          actions: [
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.light_mode : Icons.dark_mode,
                color: Colors.white,
              ),
              onPressed: () => setState(() => _isDarkMode = !_isDarkMode),
            ),
            const SizedBox(width: 8),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _navigateToAddEditForm(context),
          backgroundColor: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          child: const Icon(Icons.add, color: Colors.white),
        ),
        body:
            _isLoading
                ? Center(
                  child: CircularProgressIndicator(
                    color: _isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
                  ),
                )
                : _properties.isEmpty
                ? Center(
                  child: Text(
                    'No birth properties found',
                    style: TextStyle(
                      fontSize: AppTheme.bodyFontSize,
                      color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
                    ),
                  ),
                )
                : ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: _properties.length,
                  itemBuilder: (context, index) {
                    final property = _properties[index];
                    return Card(
                      elevation: 2,
                      margin: const EdgeInsets.only(bottom: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      color: _isDarkMode ? AppTheme.navy : Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Birth Property #${property['id']}',
                                  style: TextStyle(
                                    fontSize: AppTheme.subtitleFontSize,
                                    fontWeight: FontWeight.bold,
                                    color:
                                        _isDarkMode
                                            ? AppTheme.amber
                                            : AppTheme.navy,
                                  ),
                                ),
                                Row(
                                  children: [
                                    IconButton(
                                      icon: Icon(
                                        Icons.edit,
                                        color:
                                            _isDarkMode
                                                ? AppTheme.amber
                                                : AppTheme.blue,
                                      ),
                                      onPressed:
                                          () => _navigateToAddEditForm(
                                            context,
                                            birthPropertyId: property['id'],
                                          ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.delete,
                                        color: AppTheme.rustOrange,
                                      ),
                                      onPressed:
                                          () => _deleteProperty(property['id']),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            _buildInfoRow(
                              'Mother Age',
                              '${property['motherAge']}',
                            ),
                            _buildInfoRow(
                              'Father Age',
                              '${property['fatherAge']}',
                            ),
                            _buildInfoRow(
                              'Number of Children',
                              '${property['numberOfChildren']}',
                            ),
                            _buildInfoRow(
                              'Birth Type',
                              property['birthType'] ?? 'N/A',
                            ),
                            _buildInfoRow(
                              'Birth Weight',
                              '${property['birthWeight']} kg',
                            ),
                            _buildInfoRow(
                              'Child Condition',
                              property['childCondition'] ?? 'N/A',
                            ),
                            if (property['child'] != null) ...[
                              const SizedBox(height: 16),
                              Text(
                                'Child Information',
                                style: TextStyle(
                                  fontSize: AppTheme.subtitleFontSize,
                                  fontWeight: FontWeight.bold,
                                  color:
                                      _isDarkMode
                                          ? AppTheme.amber
                                          : AppTheme.navy,
                                ),
                              ),
                              const SizedBox(height: 8),
                              _buildInfoRow(
                                'Child Name',
                                property['child']['name'] ?? 'N/A',
                              ),
                              _buildInfoRow(
                                'Gender',
                                property['child']['gender'] ?? 'N/A',
                              ),
                              _buildInfoRow(
                                'Date of Birth',
                                property['child']['dateOfBirth'] ?? 'N/A',
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  },
                ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '$label: ',
            style: TextStyle(
              fontSize: AppTheme.bodyFontSize,
              fontWeight: FontWeight.bold,
              color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(
                fontSize: AppTheme.bodyFontSize,
                color: _isDarkMode ? Colors.white70 : AppTheme.blue,
              ),
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }
}
