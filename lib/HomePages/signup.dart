import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/snack_bar.dart';
import 'package:health_assistant_app/theme/theme.dart';
import 'package:health_assistant_app/utils/validation_utils.dart';

class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? _selectedRole;
  bool _agreeToTerms = false;
  bool _isLoading = false;
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  // Mock function to check if email exists (replace with actual API call)
  Future<bool> _checkEmailExists(String email) async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    
    // Mock list of existing emails - replace with actual database check
    final existingEmails = ['test@example.com', 'user@domain.com'];
    return existingEmails.contains(email);
  }

  // Enhanced email validation
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      caseSensitive: false,
    );
    return emailRegex.hasMatch(email);
  }

  // Strong password validation (minimum 8 chars with at least 1 uppercase, 1 lowercase, 1 number, 1 special char)
  bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // Phone validation
  bool isValidPhone(String phone) {
    return RegExp(r'^\d{10,15}$').hasMatch(phone);
  }

  // Handle sign up with email existence check
  Future<void> _handleSignUp() async {
    if (!_formKey.currentState!.validate()) {
      showCustomSnackBar(context, "Please correct the errors in the form", false);
      return;
    }

    if (!_agreeToTerms) {
      showCustomSnackBar(context, "You must agree to the terms and conditions", false);
      return;
    }

    setState(() => _isLoading = true);

    try {
      // Check if email exists
      final emailExists = await _checkEmailExists(_emailController.text.trim());
      
      if (emailExists) {
        showCustomSnackBar(context, "This email is already registered", false);
        return;
      }

      // Proceed with registration (replace with actual registration logic)
      await Future.delayed(Duration(seconds: 2)); // Simulate registration delay
      
      showCustomSnackBar(context, "Registration successful!", true);
      
      // Clear form and navigate to login
      _formKey.currentState!.reset();
      setState(() {
        _selectedRole = null;
        _agreeToTerms = false;
      });
      
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    } catch (e) {
      showCustomSnackBar(context, "Registration failed: ${e.toString()}", false);
    } finally {
      setState(() => _isLoading = false);
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

                      // Full Name
                      TextFormField(
                        controller: _nameController,
                        decoration: InputDecoration(
                          icon: Icon(Icons.person, color: Colors.grey),
                          labelText: 'Full Name',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) => value!.isEmpty ? "Name is required" : null,
                      ),
                      SizedBox(height: 15),

                      // Phone Number
                      TextFormField(
                        controller: _phoneController,
                        keyboardType: TextInputType.phone,
                        decoration: InputDecoration(
                          icon: Icon(Icons.phone, color: Colors.grey),
                          labelText: 'Phone Number',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Phone number is required";
                          if (!isValidPhone(value)) return "Enter 10-15 digit number";
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Email with existence check
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: Colors.grey),
                          labelText: 'Email Address',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Email is required";
                          if (!isValidEmail(value)) return "Enter a valid email";
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Password with strength validation
                      TextFormField(
                        controller: _passwordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Password',
                          border: OutlineInputBorder(),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.info_outline),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Password Requirements"),
                                  content: Text(
                                    "• At least 8 characters\n"
                                    "• 1 uppercase letter\n"
                                    "• 1 lowercase letter\n"
                                    "• 1 number\n"
                                    "• 1 special character",
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Password is required";
                          if (!isStrongPassword(value)) {
                            return "Password doesn't meet requirements";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Confirm Password
                      TextFormField(
                        controller: _confirmPasswordController,
                        obscureText: true,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: Colors.grey),
                          labelText: 'Confirm Password',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) {
                          if (value != _passwordController.text) {
                            return "Passwords don't match";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Role Selection
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: Colors.grey),
                          labelText: 'Select Role',
                        ),
                        items: ['Umunyabuzima', 'Parent', 'Admin']
                            .map((role) => DropdownMenuItem(
                                  value: role,
                                  child: Text(role),
                                ))
                            .toList(),
                        onChanged: (newValue) => setState(() => _selectedRole = newValue),
                        validator: (value) => value == null ? "Please select a role" : null,
                      ),
                      SizedBox(height: 20),

                      // Terms Checkbox
                      Row(
                        children: [
                          Checkbox(
                            value: _agreeToTerms,
                            onChanged: (value) => setState(() => _agreeToTerms = value ?? false),
                          ),
                          Flexible(
                            child: GestureDetector(
                              onTap: () {
                                // Show terms and conditions
                              },
                              child: Text(
                                "I agree to the terms and conditions",
                                style: TextStyle(decoration: TextDecoration.underline),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Sign Up Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleSignUp,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.buttonColor,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  "SIGN UP",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Login Link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(builder: (context) => LoginPage()),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Already have an account? ",
                              style: TextStyle(color: Colors.black),
                              children: [
                                TextSpan(
                                  text: "Log In",
                                  style: TextStyle(
                                    color: Colors.blue,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}