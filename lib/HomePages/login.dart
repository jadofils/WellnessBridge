import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String? _selectedRole; // State variable to store the selected role
  bool _rememberMe = false; // State variable for "Remember Me" checkbox

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
                'Login to WellnessBridge',
                style: AppTheme.subtitleTextStyle.copyWith(fontSize: 18),
              ),
              SizedBox(height: 30),
              
              // Email TextField
              TextField(
                decoration: InputDecoration(
                  icon: Icon(Icons.email, color: Colors.grey), // Email icon
                  labelText: 'Enter your email address',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Password TextField
              TextField(
                obscureText: true, // Hide password text
                decoration: InputDecoration(
                  icon: Icon(Icons.lock, color: Colors.grey), // Lock icon
                  labelText: 'Enter your password',
                  labelStyle: AppTheme.bodyTextStyle,
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20),

              // Role Dropdown
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey), // Border color
                  borderRadius: BorderRadius.circular(8), // Rounded corners
                ),
                child: DropdownButton<String>(
                  value: _selectedRole, // Current selected value
                  items: <String>['Umunyabuzima', 'Parent', 'Admin']
                      .map<DropdownMenuItem<String>>((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Row(
                        children: [
                          Icon(Icons.person, color: Colors.grey), // Person icon
                          SizedBox(width: 10), // Space between icon and text
                          Text(value, style: AppTheme.bodyTextStyle),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedRole = newValue; // Update the selected role
                    });
                  },
                  isExpanded: true,
                  hint: Row(
                    children: [
                      Icon(Icons.person, color: Colors.grey), // Hint icon
                      SizedBox(width: 10), // Space between icon and text
                      Text(
                        'Select Role',
                        style: AppTheme.bodyTextStyle,
                      ),
                    ],
                  ),
                  icon: Icon(Icons.arrow_drop_down), // Dropdown icon
                  underline: SizedBox(), // Remove the default underline (optional)
                ),
              ),
              SizedBox(height: 30),

              // Remember Me Checkbox
              Row(
                children: [
                  Checkbox(
                    value: _rememberMe,
                    onChanged: (bool? value) {
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
                onPressed: () {
                  if (_selectedRole != null) {
                    print(
                      "Selected Role: $_selectedRole",
                    ); // Print the selected role
                  } else {
                    print("Please select a role"); // Prompt to select a role
                  }
                },
                style: TextButton.styleFrom(
                  backgroundColor: AppTheme.buttonColor,
                  minimumSize: Size(
                    double.infinity,
                    48,
                  ), // Full width and fixed height
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

              // Forget Password Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextButton(
                    onPressed: () {
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => ForgetPasswordPage()));
                    },
                    child: Text(
                      'Forget Password?',
                      style: AppTheme.bodyTextStyle.copyWith(
                        color: Colors.blue,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),

              // Sign Up Link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?", style: AppTheme.bodyTextStyle),
                  TextButton(
                    onPressed: () {
                      // Navigate to Sign Up Screen
                      // Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpPage()));
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
            ],
          ),
        ),
      ),
    );
  }
}
