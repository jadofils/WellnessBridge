import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';

class ParentDashboard extends StatefulWidget {
  const ParentDashboard({super.key});

  @override
  _ParentDashboardState createState() => _ParentDashboardState();
}

class _ParentDashboardState extends State<ParentDashboard> {
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
            "Parent Dashboard",
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
                Icon(Icons.family_restroom, size: 60, color: Colors.white),
                SizedBox(height: 10),
                Text(
                  "Parent Portal",
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
          ),
          _buildDrawerItem(
            icon: Icons.child_care,
            title: "My Children",
            onTap: () => _navigateToSection(0),
          ),
          _buildDrawerItem(
            icon: Icons.medical_information,
            title: "Health Records",
            onTap: () => _navigateToSection(1),
          ),
          _buildDrawerItem(
            icon: Icons.calendar_today,
            title: "Appointments",
            onTap: () => _navigateToSection(2),
          ),
          _buildDrawerItem(
            icon: Icons.notifications,
            title: "Notifications",
            onTap: () => _navigateToSection(3),
          ),
          Divider(color: accentColor.withOpacity(0.5)),
          _buildDrawerItem(
            icon: Icons.settings,
            title: "Settings",
            onTap: () => _navigateToSection(4),
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
    );
  }

  Widget _buildBody() {
    switch (_selectedIndex) {
      case 0:
        return Center(child: Text('My Children'));
      case 1:
        return Center(child: Text('Health Records'));
      case 2:
        return Center(child: Text('Appointments'));
      case 3:
        return Center(child: Text('Notifications'));
      case 4:
        return Center(child: Text('Settings'));
      default:
        return Center(child: Text('Welcome to Parent Dashboard'));
    }
  }

  void _navigateToSection(int index) {
    setState(() {
      _selectedIndex = index;
    });
    Navigator.pop(context); // Close drawer
  }

  void _showLogoutConfirmation() {
    showDialog(
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
                onPressed: () => Navigator.pop(context),
                child: Text('Cancel', style: TextStyle(color: AppTheme.blue)),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  CustomSnackBar.showSuccess(
                    context,
                    'Logged out successfully',
                  );
                  // Implement actual logout functionality here
                },
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
  }
}
