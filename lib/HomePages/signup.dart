import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart'; // Import the login page for navigation
import 'package:health_assistant_app/healthcare/healthCareDashboard.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';
import 'package:health_assistant_app/theme/theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedRole;
  bool _agreeToTerms = false;

  // Controllers for the text fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background color
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo & Title (Separate from Form)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset('assets/uploads/logo.png', width: 80, height: 80),
                  SizedBox(width: 10),
                  Text(
                    'WellnessBridge',
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
              SizedBox(height: 30),

              // Sign Up Form
              Container(
                width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 16), // Ensure padding on all sides
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15), // Rounded corners
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 4), // Adds slight elevation
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Create an Account', style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18)),
                    SizedBox(height: 20),
                    // names Input
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.person, color: Colors.grey),
                        labelText: 'Enter your Full Names ',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // phone Input
                    TextField(
                      controller: _phoneController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.phone, color: Colors.grey),
                        labelText: 'Enter your Phone Number',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),
                    // Email Input
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        icon: Icon(Icons.email, color: Colors.grey),
                        labelText: 'Enter your email address',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Password Input
                    TextField(
                      controller: _passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Colors.grey),
                        labelText: 'Enter your password',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Confirm Password Input
                    TextField(
                      controller: _confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        icon: Icon(Icons.lock, color: Colors.grey),
                        labelText: 'Confirm your password',
                        labelStyle: AppTheme.bodyTextStyle,
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Role Dropdown
                    Container(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: DropdownButton<String>(
                        value: _selectedRole,
                        isExpanded: true,
                        items: ['Umunyabuzima', 'Parent', 'Admin']
                            .map((role) => DropdownMenuItem(
                                  value: role,
                                  child: Row(
                                    children: [
                                      Icon(Icons.person, color: Colors.grey),
                                      SizedBox(width: 10),
                                      Text(role, style: AppTheme.bodyTextStyle),
                                    ],
                                  ),
                                ))
                            .toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _selectedRole = newValue;
                          });
                        },
                        hint: Row(
                          children: [
                            Icon(Icons.person, color: Colors.grey),
                            SizedBox(width: 10),
                            Text('Select Role', style: AppTheme.bodyTextStyle),
                          ],
                        ),
                        underline: SizedBox(),
                        icon: Icon(Icons.arrow_drop_down),
                      ),
                    ),
                    SizedBox(height: 30),

                    // Agree to Terms Checkbox
                    Row(
                      children: [
                        Checkbox(
                          value: _agreeToTerms,
                          onChanged: (value) {
                            setState(() {
                              _agreeToTerms = value ?? false;
                            });
                          },
                        ),
                        Text("I agree to the terms and conditions", style: AppTheme.bodyTextStyle),
                      ],
                    ),

                    // Sign Up Button
                    TextButton(
                      onPressed: () {
                        if (_selectedRole != null && _agreeToTerms) {
                          // Clear the inputs
                          _nameController.clear();
                          _phoneController.clear();
                          _emailController.clear();
                          _passwordController.clear();
                          _confirmPasswordController.clear();

                          // Show success message
                          showCustomSnackBar(context, "Sign Up Successful!", true);

                          // Navigate to the HealthCareDashboard
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => HealthCareDashboard()),
                          );
                        } else {
                          showCustomSnackBar(context, "Please complete all fields and agree to the terms.", false);
                        }
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: AppTheme.buttonColor,
                        minimumSize: Size(600, 48),  // Setting the width to 600px and height to 48px
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                      ),
                      child: Text(
                        "Sign Up",
                        style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.buttonTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: 20),

                    // Already have an account link
                    Center(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Already have an account?", style: AppTheme.bodyTextStyle),
                          TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoginPage()),
                              );
                            },
                            child: Text(
                              'Log In',
                              style: AppTheme.bodyTextStyle.copyWith(
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
