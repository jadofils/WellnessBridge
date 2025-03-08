import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';
import 'package:health_assistant_app/theme/theme.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedGender; // To store gender selection
  String? _selectedRole; // To store the selected role
  bool _agreeToTerms = false; // Checkbox for Terms and Conditions

  // Controllers for text fields
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('WellnessBridge'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Text in a Row
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset('assets/uploads/logo.png', width: 80, height: 80),
                  SizedBox(width: 10),
                  Text(
                    'WellnessBridge',
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Text(
                'Sign Up to WellnessBridge',
                style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(height: 30),

              // First Name TextField
              TextField(
                controller: _firstNameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.grey),
                  labelText: 'Enter your first name',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Last Name TextField
              TextField(
                controller: _lastNameController,
                decoration: InputDecoration(
                  icon: Icon(Icons.person, color: Colors.grey),
                  labelText: 'Enter your last name',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Email TextField
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

              // Phone TextField
              TextField(
                controller: _phoneController,
                decoration: InputDecoration(
                  icon: Icon(Icons.phone, color: Colors.grey),
                  labelText: 'Enter your phone number',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Address TextField
              TextField(
                controller: _addressController,
                decoration: InputDecoration(
                  icon: Icon(Icons.home, color: Colors.grey),
                  labelText: 'Enter your address',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Password TextField
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

              // Gender Dropdown
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedGender,
                  items:
                      <String>[
                        'Male',
                        'Female',
                        'Other',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey),
                              SizedBox(width: 10),
                              Text(value, style: AppTheme.bodyTextStyle),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedGender = newValue;
                    });
                  },
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Select Gender', style: AppTheme.bodyTextStyle),
                    ],
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 30),

              // Role Dropdown
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: DropdownButton<String>(
                  value: _selectedRole,
                  items:
                      <String>[
                        'Umunyabuzima',
                        'Parent',
                        'Admin',
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Row(
                            children: [
                              Icon(Icons.person, color: Colors.grey),
                              SizedBox(width: 10),
                              Text(value, style: AppTheme.bodyTextStyle),
                            ],
                          ),
                        );
                      }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue;
                    });
                  },
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey),
                      SizedBox(width: 10),
                      Text('Select Role', style: AppTheme.bodyTextStyle),
                    ],
                  ),
                  icon: Icon(Icons.arrow_drop_down),
                  underline: SizedBox(),
                ),
              ),
              SizedBox(height: 30),

              // Agree to Terms Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _agreeToTerms,
                    onChanged: (bool? value) {
                      setState(() {
                        _agreeToTerms = value ?? false;
                      });
                    },
                  ),
                  Text(
                    "I agree to the terms and conditions",
                    style: AppTheme.bodyTextStyle,
                  ),
                ],
              ),

              // Sign Up Button
              TextButton(
                onPressed: () {
                  // Handle sign up action here
                  if (_agreeToTerms &&
                      _firstNameController.text.isNotEmpty &&
                      _lastNameController.text.isNotEmpty &&
                      _emailController.text.isNotEmpty &&
                      _phoneController.text.isNotEmpty &&
                      _addressController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      _selectedGender != null &&
                      _selectedRole != null) {
                    showCustomSnackBar(
                      context,
                      "Signup successfully done",
                      true,
                    );

                    // Clear the form fields
                    _firstNameController.clear();
                    _lastNameController.clear();
                    _emailController.clear();
                    _phoneController.clear();
                    _addressController.clear();
                    _passwordController.clear();
                    setState(() {
                      _selectedGender = null;
                      _selectedRole = null;
                      _agreeToTerms = false;
                    });
                  } else {
                    showCustomSnackBar(
                      context,
                      "Signup Failed! Please Fill all fields",
                      false,
                    );
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.buttonColor,
                  minimumSize: Size(double.infinity, 48),
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
            ],
          ),
        ),
      ),
    );
  }
}
