import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/auth/login_api.dart';
import 'package:wellnessbridge/backend_api/health_workers/select_healthworker.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:wellnessbridge/frontend/admin/cadres/cadres_list.dart';
import 'package:wellnessbridge/frontend/admin/children/children_list.dart';
import 'package:wellnessbridge/frontend/admin/health_records/health_records_list.dart';
import 'package:wellnessbridge/frontend/admin/projects/projects_list.dart';
import 'package:wellnessbridge/frontend/admin/reports/reports_dashboard.dart';
import 'package:wellnessbridge/frontend/admin/settings/admin_settings.dart';
import 'dart:developer' as developer;

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  bool _isDarkMode = false;
  int _selectedIndex = 0;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    final backgroundColor = _isDarkMode ? AppTheme.navy : Colors.white;
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final accentColor = _isDarkMode ? AppTheme.amber : AppTheme.rustOrange;

    return Theme(
      data: _isDarkMode ? AppTheme.darkTheme : AppTheme.lightTheme,
      child: Scaffold(
        backgroundColor: backgroundColor,
        appBar: AppBar(
          title: Text(
            "Admin Dashboard",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          centerTitle: true,
          backgroundColor: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
          actions: [
            IconButton(
              icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nightlight_round),
              onPressed: _toggleTheme,
              tooltip:
                  _isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
              color: Colors.white,
            ),
          ],
        ),
        drawer: _buildDrawer(accentColor, textColor),
        body: _buildBody(),
      ),
    );
  }

  Widget _buildDrawer(Color accentColor, Color textColor) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: _isDarkMode ? AppTheme.blue : AppTheme.rustOrange,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Icon(Icons.admin_panel_settings, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Admin Panel",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.people,
            title: "Health Workers",
            onTap: () => _navigateToSection(0),
          ),
          _buildDrawerItem(
            icon: Icons.medical_services,
            title: "Cadres",
            onTap: () => _navigateToSection(1),
          ),
          _buildDrawerItem(
            icon: Icons.child_care,
            title: "Children",
            onTap: () => _navigateToSection(2),
          ),
          _buildDrawerItem(
            icon: Icons.medical_information,
            title: "Health Records",
            onTap: () => _navigateToSection(3),
          ),
          _buildDrawerItem(
            icon: Icons.assignment,
            title: "Projects",
            onTap: () => _navigateToSection(4),
          ),
          _buildDrawerItem(
            icon: Icons.analytics,
            title: "Reports",
            onTap: () => _navigateToSection(5),
          ),
          Divider(color: accentColor.withOpacity(0.5)),
          _buildDrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => _navigateToSection(6),
          ),
          _buildDrawerItem(
            icon: Icons.logout,
            title: "Logout",
            onTap: () => _showLogoutConfirmation(),
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    final textColor = _isDarkMode ? Colors.white : Colors.black87;
    final iconColor = _isDarkMode ? AppTheme.amber : AppTheme.blue;

    return ListTile(
      leading: Icon(icon, color: iconColor),
      title: Text(title, style: TextStyle(color: textColor)),
      onTap: onTap,
      selected: _selectedIndex == _getIndexForTitle(title),
      selectedTileColor: iconColor.withOpacity(0.1),
    );
  }

  int _getIndexForTitle(String title) {
    switch (title) {
      case "Health Workers":
        return 0;
      case "Cadres":
        return 1;
      case "Children":
        return 2;
      case "Health Records":
        return 3;
      case "Projects":
        return 4;
      case "Reports":
        return 5;
      case "Settings":
        return 6;
      default:
        return -1;
    }
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return SelectHealthWorkers(
          onView: (worker) async {
            developer.log('Viewing health worker: ${worker.toString()}');
            // TODO: Implement view functionality when view screen is ready
            CustomSnackBar.showSuccess(
              context,
              'View functionality coming soon',
            );
          },
          onEdit: (worker) async {
            developer.log('Editing health worker data: ${worker.toString()}');
            try {
              final updateData = {
                'name': worker['name'],
                'gender': worker['gender'],
                'dob': worker['dob'],
                'role': worker['role'],
                'telephone': worker['telephone'],
                'email': worker['email'],
                'address': worker['address'],
                'cadID': worker['cadID'],
              };
              developer.log('Sending update data: ${updateData.toString()}');

              final response = await HealthWorkersApi.updateHealthWorker(
                worker['hwID'],
                updateData,
              );
              developer.log('Update response: ${response.toString()}');

              if (mounted) {
                CustomSnackBar.showSuccess(
                  context,
                  'Health worker updated successfully',
                );
                setState(() {});
              }
            } catch (e) {
              developer.log('Error updating health worker: $e', error: e);
              if (mounted) {
                CustomSnackBar.showError(
                  context,
                  'Failed to update health worker: $e',
                );
              }
            }
          },
          onDelete: (id, name) async {
            developer.log('Deleting health worker - ID: $id, Name: $name');
            try {
              await HealthWorkersApi.deleteHealthWorker(int.parse(id));
              developer.log('Health worker deleted successfully');
              if (mounted) {
                CustomSnackBar.showSuccess(
                  context,
                  'Health worker deleted successfully',
                );
                setState(() {});
              }
            } catch (e) {
              developer.log('Error deleting health worker: $e', error: e);
              if (mounted) {
                CustomSnackBar.showError(
                  context,
                  'Failed to delete health worker: $e',
                );
              }
            }
          },
          onAddNew: () async {
            developer.log('Adding new health worker');
            try {
              // TODO: Implement add functionality when add screen is ready
              CustomSnackBar.showSuccess(
                context,
                'Add functionality coming soon',
              );
            } catch (e) {
              developer.log('Error adding health worker: $e', error: e);
              if (mounted) {
                CustomSnackBar.showError(
                  context,
                  'Failed to add health worker: $e',
                );
              }
            }
          },
          isDarkMode: _isDarkMode,
        );
      case 1:
        return CadresList();
      case 2:
        return ChildrenList();
      case 3:
        return HealthRecordsList();
      case 4:
        return ProjectsList();
      case 5:
        return ReportsDashboard();
      case 6:
        return AdminSettings();
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.admin_panel_settings,
                size: 80,
                color: _isDarkMode ? AppTheme.amber : AppTheme.blue,
              ),
              SizedBox(height: 20),
              Text(
                'Welcome to Admin Dashboard',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: _isDarkMode ? Colors.white : AppTheme.navy,
                ),
              ),
              SizedBox(height: 10),
              Text(
                'Select an option from the menu to begin',
                style: TextStyle(
                  fontSize: 16,
                  color: _isDarkMode ? Colors.white70 : Colors.black54,
                ),
              ),
            ],
          ),
        );
    }
  }

  void _navigateToSection(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  Future<void> _showLogoutConfirmation() async {
    final result = await showDialog<bool>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              'Confirm Logout',
              style: TextStyle(
                color: AppTheme.rustOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'Are you sure you want to logout?',
              style: TextStyle(
                color: _isDarkMode ? Colors.white : AppTheme.navy,
              ),
            ),
            backgroundColor: _isDarkMode ? AppTheme.navy : Colors.white,
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, false),
                child: Text('Cancel', style: TextStyle(color: AppTheme.blue)),
              ),
              TextButton(
                onPressed: () => Navigator.pop(context, true),
                child: Text(
                  'Logout',
                  style: TextStyle(color: AppTheme.rustOrange),
                ),
              ),
            ],
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );

    if (result == true) {
      await LoginApi.logout();
      if (mounted) {
        Navigator.pushReplacementNamed(context, '/wellnessbridge/page/login');
        CustomSnackBar.showSuccess(context, 'Logged out successfully');
      }
    }
  }
}
