// lib/screens/health_workers/view_healthworker.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/health_workers/assign_health_cadre.dart';
// These imports might not be directly used in ViewHealthWorkerScreen,
// but kept for context if they are used elsewhere in your project
// import 'package:wellnessbridge/backend_api/health_workers/edit_healthworker.dart';
// import 'package:wellnessbridge/backend_api/health_workers/edit_profile.dart';
import 'package:wellnessbridge/theme/theme.dart';
// Ensure this import is correct for your custom snack bar
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:wellnessbridge/screens/health_workers/health_worker_profile_screen.dart'; // Correct screen for editing profile

class ViewHealthWorkerScreen extends StatefulWidget {
  final String workerId;
  final bool isDarkMode;

  const ViewHealthWorkerScreen({
    super.key,
    required this.workerId,
    required this.isDarkMode,
  });

  @override
  _ViewHealthWorkerScreenState createState() => _ViewHealthWorkerScreenState();
}

class _ViewHealthWorkerScreenState extends State<ViewHealthWorkerScreen> {
  // Use a nullable Map for _healthWorkerData as it's fetched asynchronously
  Map<String, dynamic>? _healthWorkerData;
  bool _isLoading = false;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    // Directly call the fetch method, and handle the result
    _fetchHealthWorker();
  }

  // Real API call to fetch health worker data
  Future<void> _fetchHealthWorker() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
      _healthWorkerData = null; // Clear previous data while loading
    });

    try {
      final Map<String, dynamic> response =
          await HealthWorkersApi.getHealthWorker(int.parse(widget.workerId));

      // --- CRUCIAL CORRECTION HERE ---
      // Access the 'data' key from the API response
      if (response.containsKey('data') && response['data'] != null) {
        // Ensure 'data' is treated as a Map<String, dynamic>
        _healthWorkerData = Map<String, dynamic>.from(response['data']);
        if (mounted) {
          setState(() {}); // Trigger a rebuild with the new data
        }
      } else {
        // Handle case where 'data' key might be missing or null
        _errorMessage = response['message'] ?? 'No health worker data found.';
      }
    } on TimeoutException catch (_) {
      _errorMessage =
          'Request timed out. Please check your connection and try again.';
    } on http.ClientException catch (e) {
      _errorMessage = 'Network error: ${e.message}';
    } catch (e) {
      _errorMessage = 'Error fetching health worker: $e';
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  // Method to refresh data after profile update (re-fetches the worker)
  void _refreshHealthWorkerData() {
    _fetchHealthWorker(); // Simply call the fetch method again
  }

  // Helper method to construct full image URL
  String? _getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;

    // If it's already a full URL (e.g., from an external source or direct URL from backend)
    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    String baseUrl = 'http://127.0.0.1:8000'; // Your Laravel API base URL

    // Normalize path to handle 'images/' or 'storage/images/'
    String normalizedPath = imagePath;
    if (normalizedPath.startsWith('/')) {
      normalizedPath = normalizedPath.substring(1);
    }
    if (normalizedPath.startsWith('storage/')) {
      normalizedPath = normalizedPath.replaceFirst('storage/', '');
    }

    // Construct the full URL.
    // It's common for Laravel to serve images from 'storage/app/public' via '/storage' symlink.
    // So, the URL often looks like 'baseUrl/storage/image_path_from_db'.
    return '$baseUrl/storage/$normalizedPath';
  }

  void _viewCadres(BuildContext context, Map<String, dynamic> worker) {
    if (worker['cadre'] == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('No cadre information available'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    var cadreData = worker['cadre'];
    bool isCadreObject = cadreData is Map;

    final StringBuffer detailsText = StringBuffer();
    // Access cadID directly from the worker object as it's at the top level
    detailsText.writeln('Cadre ID: ${worker['cadID'] ?? 'Not available'}');

    // Access cadre name from the nested 'cadre' object if it's a Map
    if (isCadreObject && cadreData['name'] != null) {
      detailsText.writeln('Cadre Name: ${cadreData['name']}');
    } else {
      // Fallback if 'cadre' isn't an object or 'name' is missing
      detailsText.writeln('Cadre Name: Not available');
    }

    // Iterate through other cadre details if 'cadreData' is a map
    if (isCadreObject) {
      cadreData.forEach((key, value) {
        if (key != 'name' &&
            key != 'cadID' &&
            key != 'created_at' &&
            key != 'updated_at') {
          // Avoid duplicating cadID and timestamps
          detailsText.writeln(
            '${_formatFieldName(key)}: ${value ?? 'Not available'}',
          );
        }
      });
    }

    // These fields (cadre_type, qualification, description) are nested within 'cadre' object
    // if they are coming from the 'cadre' relationship
    if (isCadreObject) {
      if (cadreData['qualification'] != null) {
        detailsText.writeln('Qualification: ${cadreData['qualification']}');
      }
      if (cadreData['description'] != null) {
        detailsText.writeln('Description: ${cadreData['description']}');
      }
    }

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            titlePadding: EdgeInsets.only(top: 4, left: 16, right: 16),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cadre Information',
                  style: TextStyle(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the current dialog
                    // Ensure showAssignCadreModal is properly imported and defined
                    showAssignCadreModal(context, worker, widget.isDarkMode);
                  },
                  child: Text('Assign Cadre'),
                ),
              ],
            ),
            content: SingleChildScrollView(
              child: Text(
                detailsText.toString(),
                style: TextStyle(
                  color: widget.isDarkMode ? Colors.white : AppTheme.navy,
                ),
              ),
            ),
            backgroundColor: widget.isDarkMode ? AppTheme.navy : Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
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

  String _formatFieldName(String fieldName) {
    // Convert snake_case or camelCase to Title Case with spaces
    final words = fieldName
        .replaceAllMapped(
          RegExp(r'([a-z0-9])([A-Z])'),
          (match) => '${match.group(1)} ${match.group(2)}',
        )
        .split(RegExp(r'[_\s]'));

    return words
        .map(
          (word) =>
              word.isEmpty
                  ? ''
                  : '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}',
        )
        .join(' ');
  }

  // The _navigateToEditScreen method is now redundant as you have a direct
  // navigation in _buildActionButtons. You can remove this or keep it
  // if you intend to use it for other edit scenarios.
  // void _navigateToEditScreen(
  //   BuildContext context,
  //   Map<String, dynamic> worker,
  // ) {
  //   context.showSuccessSnackBar(
  //     'Edit functionality coming soon for ${worker['name']}',
  //   );
  // }

  // Re-evaluating _retryFetch, it's essentially the same as _refreshHealthWorkerData
  // Consider consolidating to just one method if they do the same thing.
  // For now, let's just make it call _fetchHealthWorker()
  void _retryFetch() {
    _fetchHealthWorker();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:
          widget.isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Health Worker Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor:
            widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body:
          _isLoading
              ? _buildLoadingState() // Show loading state if _isLoading is true
              : _errorMessage.isNotEmpty
              ? _buildErrorState(
                _errorMessage,
              ) // Show error state if _errorMessage is set
              : _healthWorkerData == null
              ? _buildEmptyState() // Show empty state if no data and no error/loading
              : SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // You don't have a 'message' field directly accessible here from _healthWorkerData
                      // as _healthWorkerData only contains the worker object itself.
                      // If you need to show the original API message, you'd have to store it
                      // separately in _fetchHealthWorker. For now, removing the message display here.
                      // if (message != null) _buildSuccessMessage(message),

                      // Health worker profile card
                      _buildProfileCard(
                        _healthWorkerData!,
                      ), // Use ! as we've checked for null
                      SizedBox(height: 24),

                      // Health worker details
                      _buildDetailsCard(
                        _healthWorkerData!,
                      ), // Use ! as we've checked for null
                      SizedBox(height: 24),

                      // Action buttons
                      _buildActionButtons(
                        context,
                        _healthWorkerData!,
                      ), // Use ! as we've checked for null
                    ],
                  ),
                ),
              ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(
              widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
            ),
          ),
          SizedBox(height: 16),
          Text(
            'Loading health worker details...',
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white : AppTheme.navy,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorState(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, color: AppTheme.rustOrange, size: 60),
          SizedBox(height: 16),
          Text(
            'Error Loading Data',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? Colors.white : AppTheme.navy,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Text(
              error,
              style: TextStyle(
                color: widget.isDarkMode ? Colors.white70 : Colors.black87,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          SizedBox(height: 16),
          ElevatedButton(
            onPressed: _retryFetch,
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
            ),
            child: Text('Retry', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Text(
        'No data available',
        style: TextStyle(
          color: widget.isDarkMode ? Colors.white : AppTheme.navy,
          fontSize: 18,
        ),
      ),
    );
  }

  // Removed _buildSuccessMessage as the API response structure means
  // the 'message' is not part of the 'worker' data itself, which is
  // what's being passed to other build methods. You'd need to store
  // the message separately if you want to display it.

  Widget _buildProfileCard(Map<String, dynamic> worker) {
    // Ensure the image URL is a String and not null/empty
    final String? imagePath = worker['image'] as String?; // Cast directly
    final String? fullImageUrl = _getFullImageUrl(imagePath);

    ImageProvider? profileImageProvider;
    if (fullImageUrl != null) {
      profileImageProvider = NetworkImage(fullImageUrl);
    }

    return Card(
      elevation: 4,
      color: widget.isDarkMode ? AppTheme.navy.withOpacity(0.7) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // Profile image or placeholder
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: 60,
                      backgroundColor:
                          widget.isDarkMode
                              ? AppTheme.amber.withOpacity(0.2)
                              : AppTheme.amber.withOpacity(0.3),
                      backgroundImage: profileImageProvider,
                      onBackgroundImageError: (exception, stackTrace) {
                        debugPrint('Error loading image: $exception');
                      },
                      child:
                          profileImageProvider == null
                              ? Icon(
                                Icons.person,
                                size: 60,
                                color:
                                    widget.isDarkMode
                                        ? AppTheme.amber
                                        : AppTheme.navy,
                              )
                              : null,
                    ),
                    InkWell(
                      onTap: () {
                        // Navigates to HealthWorkerProfileScreen for editing,
                        // ensure it accepts workerId and has a refresh callback
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (context) => HealthWorkerProfileScreen(
                                  workerId:
                                      worker['hwID'].toString(), // Pass the ID
                                  isDarkMode: widget.isDarkMode,
                                  onProfileUpdated:
                                      _refreshHealthWorkerData, // Pass the refresh method
                                ),
                          ),
                        );
                      },
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color:
                              widget.isDarkMode
                                  ? AppTheme.blue
                                  : AppTheme.rustOrange,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Icon(
                          Icons.edit,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Name
                Text(
                  worker['name'] ?? 'N/A',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber
                            : AppTheme.rustOrange,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8),

                // Role
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color:
                        widget.isDarkMode
                            ? AppTheme.amber.withOpacity(0.1)
                            : AppTheme.amber.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    worker['role'] ?? 'N/A',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color:
                          widget.isDarkMode
                              ? AppTheme.amber
                              : AppTheme.rustOrange,
                    ),
                  ),
                ),
                const SizedBox(height: 16),

                // Quick info
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildInfoItem(Icons.phone, worker['telephone'] ?? 'N/A'),
                    _buildInfoItem(Icons.email, worker['email'] ?? 'N/A'),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Helper method for info items (if not already defined elsewhere)
  Widget _buildInfoItem(IconData icon, String value) {
    return Column(
      children: [
        Icon(
          icon,
          color: widget.isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(
            color: widget.isDarkMode ? Colors.white70 : Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _buildDetailsCard(Map<String, dynamic> worker) {
    return Card(
      elevation: 4,
      color: widget.isDarkMode ? AppTheme.navy.withOpacity(0.7) : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Personal Information',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
              ),
            ),
            SizedBox(height: 16),
            // Details table
            Table(
              columnWidths: {0: FlexColumnWidth(1), 1: FlexColumnWidth(2)},
              children: [
                _buildTableRow(
                  'ID',
                  worker['hwID']?.toString() ?? 'N/A',
                ), // Safely convert to string
                _buildTableRow('Name', worker['name'] ?? 'N/A'),
                _buildTableRow('Gender', worker['gender'] ?? 'N/A'),
                _buildTableRow('Date of Birth', worker['dob'] ?? 'N/A'),
                _buildTableRow('Role', worker['role'] ?? 'N/A'),
                _buildTableRow('Phone', worker['telephone'] ?? 'N/A'),
                _buildTableRow('Email', worker['email'] ?? 'N/A'),
                _buildTableRow('Address', worker['address'] ?? 'N/A'),
                _buildTableRow(
                  'Cadre ID',
                  worker['cadID']?.toString() ?? 'N/A',
                ), // Safely convert to string
                _buildTableRow('Created', _formatDate(worker['created_at'])),
                _buildTableRow('Updated', _formatDate(worker['updated_at'])),
              ],
            ),
          ],
        ),
      ),
    );
  }

  TableRow _buildTableRow(String label, String value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: widget.isDarkMode ? AppTheme.amber : AppTheme.navy,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: TextStyle(
              color: widget.isDarkMode ? Colors.white70 : AppTheme.navy,
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(String? dateString) {
    if (dateString == null) return 'N/A';
    try {
      final date = DateTime.parse(dateString);
      return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    } catch (e) {
      return dateString; // Return original string if parsing fails
    }
  }

  Widget _buildActionButtons(
    BuildContext context,
    Map<String, dynamic> worker,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // View Cadres Button
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.badge, color: Colors.white),
            label: Text('View Cadres', style: TextStyle(color: Colors.white)),
            onPressed: () => _viewCadres(context, worker),
            style: ElevatedButton.styleFrom(
              backgroundColor:
                  widget.isDarkMode ? AppTheme.blue : AppTheme.amber,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        // Edit Button (for profile details)
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.edit, color: Colors.white),
            label: Text('Edit Profile', style: TextStyle(color: Colors.white)),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (context) => HealthWorkerProfileScreen(
                        // This is the screen for editing the profile
                        workerId: worker['hwID'].toString(),
                        isDarkMode: widget.isDarkMode,
                        onProfileUpdated:
                            _refreshHealthWorkerData, // Pass the refresh callback
                      ),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.blue,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
