import 'package:flutter/material.dart';

class AdminDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Admin Dashboard'),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Welcome section
            Text(
              'Welcome to the Admin Dashboard!',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),

            // Dashboard Features (Sample buttons for functionality)
            ElevatedButton(
              onPressed: () {
                // Navigate to manage users page
              },
              child: Text('Manage Users'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to view system health or reports page
              },
              child: Text('System Health & Reports'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to view app statistics or analytics
              },
              child: Text('App Analytics'),
            ),
            SizedBox(height: 20),

            // Logout Button
            Center(
              child: ElevatedButton(
                onPressed: () {
                  // Log out and navigate to the login screen
                  Navigator.popUntil(context, (route) => route.isFirst);
                },
                child: Text('Logout'),
                style: ElevatedButton.styleFrom(
                  primary: Colors.red,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
