import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/forgetpassword.dart';
import 'package:health_assistant_app/HomePages/signup.dart';
import 'package:health_assistant_app/healthcare/healthCareDashboard.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';
import 'package:health_assistant_app/theme/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  bool _rememberMe = false;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');
    if (!emailRegex.hasMatch(value)) {
      return 'Enter a valid email address';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters long';
    }
    return null;
  }

  void _login() {
    if (_formKey.currentState!.validate()) {
      if (_selectedRole == null) {
        showCustomSnackBar(context, "Login Failed! Please select a role.", false);
      } else {
        showCustomSnackBar(context, "Login Successful!", true);
        
        // Redirect to HealthCareDashboard after a short delay
        Future.delayed(const Duration(milliseconds: 1500), () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => HealthCareDashboard()),
          );
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // App Logo & Title
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

              // Login Form
              Container(
                width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
                padding: EdgeInsets.all(20),
                margin: EdgeInsets.symmetric(horizontal: 16),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Login to WellnessBridge', 
                          style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18)),
                      SizedBox(height: 20),

                      // Email Input
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.grey),
                          labelText: 'Enter your email address',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: _validateEmail,
                      ),
                      SizedBox(height: 20),

                      // Password Input
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Enter your password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: _validatePassword,
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

                      // Remember Me Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _rememberMe,
                            onChanged: (value) {
                              setState(() {
                                _rememberMe = value ?? false;
                              });
                            },
                          ),
                          Text("Remember Me", style: AppTheme.bodyTextStyle),
                        ],
                      ),

                      // Login Button
                      TextButton(
                        onPressed: _login,
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          minimumSize: Size(600, 48),
                          padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        ),
                        child: Text(
                          "Login",
                          style: AppTheme.bodyTextStyle.copyWith(
                            color: AppTheme.buttonTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => ForgetPasswordPage()),
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: AppTheme.bodyTextStyle.copyWith(
                              color: Colors.blue,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Sign Up Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Don't have an account?", style: AppTheme.bodyTextStyle),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(builder: (context) => SignUpPage()),
                                );
                              },
                              child: Text(
                                'Sign Up',
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
              ),
            ],
          ),
        ),
      ),
    );
  }
}