import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:health_assistant_app/backend_api/health_worker_detail_screen.dart'
    show HealthWorkerDetailScreen;
import 'package:http/http.dart' as http;
import 'package:health_assistant_app/theme/theme.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';

class HealthWorkerService {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1/healthworkers';

  Future<List<dynamic>> fetchAllHealthWorkers() async {
    try {
      final response = await http.get(Uri.parse(baseUrl));

      if (response.statusCode == 200) {
        Map<String, dynamic> responseData = jsonDecode(response.body);
        // Assuming the API returns data in a 'data' field that contains a list
        return responseData['data'] as List<dynamic>;
      } else {
        throw Exception(
          'Failed to load health workers: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error fetching health workers: $e');
    }
  }

  // Method to delete a health worker (to be implemented)
  Future<bool> deleteHealthWorker(String workerId) async {
    try {
      final response = await http.delete(Uri.parse('$baseUrl/$workerId'));

      return response.statusCode == 200;
    } catch (e) {
      throw Exception('Error deleting health worker: $e');
    }
  }
}

// Widget to display all health workers in a table
class HealthWorkersTable extends StatefulWidget {
  const HealthWorkersTable({Key? key}) : super(key: key);

  @override
  _HealthWorkersTableState createState() => _HealthWorkersTableState();
}

class _HealthWorkersTableState extends State<HealthWorkersTable> {
  final HealthWorkerService _service = HealthWorkerService();
  late Future<List<dynamic>> _healthWorkers;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _healthWorkers = _service.fetchAllHealthWorkers();
  }

  // Refresh the list of health workers
  Future<void> _refreshHealthWorkers() async {
    setState(() {
      _isLoading = true;
      _healthWorkers = _service.fetchAllHealthWorkers();
    });
    await _healthWorkers;
    setState(() {
      _isLoading = false;
    });
  }

  // Handle delete action
  Future<void> _handleDelete(
    BuildContext context,
    String workerId,
    String workerName,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirm Delete',
              style: TextStyle(
                color: AppTheme.rustOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to delete $workerName?',
              style: TextStyle(color: AppTheme.sage),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel', style: TextStyle(color: AppTheme.sage)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Delete',
                  style: TextStyle(color: AppTheme.rustOrange),
                ),
              ),
            ],
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );

    if (confirmed == true) {
      setState(() => _isLoading = true);

      try {
        final success = await _service.deleteHealthWorker(workerId);
        if (success) {
          context.showSuccessSnackBar('Health worker deleted successfully');
          _refreshHealthWorkers();
        } else {
          context.showErrorSnackBar('Failed to delete health worker');
        }
      } catch (e) {
        context.showErrorSnackBar('Error: ${e.toString()}');
      } finally {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<dynamic>>(
      future: _healthWorkers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting || _isLoading) {
          return Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppTheme.rustOrange),
            ),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: AppTheme.rustOrange, size: 60),
                SizedBox(height: 16),
                Text(
                  'Error: ${snapshot.error}',
                  style: TextStyle(color: AppTheme.sage),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _refreshHealthWorkers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.rustOrange,
                  ),
                  child: Text('Retry', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.person_off, color: AppTheme.sage, size: 60),
                SizedBox(height: 16),
                Text(
                  'No health workers found',
                  style: TextStyle(color: AppTheme.sage, fontSize: 18),
                ),
                SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _refreshHealthWorkers,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.rustOrange,
                  ),
                  child: Text('Refresh', style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
          );
        }

        final healthWorkers = snapshot.data!;

        // For smaller screens, use a ListView with Cards
        return RefreshIndicator(
          onRefresh: _refreshHealthWorkers,
          color: AppTheme.rustOrange,
          child: ListView.builder(
            physics: AlwaysScrollableScrollPhysics(),
            padding: EdgeInsets.all(16),
            itemCount: healthWorkers.length + 1, // +1 for the header
            itemBuilder: (context, index) {
              if (index == 0) {
                // Header
                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Text(
                    'Health Workers',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.rustOrange,
                    ),
                  ),
                );
              }

              final worker = healthWorkers[index - 1];

              return Card(
                margin: EdgeInsets.only(bottom: 16),
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              worker['name'] ?? 'N/A',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppTheme.rustOrange,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                icon: Icon(
                                  Icons.edit,
                                  color: AppTheme.sage,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _navigateToEditScreen(context, worker);
                                },
                              ),
                              IconButton(
                                icon: Icon(
                                  Icons.delete,
                                  color: AppTheme.rustOrange,
                                  size: 20,
                                ),
                                onPressed: () {
                                  _handleDelete(
                                    context,
                                    worker['hwID'].toString(),
                                    worker['name'],
                                  );
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                      Divider(color: AppTheme.mintGreen),
                      SizedBox(height: 8),
                      _buildInfoRow(
                        Icons.work,
                        'Role',
                        worker['role'] ?? 'N/A',
                      ),
                      _buildInfoRow(
                        Icons.phone,
                        'Phone',
                        worker['telephone'] ?? 'N/A',
                      ),
                      _buildInfoRow(
                        Icons.email,
                        'Email',
                        worker['email'] ?? 'N/A',
                      ),
                      _buildInfoRow(
                        Icons.location_on,
                        'Address',
                        worker['address'] ?? 'N/A',
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 16, color: AppTheme.sage),
          SizedBox(width: 8),
          Text(
            '$label: ',
            style: TextStyle(fontWeight: FontWeight.bold, color: AppTheme.sage),
          ),
          Expanded(
            child: Text(
              value,
              style: TextStyle(color: Colors.black87),
              overflow: TextOverflow.ellipsis,
              maxLines: 2,
            ),
          ),
        ],
      ),
    );
  }

  // Navigation methods for view and edit actions
  void _navigateToViewScreen(
    BuildContext context,
    Map<String, dynamic> worker,
  ) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => HealthWorkerDetailScreen(workerId: worker['hwID']),
      ),
    );
  }

  void _navigateToEditScreen(
    BuildContext context,
    Map<String, dynamic> worker,
  ) {
    // TODO: Replace with actual edit screen navigation
    context.showSuccessSnackBar(
      'Edit functionality coming soon for ${worker['name']}',
    );

    // Uncomment when edit screen is ready:
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => EditWorkerScreen(
    //       workerId: worker['hwID'].toString(),
    //     ),
    //   ),
    // );
  }
}
