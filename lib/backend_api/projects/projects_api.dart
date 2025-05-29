import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

// Data Models
class Cadre {
  final String id;
  final String name;
  final String description;
  final IconData icon;

  Cadre({
    required this.id,
    required this.name,
    required this.description,
    required this.icon,
  });

  factory Cadre.fromJson(Map<String, dynamic> json) {
    return Cadre(
      id: json['cadreID'].toString(),
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: _getIconFromName(json['name']),
    );
  }

  static IconData _getIconFromName(String name) {
    final lowercaseName = name.toLowerCase();
    if (lowercaseName.contains('health')) return Icons.medical_services;
    if (lowercaseName.contains('community')) return Icons.people;
    if (lowercaseName.contains('nutrition')) return Icons.restaurant;
    if (lowercaseName.contains('mental')) return Icons.psychology;
    if (lowercaseName.contains('emergency')) return Icons.emergency;
    return Icons.group; // Default icon
  }
}

class UmunyabuzimaUser {
  final String id;
  final String name;
  final String email;
  final String phone;
  final String location;
  final String cadreId;
  final bool isAvailable;
  final String? profileImage;

  UmunyabuzimaUser({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.location,
    required this.cadreId,
    this.isAvailable = true,
    this.profileImage,
  });

  factory UmunyabuzimaUser.fromJson(Map<String, dynamic> json) {
    return UmunyabuzimaUser(
      id: json['userID'].toString(),
      name: '${json['firstName'] ?? ''} ${json['lastName'] ?? ''}'.trim(),
      email: json['email'] ?? '',
      phone: json['phoneNumber'] ?? '',
      location: json['location'] ?? '',
      cadreId: json['cadreID']?.toString() ?? '',
      isAvailable: json['isAvailable'] ?? true,
      profileImage: json['profileImage'],
    );
  }
}

class ProjectAssignmentScreen extends StatefulWidget {
  const ProjectAssignmentScreen({super.key});

  @override
  _ProjectAssignmentScreenState createState() =>
      _ProjectAssignmentScreenState();
}

