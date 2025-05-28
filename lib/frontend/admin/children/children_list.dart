import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/children/children_api.dart';
import 'package:wellnessbridge/backend_api/children/search_children_api.dart';
import 'package:wellnessbridge/backend_api/children/view_children_api.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'dart:async';
import 'package:wellnessbridge/frontend/admin/children/view_child.dart';
import 'package:wellnessbridge/frontend/admin/children/edit_children.dart';

class ChildrenList extends StatefulWidget {
  const ChildrenList({Key? key}) : super(key: key);

  @override
  State<ChildrenList> createState() => _ChildrenListState();
}

class _ChildrenListState extends State<ChildrenList> {
  bool _isLoading = true;
  List<dynamic> _children = [];
  int _currentPage = 1;
  final int _itemsPerPage = 10; // 2 cards per row * 5 rows
  final TextEditingController _searchController = TextEditingController();
  bool _isDarkMode = false; // Assuming you'll update this based on theme
  Timer? _debounce;
  bool _hasNextPage = true;

  @override
  void initState() {
    super.initState();
    _loadChildren();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;
  }

  Future<void> _loadChildren() async {
    try {
      setState(() => _isLoading = true);
      final response = await ChildrenApi.getChildren(
        page: _currentPage,
        itemsPerPage: _itemsPerPage,
      );
      setState(() {
        _children = response['data']['data'] ?? [];
        _hasNextPage = response['data']['next_page_url'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to load children: $e');
    }
  }

  Future<void> _loadNextPage() async {
    if (!_hasNextPage) return;

    setState(() {
      _currentPage++;
      _isLoading = true;
    });

    try {
      final response = await ChildrenApi.getChildren(
        page: _currentPage,
        itemsPerPage: _itemsPerPage,
      );
      setState(() {
        _children = response['data']['data'] ?? [];
        _hasNextPage = response['data']['next_page_url'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to load more children: $e');
    }
  }

  Future<void> _searchChildren(String query) async {
    if (query.isEmpty) {
      setState(() => _currentPage = 1);
      await _loadChildren();
      return;
    }

    try {
      setState(() => _isLoading = true);
      final response = await SearchChildrenApi.searchChildren(query);
      setState(() {
        _children = response['data']['data'] ?? [];
        _hasNextPage = response['data']['next_page_url'] != null;
        _isLoading = false;
      });
    } catch (e) {
      setState(() => _isLoading = false);
      CustomSnackBar.showError(context, 'Failed to search children: $e');
    }
  }

  void _onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      _searchChildren(query);
    });
  }

  Future<void> _deleteChild(int id) async {
    try {
      final confirmed = await showDialog<bool>(
        context: context,
        builder: (BuildContext context) {
          return Theme(
            data: Theme.of(context).copyWith(
              dialogBackgroundColor: _isDarkMode ? AppTheme.navy : Colors.white,
              textTheme: TextTheme(
                titleLarge: TextStyle(
                  color: _isDarkMode ? AppTheme.amber : AppTheme.navy,
                  fontSize: AppTheme.titleFontSize,
                  fontWeight: FontWeight.bold,
                ),
                bodyMedium: TextStyle(
                  color: _isDarkMode ? Colors.white70 : AppTheme.blue,
                  fontSize: AppTheme.bodyFontSize,
                ),
              ),
            ),
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              backgroundColor: _isDarkMode ? AppTheme.navy : Colors.white,
              title: Row(
                children: [
                  Icon(
                    Icons.warning_amber_rounded,
                    color: _isDarkMode ? AppTheme.amber : AppTheme.rustOrange,
                  ),
                  const SizedBox(width: 8),
                  const Text('Confirm Delete'),
                ],
              ),
              content: Text(
                'Are you sure you want to delete this child\'s record? This action cannot be undone.',
                style: TextStyle(
                  color: _isDarkMode ? Colors.white70 : AppTheme.blue,
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context, false),
                  child: Text(
                    'Cancel',
                    style: TextStyle(
                      color: _isDarkMode ? AppTheme.amber : AppTheme.blue,
                      fontSize: AppTheme.bodyFontSize,
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () => Navigator.pop(context, true),
                  child: Text(
                    'Delete',
                    style: TextStyle(
                      color: AppTheme.rustOrange,
                      fontSize: AppTheme.bodyFontSize,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );

      if (confirmed == true) {
        await ChildrenApi.deleteChild(id);
        CustomSnackBar.showSuccess(context, 'Child deleted successfully');
        await _loadChildren();
      }
    } catch (e) {
      CustomSnackBar.showError(context, 'Failed to delete child: $e');
    }
  }

  Future<void> _editChild(int id) async {
    try {
      final response = await ViewChildrenApi.getChildById(id);
      if (!mounted) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditChildren(childData: response['data']),
        ),
      );
      await _loadChildren();
    } catch (e) {
      CustomSnackBar.showError(context, 'Failed to edit child: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    // Update theme on build as well to handle theme changes
    _isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          _isDarkMode
              ? AppTheme.nightBackgroundColor
              : AppTheme.sunBackgroundColor,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.4,
                child: TextField(
                  controller: _searchController,
                  onChanged: _onSearchChanged,
                  decoration: InputDecoration(
                    hintText: 'Search children...',
                    prefixIcon: Icon(Icons.search, color: AppTheme.blue),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppTheme.blue),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppTheme.blue),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: AppTheme.rustOrange),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child:
                _isLoading && _children.isEmpty
                    ? Center(
                      child: CircularProgressIndicator(
                        color: AppTheme.rustOrange,
                      ),
                    )
                    : Center(
                      // Center the content horizontally
                      child: ConstrainedBox(
                        // Limit the max width
                        constraints: const BoxConstraints(maxWidth: 760),
                        child: Column(
                          children: [
                            Expanded(
                              child: GridView.builder(
                                padding: const EdgeInsets.all(16),
                                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 16,
                                  mainAxisSpacing: 16,
                                  // Remove childAspectRatio to allow cards to determine their height
                                  // based on content. Use mainAxisExtent for more control if needed,
                                  // but for auto-height, letting content drive it is often best.
                                  mainAxisExtent:
                                      300, // You can adjust this value, or remove it for full auto-height if content is very dynamic.
                                  // If content is truly dynamic and you want cards to grow with it,
                                  // consider using a custom SliverGridDelegate or not using GridView.builder
                                  // if cards have highly varying heights and need to fill space precisely.
                                  // For most cases, a reasonable fixed mainAxisExtent or letting content drive it
                                  // within a SingleChildScrollView per card works well.
                                ),
                                itemCount: _children.length,
                                itemBuilder: (context, index) {
                                  final child = _children[index];
                                  return GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder:
                                              (context) => ViewChild(
                                                childId: int.parse(
                                                  child['childID'].toString(),
                                                ),
                                              ),
                                        ),
                                      );
                                    },
                                    child: Card(
                                      elevation: 4,
                                      color:
                                          _isDarkMode
                                              ? AppTheme.navy
                                              : Colors.white,
                                      child: SingleChildScrollView(
                                        // This ensures content within the card can scroll if it exceeds card height
                                        child: Padding(
                                          padding: const EdgeInsets.all(16.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              if (child['image'] != null)
                                                ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(8),
                                                  child: Image.network(
                                                    child['image'],
                                                    height: 120,
                                                    width: double.infinity,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (
                                                      context,
                                                      error,
                                                      stackTrace,
                                                    ) {
                                                      return Container(
                                                        height: 120,
                                                        color: AppTheme.blue
                                                            .withOpacity(0.1),
                                                        child: Icon(
                                                          Icons.person,
                                                          size: 48,
                                                          color: AppTheme.blue,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                ),
                                              const SizedBox(height: 12),
                                              Text(
                                                child['name'] ?? 'No name',
                                                style: TextStyle(
                                                  fontSize:
                                                      AppTheme.subtitleFontSize,
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      _isDarkMode
                                                          ? AppTheme.amber
                                                          : AppTheme.navy,
                                                ),
                                              ),
                                              const SizedBox(height: 8),
                                              _buildInfoRow(
                                                'ID',
                                                '#${child['childID']}',
                                              ),
                                              _buildInfoRow(
                                                'Gender',
                                                child['gender'] ?? 'N/A',
                                              ),
                                              _buildInfoRow(
                                                'Date of Birth',
                                                child['dob'] ?? 'N/A',
                                              ),
                                              _buildInfoRow(
                                                'Parent',
                                                child['parentName'] ?? 'N/A',
                                              ),
                                              _buildInfoRow(
                                                'Contact',
                                                child['parentContact'] ?? 'N/A',
                                              ),
                                              if (child['address'] != null) ...[
                                                const SizedBox(height: 8),
                                                Text(
                                                  'Address:',
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTheme.bodyFontSize,
                                                    fontWeight: FontWeight.bold,
                                                    color:
                                                        _isDarkMode
                                                            ? AppTheme.amber
                                                            : AppTheme.navy,
                                                  ),
                                                ),
                                                Text(
                                                  child['address'],
                                                  style: TextStyle(
                                                    fontSize:
                                                        AppTheme.bodyFontSize,
                                                    color:
                                                        _isDarkMode
                                                            ? Colors.white70
                                                            : AppTheme.blue,
                                                  ),
                                                ),
                                              ],
                                              const SizedBox(height: 12),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.visibility,
                                                      color: AppTheme.blue,
                                                    ),
                                                    onPressed: () async {
                                                      try {
                                                        await Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                            builder:
                                                                (
                                                                  context,
                                                                ) => ViewChild(
                                                                  childId: int.parse(
                                                                    child['childID']
                                                                        .toString(),
                                                                  ),
                                                                ),
                                                          ),
                                                        );
                                                        // Refresh the list when returning from view
                                                        await _loadChildren();
                                                      } catch (e) {
                                                        CustomSnackBar.showError(
                                                          context,
                                                          'Failed to view child details: $e',
                                                        );
                                                      }
                                                    },
                                                    tooltip: 'View Details',
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: AppTheme.amber,
                                                    ),
                                                    onPressed: () {
                                                      _editChild(
                                                        child['childID'],
                                                      );
                                                    },
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color:
                                                          AppTheme.rustOrange,
                                                    ),
                                                    onPressed: () {
                                                      _deleteChild(
                                                        child['childID'],
                                                      );
                                                    },
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            if (_hasNextPage)
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: ElevatedButton(
                                  onPressed: _isLoading ? null : _loadNextPage,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppTheme.rustOrange,
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 32,
                                      vertical: 16,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child:
                                      _isLoading
                                          ? SizedBox(
                                            width: 20,
                                            height: 20,
                                            child: CircularProgressIndicator(
                                              color: Colors.white,
                                              strokeWidth: 2,
                                            ),
                                          )
                                          : Text(
                                            'Load More',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => EditChildren(childData: <String, dynamic>{}),
            ),
          );
        },
        backgroundColor: AppTheme.rustOrange,
        child: const Icon(Icons.add, color: Colors.white),
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
              softWrap: true, // Allow text to wrap
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
