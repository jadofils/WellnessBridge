import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart';
import 'package:health_assistant_app/HomePages/AdminDashboard.dart';
import 'package:health_assistant_app/HomePages/ParentDashboard.dart';
import 'package:health_assistant_app/HomePages/UmunyabuzimaDashboard.dart';
import 'package:health_assistant_app/HomePages/forgetpassword.dart';
import 'package:health_assistant_app/HomePages/signup.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WellnessBridge',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/adminDashboard': (context) => AdminDashboard(),
        '/parentDashboard': (context) => ParentDashboard(),
        '/umunyabuzimaDashboard': (context) => UmunyabuzimaDashboard(),
        '/forgetPassword': (context) => ForgetPasswordPage(),
        '/signUp': (context) => SignUpPage(),
      },
    );
  }
}
