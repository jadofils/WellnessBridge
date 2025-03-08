import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/theme.dart'; // Adjust the import path as needed

class ForgetPasswordPage extends StatefulWidget {
  @override
  _ForgetPasswordPageState createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true; // To check if the email entered is valid

  // Function to validate email
  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Forget Password'),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo and Text in a Row (same as LoginPage)
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    'assets/uploads/logo.png', // Path to your logo
                    width: 80, // Adjust width as needed
                    height: 80, // Adjust height as needed
                  ),
                  SizedBox(width: 10), // Space between logo and text
                  Text(
                    'WellnessBridge',
                    style: AppTheme.titleTextStyle.copyWith(fontSize: 32),
                  ),
                ],
              ),
              SizedBox(height: 20), // Space between the row and the next widget
              Text(
                'Enter your email to reset password',
                style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(height: 30),

              // Email TextField
              TextField(
                controller: _emailController,
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.grey), // Email icon
                  labelText: 'Enter your email address',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                  errorText: _isEmailValid ? null : 'Please enter a valid email address',
                ),
              ),
              SizedBox(height: 20),

              // Reset Password Button
              TextButton(
                onPressed: () {
                  setState(() {
                    // Validate email before submitting
                    _isEmailValid = _isValidEmail(_emailController.text);
                  });

                  if (_isEmailValid) {
                    // Call the function to send password reset email
                    print('Sending password reset link to ${_emailController.text}');
                    // You can replace this print statement with actual API call
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.buttonColor,
                  minimumSize: Size(double.infinity, 48), // Full width and fixed height
                  padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                ),
                child: Text(
                  "Reset Password",
                  style: AppTheme.bodyTextStyle.copyWith(
                    color: AppTheme.buttonTextColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Back to Login Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context); // Go back to the login screen
                    },
                    child: Text(
                      'Back to Login',
                      style: AppTheme.bodyTextStyle.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
