import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/children/view_children_api.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/frontend/admin/children/edit_children.dart';

class ViewChild extends StatefulWidget {
  final int childId;

  const ViewChild({Key? key, required this.childId}) : super(key: key);

  @override
  State<ViewChild> createState() => _ViewChildState();
}

class _ViewChildState extends State<ViewChild> {
  bool _isLoading = true;
  Map<String, dynamic>? _childData;
  // Initialize _isDarkMode based on system theme preference
  bool _isDarkMode = false;

  @override
  void initState() {
    super.initState();
    _loadChildData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Update _isDarkMode when the theme changes (e.g., system theme switch)
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> _loadChildData() async {
    try {
      setState(() => _isLoading = true);
      final response = await ViewChildrenApi.getChildById(widget.childId);
      setState(() {
        _childData = response['data'];
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to load child details: $e');
    }
  }

  // --- Start of Changes ---

  @override
  Widget build(BuildContext context) {
    // We already initialize _isDarkMode in didChangeDependencies
    // and toggle it with setState, so this line is redundant here.
    // _isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Theme(
      // Apply the theme based on _isDarkMode state
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor:
            _isDarkMode
                ? AppTheme.nightBackgroundColor
                : AppTheme.sunBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Child Details',
            style: TextStyle(
              color:
                  Colors.white, // AppBar title color remains white for contrast
              fontSize: AppTheme.titleFontSize,
            ),
          ),
          backgroundColor: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back,
              color: Colors.white, // Keep back arrow white for consistency
            ),
            onPressed: () => Navigator.pop(context),
          ),
          actions: [
            // Night mode toggle button
            IconButton(
              icon: Icon(
                _isDarkMode ? Icons.wb_sunny : Icons.nightlight_round,
                color: Colors.white, // Icon color remains white
              ),
              onPressed: () {
                setState(() {
                  _isDarkMode = !_isDarkMode; // Toggle the dark mode state
                });
              },
              tooltip:
                  _isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
            ),
            // Cancel button
            IconButton(
              icon: Icon(
                Icons.cancel,
                color: Colors.white, // Cancel icon color remains white
              ),
              onPressed: () {
                // Handle cancel action, e.g., navigate back or clear form
                Navigator.pop(context); // Example: Pop the current route
                CustomSnackBar.showSuccess(context, 'Operation cancelled.');
              },
              tooltip: 'Cancel',
            ),
          ],
        ),
        body:
            _isLoading
                ? Center(
                  child: CircularProgressIndicator(color: AppTheme.rustOrange),
                )
                : Center(
                  child: Padding(
                    // Added Padding for top margin
                    padding: const EdgeInsets.only(
                      top: 24.0,
                    ), // Adjust top margin as needed
                    child: SizedBox(
                      width: 600,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        color: _isDarkMode ? AppTheme.navy : Colors.white,
                        child: SingleChildScrollView(
                          child: Padding(
                            padding: const EdgeInsets.all(24.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                if (_childData?['image'] != null)
                                  Align(
                                    alignment: Alignment.center,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: Image.network(
                                        _childData!['image'],
                                        height: 200,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                        errorBuilder: (
                                          context,
                                          error,
                                          stackTrace,
                                        ) {
                                          return Container(
                                            height: 200,
                                            color: AppTheme.blue.withOpacity(
                                              0.1,
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              size: 64,
                                              color: AppTheme.blue,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                const SizedBox(height: 24),
                                _buildSection('Basic Information', [
                                  _buildInfoRow(
                                    'ID',
                                    '#${_childData?['childID']}',
                                  ),
                                  _buildInfoRow(
                                    'Name',
                                    _childData?['name'] ?? 'N/A',
                                  ),
                                  _buildInfoRow(
                                    'Gender',
                                    _childData?['gender'] ?? 'N/A',
                                  ),
                                  _buildInfoRow(
                                    'Date of Birth',
                                    _childData?['dob'] ?? 'N/A',
                                  ),
                                ]),
                                const SizedBox(height: 24),
                                _buildSection('Parent Information', [
                                  _buildInfoRow(
                                    'Parent Name',
                                    _childData?['parentName'] ?? 'N/A',
                                  ),
                                  _buildInfoRow(
                                    'Parent Contact',
                                    _childData?['parentContact'] ?? 'N/A',
                                  ),
                                ]),
                                if (_childData?['address'] != null) ...[
                                  const SizedBox(height: 24),
                                  _buildSection('Address', [
                                    Text(
                                      _childData!['address'],
                                      style: TextStyle(
                                        fontSize: AppTheme.bodyFontSize,
                                        color:
                                            _isDarkMode
                                                ? Colors.white70
                                                : AppTheme.blue,
                                      ),
                                    ),
                                  ]),
                                ],
                                const SizedBox(height: 24),
                                _buildSection('Additional Information', [
                                  _buildInfoRow(
                                    'Created',
                                    _childData?['created_at'] ?? 'N/A',
                                  ),
                                  _buildInfoRow(
                                    'Last Updated',
                                    _childData?['updated_at'] ?? 'N/A',
                                  ),
                                  if (_childData?['birth_property'] != null)
                                    _buildInfoRow(
                                      'Birth Property',
                                      _childData!['birth_property'],
                                    ),
                                ]),
                                const SizedBox(height: 32),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    ElevatedButton.icon(
                                      onPressed: () async {
                                        try {
                                          print(
                                            'Edit button pressed for child ID: ${_childData?['childID']}',
                                          );
                                          print(
                                            'Current child data: $_childData',
                                          );

                                          final result = await Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder:
                                                  (context) => EditChildren(
                                                    childData: _childData!,
                                                  ),
                                            ),
                                          );

                                          print('Edit result: $result');

                                          if (result == true) {
                                            print(
                                              'Edit was successful, refreshing data...',
                                            );
                                            // Refresh the data after successful edit
                                            await _loadChildData();
                                            print(
                                              'Data refreshed successfully',
                                            );
                                            print(
                                              'Updated child data: $_childData',
                                            );

                                            CustomSnackBar.showSuccess(
                                              context,
                                              'Child details updated successfully',
                                            );
                                          } else {
                                            print(
                                              'Edit was cancelled or failed',
                                            );
                                          }
                                        } catch (e) {
                                          print(
                                            'Error during edit process: $e',
                                          );
                                          CustomSnackBar.showError(
                                            context,
                                            'Failed to update child: $e',
                                          );
                                        }
                                      },
                                      icon: const Icon(Icons.edit),
                                      label: const Text('Edit'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.rustOrange,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        CustomSnackBar.showSuccess(
                                          context,
                                          'View Properties button pressed!',
                                        );
                                      },
                                      icon: const Icon(Icons.info),
                                      label: const Text('Properties'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.blue,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                    ElevatedButton.icon(
                                      onPressed: () {
                                        CustomSnackBar.showSuccess(
                                          context,
                                          'Health Records button pressed!',
                                        );
                                      },
                                      icon: const Icon(Icons.medical_services),
                                      label: const Text('Health Records'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppTheme.navy,
                                        foregroundColor: Colors.white,
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 16,
                                          vertical: 12,
                                        ),
                                        textStyle: const TextStyle(
                                          fontSize: 16,
                                        ),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
      ),
    );
  }

  Widget _buildSection(String title, List<Widget> children) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: AppTheme.subtitleFontSize,
            fontWeight: FontWeight.bold,
            color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
          ),
        ),
        const SizedBox(height: 12),
        ...children,
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
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
            ),
          ),
        ],
      ),
    );
  }
}
