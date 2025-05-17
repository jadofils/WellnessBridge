import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart';
import 'package:health_assistant_app/HomePages/signup.dart';
import 'package:health_assistant_app/HomePages/forgetpassword.dart';
import 'package:health_assistant_app/healthcare/healthCareDashboard.dart';
import 'package:health_assistant_app/utils/validation_utils.dart';


void main() {
  runApp(const WellnessBridgeApp());
}

class WellnessBridgeApp extends StatelessWidget {
  const WellnessBridgeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'WellnessBridge',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/signup', // Changed to '/signup'
      routes: {
         
        '/signup': (context) => SignUpPage(), // Removed const
        '/login': (context) => LoginPage(),// Removed const
        '/forgot-password': (context) => ForgetPasswordPage(), // Removed const
        '/healthcare-dashboard': (context) => HealthCareDashboard(), // Removed const
       
      },
      onUnknownRoute: (settings) => MaterialPageRoute(
        builder: (context) => Scaffold(
          body: Center(
            child: Text('No route defined for ${settings.name}'),
          ),
        ),
      ),
    );
  }
}