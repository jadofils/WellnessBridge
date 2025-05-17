// lib/screens/health_worker_detail_screen.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:health_assistant_app/theme/theme.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';

class HealthWorkerDetailScreen extends StatefulWidget {
  final String workerId;
  
  const HealthWorkerDetailScreen({
    Key? key, 
    required this.workerId,
  }) : super(key: key);

  @override
  _HealthWorkerDetailScreenState createState() => _HealthWorkerDetailScreenState();
}

class _HealthWorkerDetailScreenState extends State<HealthWorkerDetailScreen> {
  late Future<Map<String, dynamic>> _healthWorkerFuture;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _healthWorkerFuture = _fetchHealthWorker();
  }

  Future<Map<String, dynamic>> _fetchHealthWorker() async {
    final url = 'http://127.0.0.1:8000/api/v1/healthworkers/${widget.workerId}';
    
    try {
      final response = await http.get(Uri.parse(url));
      
      if (response.statusCode == 200) {
        return json.decode(response.body);
      } else {
        throw Exception('Failed to load health worker: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching health worker: $e');
    }
  }

  void _viewCadres(BuildContext context, Map<String, dynamic> worker) {
    if (worker['cadre'] == null) {
      context.showErrorSnackBar('No cadre information available');
      return;
    }
    
    // Navigate to cadre details screen or show cadre info
    // This is a placeholder - you would implement the actual navigation
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Cadre Information',
          style: TextStyle(
            color: AppTheme.rustOrange,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          'Cadre ID: ${worker['cadID']}\n'
          'Details: ${worker['cadre'] ?? 'No details available'}',
          style: TextStyle(color: AppTheme.sage),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Close',
              style: TextStyle(color: AppTheme.rustOrange),
            ),
          ),
        ],
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Health Worker Details',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        backgroundColor: AppTheme.rustOrange,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: FutureBuilder<Map<String, dynamic>>(
        future: _healthWorkerFuture,
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
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _healthWorkerFuture = _fetchHealthWorker();
                      });
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.rustOrange,
                    ),
                    child: Text('Retry', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            );
          } else if (!snapshot.hasData) {
            return Center(
              child: Text(
                'No data available',
                style: TextStyle(color: AppTheme.sage, fontSize: 18),
              ),
            );
          }

          final response = snapshot.data!;
          final worker = response['data'];
          final message = response['message'];

          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Success message
                  if (message != null)
                    Container(
                      width: double.infinity,
                      padding: EdgeInsets.all(12),
                      margin: EdgeInsets.only(bottom: 16),
                      decoration: BoxDecoration(
                        color: AppTheme.amber.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.rustOrange,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),

                  // Health worker profile card
                  _buildProfileCard(worker),
                  
                  SizedBox(height: 24),
                  
                  // Health worker details
                  _buildDetailsCard(worker),
                  
                  SizedBox(height: 24),
                  
                  // Action buttons
                  _buildActionButtons(context, worker),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileCard(Map<String, dynamic> worker) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Profile image or placeholder
            CircleAvatar(
              radius: 60,
              backgroundColor: AppTheme.mintGreen,
              child: worker['image'] != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.network(
                        worker['image'],
                        width: 120,
                        height: 120,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Icon(Icons.person, size: 60, color: AppTheme.sage);
                        },
                      ),
                    )
                  : Icon(Icons.person, size: 60, color: AppTheme.sage),
            ),
            SizedBox(height: 16),
            
            // Name
            Text(
              worker['name'] ?? 'N/A',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: AppTheme.rustOrange,
              ),
              textAlign: TextAlign.center,
            ),
            
            SizedBox(height: 8),
            
            // Role
            Container(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 6),
              decoration: BoxDecoration(
                color: AppTheme.amber.withOpacity(0.2),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                worker['role'] ?? 'N/A',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: AppTheme.rustOrange,
                ),
              ),
            ),
            
            SizedBox(height: 16),
            
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
    );
  }

  Widget _buildInfoItem(IconData icon, String text) {
    return Expanded(
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: AppTheme.sage, size: 18),
          SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: TextStyle(color: AppTheme.sage),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsCard(Map<String, dynamic> worker) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
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
                color: AppTheme.rustOrange,
              ),
            ),
            SizedBox(height: 16),
            
            // Details table
            Table(
              columnWidths: {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(2),
              },
              children: [
                _buildTableRow('ID', worker['hwID'].toString()),
                _buildTableRow('Name', worker['name'] ?? 'N/A'),
                _buildTableRow('Gender', worker['gender'] ?? 'N/A'),
                _buildTableRow('Date of Birth', worker['dob'] ?? 'N/A'),
                _buildTableRow('Role', worker['role'] ?? 'N/A'),
                _buildTableRow('Phone', worker['telephone'] ?? 'N/A'),
                _buildTableRow('Email', worker['email'] ?? 'N/A'),
                _buildTableRow('Address', worker['address'] ?? 'N/A'),
                _buildTableRow('Cadre ID', worker['cadID'].toString()),
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
              color: AppTheme.sage,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0),
          child: Text(
            value,
            style: TextStyle(color: Colors.black87),
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
      return dateString;
    }
  }

  Widget _buildActionButtons(BuildContext context, Map<String, dynamic> worker) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // View Cadres Button
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.badge, color: Colors.white),
            label: Text(
              'View Cadres',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () => _viewCadres(context, worker),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.amber,
              padding: EdgeInsets.symmetric(vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        
        SizedBox(width: 16),
        
        // Edit Button
        Expanded(
          child: ElevatedButton.icon(
            icon: Icon(Icons.edit, color: Colors.white),
            label: Text(
              'Edit Details',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              // Navigate to edit screen
              context.showSuccessSnackBar('Edit functionality will be implemented soon');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.sage,
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

// Example of how to use this screen:
// Navigator.push(
//   context,
//   MaterialPageRoute(
//     builder: (context) => HealthWorkerDetailScreen(workerId: '145'),
//   ),
// );