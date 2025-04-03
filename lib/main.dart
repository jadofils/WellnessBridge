import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart';
import 'package:health_assistant_app/HomePages/signup.dart';
import 'package:health_assistant_app/healthcare/healthCareDashboard.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    initialRoute: '/login',
    routes: {
      '/login': (context) => LoginPage(),
      '/signup': (context) => SignUpPage(),
      '/dashboard': (context) => HealthCareDashboard(),
    },
  ));
}