class _ProjectAssignmentScreenState extends State<ProjectAssignmentScreen>
    with TickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  final TextEditingController _projectNameController = TextEditingController();
  final TextEditingController _projectDescriptionController =
      TextEditingController();

  String _searchQuery = '';
  Cadre? _selectedCadre;
  UmunyabuzimaUser? _selectedUser;
  List<Cadre> _allCadres = [];
  List<Cadre> _filteredCadres = [];
  List<UmunyabuzimaUser> _filteredUsers = [];
  bool _isLoadingCadres = false;
  bool _isLoadingUsers = false;

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );
    _animationController.forward();
    _loadCadres();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _projectNameController.dispose();
    _projectDescriptionController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  Future<void> _loadCadres() async {
    setState(() => _isLoadingCadres = true);

    try {
      final response = await CadreApi.getCadres();
      final List<Cadre> cadres =
          (response['data'] as List)
              .map((json) => Cadre.fromJson(json))
              .toList();

      setState(() {
        _allCadres = cadres;
        _filteredCadres = cadres;
      });
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          'Failed to load cadres: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingCadres = false);
      }
    }
  }

  void _filterCadres(String query) {
    setState(() {
      _searchQuery = query;
      if (query.isEmpty) {
        _filteredCadres = _allCadres;
      } else {
        _filteredCadres =
            _allCadres
                .where(
                  (cadre) =>
                      cadre.name.toLowerCase().contains(query.toLowerCase()) ||
                      cadre.description.toLowerCase().contains(
                        query.toLowerCase(),
                      ),
                )
                .toList();
      }
    });
  }

  Future<void> _loadUsersForCadre(String cadreId) async {
    setState(() {
      _isLoadingUsers = true;
      _selectedUser = null;
    });

    try {
      final response = await UserApi.getUsersByCadre(cadreId);
      final List<UmunyabuzimaUser> users =
          (response['data'] as List)
              .map((json) => UmunyabuzimaUser.fromJson(json))
              .where(
                (user) => user.name.isNotEmpty,
              ) // Filter out users without names
              .toList();

      setState(() {
        _filteredUsers = users;
      });
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          'Failed to load users: ${e.toString()}',
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoadingUsers = false);
      }
    }
  }

  Future<void> _assignProject() async {
    if (_projectNameController.text.isEmpty) {
      CustomSnackBar.showError(context, 'Please enter project name');
      return;
    }
    if (_selectedCadre == null) {
      CustomSnackBar.showError(context, 'Please select a cadre');
      return;
    }
    if (_selectedUser == null) {
      CustomSnackBar.showError(context, 'Please select an Umunyabuzima');
      return;
    }

    try {
      // Create project data
      final projectData = {
        'name': _projectNameController.text,
        'description':
            _projectDescriptionController.text.isEmpty
                ? 'No description provided'
                : _projectDescriptionController.text,
        'assignedTo': _selectedUser!.id,
        'cadreID': _selectedCadre!.id,
        'status': 'active',
        'createdAt': DateTime.now().toIso8601String(),
      };

      // Create project using your existing API
      await ProjectsApi.createProject(projectData);

      CustomSnackBar.showSuccess(
        context,
        'Project "${_projectNameController.text}" assigned to ${_selectedUser!.name}',
      );

      // Reset form
      _projectNameController.clear();
      _projectDescriptionController.clear();
      setState(() {
        _selectedCadre = null;
        _selectedUser = null;
        _filteredUsers = [];
      });
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          'Failed to assign project: ${e.toString()}',
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final screenWidth = MediaQuery.of(context).size.width;
    final isTablet = screenWidth > 600;

    return Scaffold(
      backgroundColor:
          isDark ? AppTheme.nightBackgroundColor : AppTheme.sunBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Project Assignment',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: isTablet ? 24 : 20,
          ),
        ),
        backgroundColor:
            isDark ? AppTheme.nightPrimaryColor : AppTheme.primaryColor,
        foregroundColor: isDark ? AppTheme.amber : Colors.white,
        elevation: 0,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(isTablet ? 24 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProjectDetailsSection(theme, isTablet),
              SizedBox(height: 24),
              _buildSearchSection(theme, isTablet),
              SizedBox(height: 24),
              _buildCadreSelectionSection(theme, isTablet),
              if (_selectedCadre != null) ...[
                SizedBox(height: 24),
                _buildUserSelectionSection(theme, isTablet),
              ],
              SizedBox(height: 32),
              _buildAssignButton(theme, isTablet),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProjectDetailsSection(ThemeData theme, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.assignment,
                  color: theme.colorScheme.primary,
                  size: isTablet ? 28 : 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Project Details',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 22 : 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            TextField(
              controller: _projectNameController,
              decoration: InputDecoration(
                labelText: 'Project Name',
                hintText: 'Enter project name',
                prefixIcon: Icon(Icons.work),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor:
                    theme.brightness == Brightness.dark
                        ? AppTheme.darkInputFillColor
                        : AppTheme.lightInputFillColor,
              ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _projectDescriptionController,
              maxLines: 3,
              decoration: InputDecoration(
                labelText: 'Project Description (Optional)',
                hintText: 'Describe the project...',
                prefixIcon: Icon(Icons.description),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor:
                    theme.brightness == Brightness.dark
                        ? AppTheme.darkInputFillColor
                        : AppTheme.lightInputFillColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchSection(ThemeData theme, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.search,
                  color: theme.colorScheme.primary,
                  size: isTablet ? 28 : 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Search Cadres',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 22 : 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _searchController,
              onChanged: _filterCadres,
              decoration: InputDecoration(
                hintText: 'Search by cadre name or description...',
                prefixIcon: Icon(Icons.search),
                suffixIcon:
                    _searchQuery.isNotEmpty
                        ? IconButton(
                          icon: Icon(Icons.clear),
                          onPressed: () {
                            _searchController.clear();
                            _filterCadres('');
                          },
                        )
                        : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor:
                    theme.brightness == Brightness.dark
                        ? AppTheme.darkInputFillColor
                        : AppTheme.lightInputFillColor,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCadreSelectionSection(ThemeData theme, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.groups,
                  color: theme.colorScheme.primary,
                  size: isTablet ? 28 : 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Select Cadre',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 22 : 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            if (_isLoadingCadres)
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading cadres...'),
                  ],
                ),
              )
            else if (_filteredCadres.isEmpty)
              Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.search_off,
                      size: 48,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No cadres found',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              )
            else
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: isTablet ? 3 : 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: isTablet ? 1.2 : 1.0,
                ),
                itemCount: _filteredCadres.length,
                itemBuilder: (context, index) {
                  final cadre = _filteredCadres[index];
                  final isSelected = _selectedCadre?.id == cadre.id;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedCadre = cadre;
                      });
                      _loadUsersForCadre(cadre.id);
                    },
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 200),
                      decoration: BoxDecoration(
                        color:
                            isSelected
                                ? theme.colorScheme.primary.withOpacity(0.1)
                                : theme.cardColor,
                        border: Border.all(
                          color:
                              isSelected
                                  ? theme.colorScheme.primary
                                  : theme.colorScheme.outline.withOpacity(0.3),
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: EdgeInsets.all(12),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            cadre.icon,
                            size: isTablet ? 36 : 28,
                            color:
                                isSelected
                                    ? theme.colorScheme.primary
                                    : theme.colorScheme.onSurface,
                          ),
                          SizedBox(height: 8),
                          Text(
                            cadre.name,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                              color:
                                  isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.onSurface,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            cadre.description,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurface.withOpacity(
                                0.7,
                              ),
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildUserSelectionSection(ThemeData theme, bool isTablet) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: EdgeInsets.all(isTablet ? 24 : 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.person_search,
                  color: theme.colorScheme.primary,
                  size: isTablet ? 28 : 24,
                ),
                SizedBox(width: 12),
                Text(
                  'Select Umunyabuzima',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: isTablet ? 22 : 18,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Text(
              'From ${_selectedCadre!.name}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.7),
              ),
            ),
            SizedBox(height: 16),
            if (_isLoadingUsers)
              Center(
                child: Column(
                  children: [
                    CircularProgressIndicator(),
                    SizedBox(height: 16),
                    Text('Loading Umunyabuzima...'),
                  ],
                ),
              )
            else if (_filteredUsers.isEmpty)
              Container(
                padding: EdgeInsets.all(32),
                child: Column(
                  children: [
                    Icon(
                      Icons.person_off,
                      size: 48,
                      color: theme.colorScheme.onSurface.withOpacity(0.5),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'No Umunyabuzima available in this cadre',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: theme.colorScheme.onSurface.withOpacity(0.7),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            else
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _filteredUsers.length,
                itemBuilder: (context, index) {
                  final user = _filteredUsers[index];
                  final isSelected = _selectedUser?.id == user.id;

                  return Container(
                    margin: EdgeInsets.only(bottom: 12),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap:
                            user.isAvailable
                                ? () {
                                  setState(() {
                                    _selectedUser = user;
                                  });
                                }
                                : null,
                        borderRadius: BorderRadius.circular(12),
                        child: AnimatedContainer(
                          duration: Duration(milliseconds: 200),
                          decoration: BoxDecoration(
                            color:
                                isSelected
                                    ? theme.colorScheme.primary.withOpacity(0.1)
                                    : user.isAvailable
                                    ? theme.cardColor
                                    : theme.colorScheme.onSurface.withOpacity(
                                      0.05,
                                    ),
                            border: Border.all(
                              color:
                                  isSelected
                                      ? theme.colorScheme.primary
                                      : theme.colorScheme.outline.withOpacity(
                                        0.3,
                                      ),
                              width: isSelected ? 2 : 1,
                            ),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          padding: EdgeInsets.all(16),
                          child: Row(
                            children: [
                              CircleAvatar(
                                radius: isTablet ? 30 : 24,
                                backgroundColor: theme.colorScheme.primary
                                    .withOpacity(0.1),
                                child: Text(
                                  user.name
                                      .split(' ')
                                      .map((e) => e.isNotEmpty ? e[0] : '')
                                      .take(2)
                                      .join(),
                                  style: TextStyle(
                                    color: theme.colorScheme.primary,
                                    fontWeight: FontWeight.bold,
                                    fontSize: isTablet ? 18 : 14,
                                  ),
                                ),
                              ),
                              SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            user.name,
                                            style: theme.textTheme.titleMedium
                                                ?.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  color:
                                                      user.isAvailable
                                                          ? theme
                                                              .colorScheme
                                                              .onSurface
                                                          : theme
                                                              .colorScheme
                                                              .onSurface
                                                              .withOpacity(0.5),
                                                ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: 8,
                                            vertical: 4,
                                          ),
                                          decoration: BoxDecoration(
                                            color:
                                                user.isAvailable
                                                    ? Colors.green.withOpacity(
                                                      0.1,
                                                    )
                                                    : Colors.orange.withOpacity(
                                                      0.1,
                                                    ),
                                            borderRadius: BorderRadius.circular(
                                              12,
                                            ),
                                          ),
                                          child: Text(
                                            user.isAvailable
                                                ? 'Available'
                                                : 'Busy',
                                            style: TextStyle(
                                              color:
                                                  user.isAvailable
                                                      ? Colors.green
                                                      : Colors.orange,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 4),
                                    if (user.email.isNotEmpty)
                                      Text(
                                        user.email,
                                        style: theme.textTheme.bodySmall
                                            ?.copyWith(
                                              color: theme.colorScheme.onSurface
                                                  .withOpacity(0.7),
                                            ),
                                      ),
                                    SizedBox(height: 2),
                                    Row(
                                      children: [
                                        if (user.phone.isNotEmpty) ...[
                                          Icon(
                                            Icons.phone,
                                            size: 14,
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.5),
                                          ),
                                          SizedBox(width: 4),
                                          Text(
                                            user.phone,
                                            style: theme.textTheme.bodySmall
                                                ?.copyWith(
                                                  color: theme
                                                      .colorScheme
                                                      .onSurface
                                                      .withOpacity(0.7),
                                                ),
                                          ),
                                        ],
                                        if (user.location.isNotEmpty) ...[
                                          SizedBox(width: 12),
                                          Icon(
                                            Icons.location_on,
                                            size: 14,
                                            color: theme.colorScheme.onSurface
                                                .withOpacity(0.5),
                                          ),
                                          SizedBox(width: 4),
                                          Expanded(
                                            child: Text(
                                              user.location,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                    color: theme
                                                        .colorScheme
                                                        .onSurface
                                                        .withOpacity(0.7),
                                                  ),
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              if (isSelected)
                                Icon(
                                  Icons.check_circle,
                                  color: theme.colorScheme.primary,
                                  size: isTablet ? 28 : 24,
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildAssignButton(ThemeData theme, bool isTablet) {
    final canAssign =
        _projectNameController.text.isNotEmpty &&
        _selectedCadre != null &&
        _selectedUser != null;

    return SizedBox(
      width: double.infinity,
      height: isTablet ? 56 : 48,
      child: ElevatedButton(
        onPressed: canAssign ? _assignProject : null,
        style: ElevatedButton.styleFrom(
          backgroundColor: theme.colorScheme.primary,
          foregroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 3,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.assignment_turned_in, size: isTablet ? 24 : 20),
            SizedBox(width: 12),
            Text(
              'Assign Project',
              style: TextStyle(
                fontSize: isTablet ? 18 : 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// API Classes
class CadreApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  static Future<Map<String, dynamic>> getCadres({
    int page = 1,
    int itemsPerPage = 50,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'itemsPerPage': itemsPerPage.toString(),
    };

    final response = await http.get(
      Uri.parse('$baseUrl/cadres').replace(queryParameters: queryParams),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load cadres: ${response.body}');
    }
  }
}

class UserApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  static Future<Map<String, dynamic>> getUsersByCadre(String cadreId) async {
    final response = await http.get(
      Uri.parse('$baseUrl/users/cadre/$cadreId?role=umunyabuzima'),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users: ${response.body}');
    }
  }
}

// Extend your existing ProjectsApi with the assignment functionality
class ProjectsApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  static Future<Map<String, dynamic>> getProjects({
    int page = 1,
    int itemsPerPage = 10,
    String? searchQuery,
  }) async {
    final queryParams = {
      'page': page.toString(),
      'itemsPerPage': itemsPerPage.toString(),
      if (searchQuery != null && searchQuery.isNotEmpty) 'search': searchQuery,
    };

    final response = await http.get(
      Uri.parse('$baseUrl/projects').replace(queryParameters: queryParams),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load projects: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> getProjectById(int projectId) async {
    final response = await http.get(Uri.parse('$baseUrl/projects/$projectId'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load project: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> createProject(
    Map<String, dynamic> projectData,
  ) async {
    final response = await http.post(
      Uri.parse('$baseUrl/projects'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(projectData),
    );

    if (response.statusCode == 201) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to create project: ${response.body}');
    }
  }

  static Future<Map<String, dynamic>> updateProject(
    int projectId,
    Map<String, dynamic> projectData,
  ) async {
    final response = await http.put(
      Uri.parse('$baseUrl/projects/$projectId'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(projectData),
    );

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to update project: ${response.body}');
    }
  }

  static Future<void> deleteProject(int projectId) async {
    final response = await http.delete(
      Uri.parse('$baseUrl/projects/$projectId'),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete project: ${response.body}');
    }
  }
}
