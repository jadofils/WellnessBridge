import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/theme.dart';

class HealthCareDashboard extends StatefulWidget {
  @override
  _HealthCareDashboardState createState() => _HealthCareDashboardState();
}

class _HealthCareDashboardState extends State<HealthCareDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: PreferredSize(
        preferredSize: Size(600, kToolbarHeight), // Set app bar width to 600px
        child: AppBar(
          title: Text("Health Care Online Status", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: AppTheme.primaryColor,
          actions: [
            // Search Bar with Margin (10px left & right)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10), // Adjust padding here
              child: Container(
                width: 200, // Fixed width for the search bar
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white70),
                    prefixIcon: Icon(Icons.search, color: Colors.white),
                    filled: true,
                    fillColor: Colors.white24,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide.none,
                    ),
                  ),
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
            // Right-side menu
            PopupMenuButton<String>(
              onSelected: (value) {
                if (value == "Logout") {
                  Navigator.pop(context);
                }
              },
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(value: "Profile", child: Text("Profile")),
                  PopupMenuItem(value: "Settings", child: Text("Settings")),
                  PopupMenuItem(value: "Logout", child: Text("Logout")),
                ];
              },
              icon: Icon(Icons.more_vert, color: Colors.white),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: AppTheme.primaryColor),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(Icons.account_circle, size: 60, color: Colors.white),
                  SizedBox(height: 10),
                  Text("Health Worker Account", style: TextStyle(fontSize: 18, color: Colors.white)),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.medical_services),
              title: Text("Check Patient Records"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.access_time),
              title: Text("Schedule Appointments"),
              onTap: () {},
            ),
            ListTile(
              leading: Icon(Icons.history),
              title: Text("Medical History"),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: Center(
        child: Container(
          width: 600, // Set the body width to 600px
          height: 600, // Set the body height to 600px
          padding: EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
            boxShadow: [
              BoxShadow(
                color: Colors.black12,
                blurRadius: 8,
                spreadRadius: 2,
                offset: Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Welcome to HealthCare Dashboard",
                style: AppTheme.titleTextStyle.copyWith(fontSize: 24),
              ),
              SizedBox(height: 20),
              Card(
                elevation: 4,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Text("📊 Daily Patient Reports", style: AppTheme.subtitleTextStyle),
                      SizedBox(height: 10),
                      Text("Total Patients: 25", style: AppTheme.bodyTextStyle),
                      Text("Pending Appointments: 5", style: AppTheme.bodyTextStyle),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 20),
              // You can add more dashboard content here as needed
            ],
          ),
        ),
      ),
    );
  }
}
