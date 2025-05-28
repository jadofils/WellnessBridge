import 'dart:async';
import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/projects/projects_api.dart';
import 'package:wellnessbridge/frontend/admin/projects/edit_project.dart';
import 'package:wellnessbridge/frontend/admin/projects/view_project.dart';

class ProjectsList extends StatefulWidget {
  const ProjectsList({super.key});

  @override
  _ProjectsListState createState() => _ProjectsListState();
}

class _ProjectsListState extends State<ProjectsList> {
  bool _isLoading = false;
  List<Map<String, dynamic>> _projects = [];
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;
  final int _itemsPerPage = 10;
  bool _hasMorePages = true;
  Timer? _debounce;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  Future<void> _loadProjects({bool resetPage = false}) async {
    if (_isLoading) return;

    if (resetPage) {
      _currentPage = 1;
      _projects = [];
    }

    setState(() => _isLoading = true);

    try {
      final response = await ProjectsApi.getProjects(
        page: _currentPage,
        itemsPerPage: _itemsPerPage,
        searchQuery: _searchQuery,
      );

      setState(() {
        if (response['data'] is List) {
          _projects = List<Map<String, dynamic>>.from(response['data']);
          _hasMorePages = false;
        } else {
          final newProjects = List<Map<String, dynamic>>.from(
            response['data']['data'],
          );
          if (resetPage) {
            _projects = newProjects;
          } else {
            _projects.addAll(newProjects);
          }
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

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      setState(() {
        _searchQuery = value;
      });
      _loadProjects(resetPage: true);
    });
  }

  Future<void> _deleteProject(int id) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Confirm Delete'),
            content: const Text(
              'Are you sure you want to delete this project?',
            ),
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
      await ProjectsApi.deleteProject(id);
      if (mounted) {
        CustomSnackBar.showSuccess(context, 'Project deleted successfully');
        _loadProjects(resetPage: true);
      }
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(context, e.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Projects'),
        backgroundColor: isDarkMode ? AppTheme.navy : AppTheme.rustOrange,
        foregroundColor: isDarkMode ? AppTheme.amber : Colors.white,
      ),
      backgroundColor:
          isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
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
                      hintText: 'Search projects...',
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
                        borderSide: BorderSide(
                          color:
                              isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(
                          color:
                              isDarkMode
                                  ? AppTheme.blue.withOpacity(0.5)
                                  : AppTheme.rustOrange.withOpacity(0.5),
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
                              ? AppTheme.darkInputFillColor
                              : AppTheme.lightInputFillColor,
                    ),
                    onChanged: _onSearchChanged,
                  ),
                ),
                const SizedBox(width: 16),
                ElevatedButton.icon(
                  onPressed: () async {
                    final result = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (context) => EditProject(isDarkMode: isDarkMode),
                      ),
                    );
                    if (result == true) {
                      _loadProjects(resetPage: true);
                    }
                  },
                  icon: const Icon(Icons.add),
                  label: const Text('Add Project'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child:
                _isLoading && _projects.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : _projects.isEmpty
                    ? Center(
                      child: Text(
                        'No projects found',
                        style: TextStyle(
                          color: isDarkMode ? Colors.white : Colors.black54,
                        ),
                      ),
                    )
                    : ListView.builder(
                      itemCount: _projects.length + (_hasMorePages ? 1 : 0),
                      itemBuilder: (context, index) {
                        if (index == _projects.length) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child:
                                  _isLoading
                                      ? const CircularProgressIndicator()
                                      : ElevatedButton(
                                        onPressed: () {
                                          _currentPage++;
                                          _loadProjects();
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

                        final project = _projects[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          color: isDarkMode ? AppTheme.navy : Colors.white,
                          elevation: 2,
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
                                        (project['name']?[0] ?? '?')
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
                                            project['name'] ?? 'No Name',
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
                                            'Status: ${project['status'] ?? 'N/A'}',
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
                                  project['description'] ??
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
                                      onPressed: () async {
                                        await Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder:
                                                (context) => ViewProject(
                                                  project: project,
                                                  isDarkMode: isDarkMode,
                                                ),
                                          ),
                                        );
                                      },
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
                                                (context) => EditProject(
                                                  project: project,
                                                  isDarkMode: isDarkMode,
                                                ),
                                          ),
                                        );
                                        if (result == true) {
                                          _loadProjects(resetPage: true);
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
                                          () => _deleteProject(
                                            project['projectID'],
                                          ),
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
                        );
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
