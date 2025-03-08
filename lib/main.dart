import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart';

void main() {
  runApp(LandingPage());
}

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: Center(
            child: LoginPage(), // Your LoginPage is centered and within SafeArea
          ),
        ),
      ),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}