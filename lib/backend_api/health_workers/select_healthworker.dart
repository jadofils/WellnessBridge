import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_worker_profile_screen.dart';
import 'package:wellnessbridge/backend_api/health_workers/delete_healthworker.dart';
import 'package:wellnessbridge/backend_api/health_workers/assign_health_cadre.dart';

class SelectHealthWorkers extends StatefulWidget {
  final Function(Map<String, dynamic>) onView;
  final Function(Map<String, dynamic>) onEdit;
  final Function(String, String) onDelete;
  final Function() onAddNew;
  final bool isDarkMode;

  const SelectHealthWorkers({
    super.key,
    required this.onView,
    required this.onEdit,
    required this.onDelete,
    required this.onAddNew,
    required this.isDarkMode,
  });

  @override
  SelectHealthWorkersState createState() => SelectHealthWorkersState();
}

class SelectHealthWorkersState extends State<SelectHealthWorkers> {
  late Future<List<dynamic>> _healthWorkers;
  bool _isLoading = false;
  bool _hasError = false;
  String _errorMessage = '';
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _loadData();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    setState(() {
      _searchQuery = _searchController.text.toLowerCase();
    });
  }

  void _loadData() {
    setState(() {
      _isLoading = true;
      _hasError = false;
      _errorMessage = '';
    });

    _healthWorkers = _fetchAllHealthWorkers()
        .then((workers) => workers)
        .catchError((error) {
          setState(() {
            _hasError = true;
            _errorMessage = error.toString();
          });
          throw error;
        })
        .whenComplete(() {
          if (mounted) {
            setState(() {
              _isLoading = false;
            });
          }
        });
  }

  Future<List<dynamic>> _fetchAllHealthWorkers() async {
    try {
      final response = await HealthWorkersApi.getHealthWorkers();
      if (response.containsKey('data') && response['data'] != null) {
        return response['data'] as List<dynamic>;
      } else {
        throw Exception('Invalid response format: missing data field');
      }
    } catch (e) {
      throw Exception('Failed to load health workers: $e');
    }
  }

  String? _getFullImageUrl(String? imagePath) {
    if (imagePath == null || imagePath.isEmpty) return null;

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return imagePath;
    }

    String baseUrl = 'http://127.0.0.1:8000';
    String normalizedPath = imagePath;
    if (normalizedPath.startsWith('/')) {
      normalizedPath = normalizedPath.substring(1);
    }
    if (normalizedPath.startsWith('storage/')) {
      normalizedPath = normalizedPath.replaceFirst('storage/', '');
    }

    return '$baseUrl/storage/$normalizedPath';
  }

  List<dynamic> _getFilteredHealthWorkers(List<dynamic> workers) {
    if (_searchQuery.isEmpty) {
      return workers;
    }

    return workers.where((worker) {
      final name = worker['name']?.toString().toLowerCase() ?? '';
      final role = worker['role']?.toString().toLowerCase() ?? '';
      final email = worker['email']?.toString().toLowerCase() ?? '';
      final phone = worker['telephone']?.toString().toLowerCase() ?? '';
      final cadreName =
          worker['cadre']?['name']?.toString().toLowerCase() ?? '';

      return name.contains(_searchQuery) ||
          role.contains(_searchQuery) ||
          email.contains(_searchQuery) ||
          phone.contains(_searchQuery) ||
          cadreName.contains(_searchQuery);
    }).toList();
  }

  void _handleEdit(Map<String, dynamic> worker) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditProfileScreen(
              worker: worker,
              isDarkMode: widget.isDarkMode,
              isNewWorker: false,
              onProfileUpdated: _loadData,
            ),
      ),
    );

    if (result != null) {
      _loadData(); // Refresh the list after successful edit
    }
  }

  void _handleAddNew() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) => EditProfileScreen(
              worker: {}, // Empty map for new worker
              isDarkMode: widget.isDarkMode,
              isNewWorker: true,
              onProfileUpdated: _loadData,
            ),
      ),
    );

    if (result != null) {
      _loadData(); // Refresh the list after successful addition
    }
  }

  void _handleDelete(String workerId, String workerName) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('Delete Health Worker'),
            content: Text('Are you sure you want to delete $workerName?'),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: Text('Delete'),
              ),
            ],
          ),
    );

    if (confirmed == true) {
      await deleteHealthWorker(context, workerId, widget.isDarkMode, _loadData);
    }
  }

  void _handleAssignCadre(Map<String, dynamic> worker) {
    showAssignCadreModal(context, worker, widget.isDarkMode);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // Search and Add button
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    decoration: InputDecoration(
                      hintText: 'Search health workers...',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      filled: true,
                      fillColor:
                          widget.isDarkMode
                              ? Colors.grey[800]
                              : Colors.grey[200],
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline),
                  onPressed: _handleAddNew,
                  tooltip: 'Add New Health Worker',
                  color:
                      widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
                ),
              ],
            ),
          ),

          // Health Workers List
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => _loadData(),
              child: FutureBuilder<List<dynamic>>(
                future: _healthWorkers,
                builder: (context, snapshot) {
                  if (_isLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (_hasError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Error: $_errorMessage',
                            style: TextStyle(
                              color:
                                  widget.isDarkMode
                                      ? Colors.red[300]
                                      : Colors.red,
                            ),
                          ),
                          const SizedBox(height: 16),
                          ElevatedButton(
                            onPressed: _loadData,
                            child: Text('Retry'),
                          ),
                        ],
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text('No health workers found'),
                          const SizedBox(height: 16),
                          ElevatedButton.icon(
                            onPressed: _handleAddNew,
                            icon: const Icon(Icons.add),
                            label: const Text('Add New Health Worker'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor:
                                  widget.isDarkMode
                                      ? AppTheme.amber
                                      : AppTheme.rustOrange,
                            ),
                          ),
                        ],
                      ),
                    );
                  }

                  final filteredWorkers = _getFilteredHealthWorkers(
                    snapshot.data!,
                  );

                  return ListView.builder(
                    controller: _scrollController,
                    padding: const EdgeInsets.all(16),
                    itemCount: filteredWorkers.length,
                    itemBuilder: (context, index) {
                      final worker = filteredWorkers[index];
                      final imageUrl = _getFullImageUrl(worker['image']);

                      return Card(
                        elevation: 4,
                        margin: const EdgeInsets.only(bottom: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: InkWell(
                          onTap: () => widget.onView(worker),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // First Row: Image and Basic Info
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // Profile Image
                                    CircleAvatar(
                                      radius: 30,
                                      backgroundImage:
                                          imageUrl != null
                                              ? NetworkImage(imageUrl)
                                              : null,
                                      child:
                                          imageUrl == null
                                              ? const Icon(
                                                Icons.person,
                                                size: 30,
                                              )
                                              : null,
                                    ),
                                    const SizedBox(width: 16),
                                    // Basic Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            worker['name'] ?? 'N/A',
                                            style: const TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            worker['role'] ?? 'N/A',
                                            style: TextStyle(
                                              color:
                                                  widget.isDarkMode
                                                      ? Colors.grey[300]
                                                      : Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            worker['email'] ?? 'N/A',
                                            style: TextStyle(
                                              color:
                                                  widget.isDarkMode
                                                      ? Colors.grey[300]
                                                      : Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 16),
                                // Second Row: Contact Info and Actions
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    // Contact Info
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Phone: ${worker['telephone'] ?? 'N/A'}',
                                            style: TextStyle(
                                              color:
                                                  widget.isDarkMode
                                                      ? Colors.grey[300]
                                                      : Colors.grey[600],
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            'Cadre: ${worker['cadre']?['name'] ?? 'N/A'}',
                                            style: TextStyle(
                                              color:
                                                  widget.isDarkMode
                                                      ? Colors.grey[300]
                                                      : Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    // Action Buttons
                                    Row(
                                      children: [
                                        IconButton(
                                          icon: const Icon(Icons.assignment),
                                          onPressed:
                                              () => _handleAssignCadre(worker),
                                          tooltip: 'Assign Cadre',
                                          color:
                                              widget.isDarkMode
                                                  ? AppTheme.amber
                                                  : AppTheme.rustOrange,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.edit),
                                          onPressed: () => _handleEdit(worker),
                                          tooltip: 'Edit',
                                          color:
                                              widget.isDarkMode
                                                  ? AppTheme.amber
                                                  : AppTheme.rustOrange,
                                        ),
                                        IconButton(
                                          icon: const Icon(Icons.delete),
                                          onPressed:
                                              () => _handleDelete(
                                                worker['hwID'].toString(),
                                                worker['name'],
                                              ),
                                          tooltip: 'Delete',
                                          color: Colors.red,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _handleAddNew,
        backgroundColor:
            widget.isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
        child: const Icon(Icons.add),
      ),
    );
  }
}
