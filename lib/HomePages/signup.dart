import 'package:flutter/material.dart';
import 'package:health_assistant_app/HomePages/login.dart'; // Import the login page
import 'package:health_assistant_app/theme/snack_bar.dart';
import 'package:health_assistant_app/theme/theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedRole;
  bool _agreeToTerms = false;
  final _formKey = GlobalKey<FormState>(); // Form key for validation

  // Controllers for user input fields
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Email validation using RegExp
  bool isValidEmail(String email) {
    final emailRegex = RegExp(r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$');
    return emailRegex.hasMatch(email);
  }

  // Phone number validation
  bool isValidPhone(String phone) {
    final phoneRegex = RegExp(r'^\d{10,15}$'); // Allows 10-15 digit numbers
    return phoneRegex.hasMatch(phone);
  }

  // Function to handle sign up
  void _handleSignUp() {
    if (_formKey.currentState!.validate() && _agreeToTerms) {
      // Show success message
      showCustomSnackBar(context, "Sign Up Successful!", true);

      // Clear all fields
      _nameController.clear();
      _phoneController.clear();
      _emailController.clear();
      _passwordController.clear();
      _confirmPasswordController.clear();
      setState(() {
        _selectedRole = null;
        _agreeToTerms = false;
      });

      // Navigate to Login Page
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } else {
      showCustomSnackBar(context, "Please complete all fields and agree to the terms.", false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // App Logo & Title
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/uploads/logo.png', width: 80, height: 80),
                    SizedBox(width: 10),
                    Text('WellnessBridge', style: AppTheme.titleTextStyle.copyWith(fontSize: 32)),
                  ],
                ),
                SizedBox(height: 30),

                // Sign Up Form
                Container(
                  width: MediaQuery.of(context).size.width > 600 ? 400 : double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(color: Colors.black12, blurRadius: 8, spreadRadius: 2, offset: Offset(0, 4)),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Create an Account', style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18)),
                      SizedBox(height: 20),

                      // Full Name Input
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Colors.grey),
                          labelText: 'Full Name',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Name is required" : null,
                      ),
                      SizedBox(height: 20),

                      // Phone Number Input
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone, color: Colors.grey),
                          labelText: 'Phone Number',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Phone number is required";
                          if (!isValidPhone(value)) return "Enter a valid phone number (10-15 digits)";
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Email Input
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.grey),
                          labelText: 'Email Address',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Email is required";
                          if (!isValidEmail(value)) return "Enter a valid email";
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Password Input
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.length < 6 ? "Password must be at least 6 characters" : null,
                      ),
                      SizedBox(height: 20),

                      // Confirm Password Input
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Confirm Password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value != _passwordController.text ? "Passwords do not match" : null,
                      ),
                      SizedBox(height: 20),

                      // Role Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                        ),
                        items: ['Umunyabuzima', 'Parent', 'Admin']
                            .map((role) => DropdownMenuItem(value: role, child: Text(role)))
                            .toList(),
                        onChanged: (newValue) => setState(() => _selectedRole = newValue),
                        validator: (value) => value == null ? "Please select a role" : null,
                      ),
                      SizedBox(height: 30),

                      // Agree to Terms Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                          ),
                          Flexible(
                            child: Text("I agree to the terms and conditions", style: AppTheme.bodyTextStyle),
                          ),
                        ],
                      ),

                      // Sign Up Button
                      TextButton(
                        onPressed: _handleSignUp,
                        style: TextButton.styleFrom(
                          backgroundColor: AppTheme.buttonColor,
                          minimumSize: Size(600, 48),
                          padding: EdgeInsets.symmetric(vertical: 12),
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

                      // Already have an account? Login Link
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text("Already have an account?", style: AppTheme.bodyTextStyle),
                            TextButton(
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => LoginPage()),
                                );
                              },
                              child: Text('Log In', style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline)),
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
      ),
    );
  }
}
