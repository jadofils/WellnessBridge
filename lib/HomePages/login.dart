// lib/HomePages/login.dart
import 'package:flutter/material.dart';
import 'package:wellnessbridge/backend_api/auth/login_api.dart';
import 'package:wellnessbridge/frontend/admin/dashboard/admin_dashboard.dart';
import 'package:wellnessbridge/frontend/parent/dashboard/parent_dashboard.dart';
import 'package:wellnessbridge/frontend/umunyabuzima/dashboard/umunyabuzima_dashboard.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/theme/theme.dart';
import 'package:wellnessbridge/services/notification_services.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  String? _selectedRole;
  bool _rememberMe = false;
  bool _isLoading = false;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    if (!_formKey.currentState!.validate()) {
      CustomSnackBar.showError(
        context,
        "Please correct the errors in the form",
      );
      return;
    }

    if (_selectedRole == null) {
      CustomSnackBar.showError(context, "Please select a role");
      return;
    }

    setState(() => _isLoading = true);

    try {
      final response = await LoginApi.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text,
        role: _selectedRole!.toLowerCase().replaceAll(' ', '_'),
      );

      CustomSnackBar.showSuccess(context, "Login successful!");

      // Redirect to appropriate dashboard based on role
      Widget dashboard;
      switch (_selectedRole!.toLowerCase()) {
        case 'admin':
          dashboard = AdminDashboard();
          break;
        case 'parent':
          dashboard = ParentDashboard();
          break;
        case 'umunyabuzima':
          dashboard = UmunyabuzimaDashboard();
          break;
        default:
          throw Exception('Invalid role');
      }

      // Navigate to the appropriate dashboard
      Future.delayed(const Duration(milliseconds: 500), () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => dashboard),
        );
      });
    } catch (e) {
      if (mounted) {
        CustomSnackBar.showError(
          context,
          e.toString().replaceFirst('Exception: ', ''),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final Brightness brightness = Theme.of(context).brightness;
    final bool isDarkMode = brightness == Brightness.dark;
    final Color backgroundColor =
        isDarkMode
            ? AppTheme.nightBackgroundColor
            : AppTheme.sunBackgroundColor;

    return Scaffold(
      backgroundColor: backgroundColor,
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
                    Container(
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        color: AppTheme.amber.withOpacity(0.2),
                        shape: BoxShape.circle,
                      ),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/uploads/logo.png',
                          width: 80,
                          height: 80,
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      'WellnessBridge',
                      style: AppTheme.titleTextStyle.copyWith(
                        fontSize: 32,
                        color: AppTheme.rustOrange,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 30),

                // Login Form
                Container(
                  width:
                      MediaQuery.of(context).size.width > 600
                          ? 400
                          : double.infinity,
                  padding: EdgeInsets.all(20),
                  margin: EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.blue.withOpacity(0.2),
                        blurRadius: 8,
                        spreadRadius: 2,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Welcome Back',
                        style: AppTheme.subtitleTextStyle.copyWith(
                          fontSize: 18,
                          color: AppTheme.navy,
                        ),
                      ),
                      SizedBox(height: 20),

                      // Email Field
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          icon: Icon(Icons.email, color: AppTheme.blue),
                          labelText: 'Email Address',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ),
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Email is required";
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                          ).hasMatch(value)) {
                            return "Enter a valid email";
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 15),

                      // Password Field
                      TextFormField(
                        controller: _passwordController,
                        obscureText: _obscurePassword,
                        decoration: InputDecoration(
                          icon: Icon(Icons.lock, color: AppTheme.blue),
                          labelText: 'Password',
                          labelStyle: AppTheme.bodyTextStyle,
                          border: OutlineInputBorder(),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: AppTheme.rustOrange,
                              width: 2,
                            ),
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscurePassword
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: AppTheme.blue,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscurePassword = !_obscurePassword;
                              });
                            },
                          ),
                        ),
                        validator: (value) {
                          if (value!.isEmpty) return "Password is required";
                          return null;
                        },
                      ),
                      SizedBox(height: 20),

                      // Role Dropdown
                      DropdownButtonFormField<String>(
                        value: _selectedRole,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.person, color: AppTheme.blue),
                          labelText: 'Select Role',
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: AppTheme.rustOrange),
                          ),
                        ),
                        items:
                            ['Umunyabuzima', 'Parent', 'Admin']
                                .map(
                                  (role) => DropdownMenuItem(
                                    value: role,
                                    child: Text(role),
                                  ),
                                )
                                .toList(),
                        onChanged:
                            (newValue) =>
                                setState(() => _selectedRole = newValue),
                        validator:
                            (value) =>
                                value == null ? "Please select a role" : null,
                        dropdownColor: Colors.white,
                        icon: Icon(Icons.arrow_drop_down, color: AppTheme.blue),
                      ),
                      SizedBox(height: 20),

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
                            activeColor: AppTheme.rustOrange,
                          ),
                          Text(
                            "Remember Me",
                            style: TextStyle(color: AppTheme.navy),
                          ),
                        ],
                      ),
                      SizedBox(height: 20),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppTheme.rustOrange,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                            disabledBackgroundColor: AppTheme.rustOrange
                                .withOpacity(0.5),
                          ),
                          child:
                              _isLoading
                                  ? CircularProgressIndicator(
                                    color: Colors.white,
                                  )
                                  : Text(
                                    "LOGIN",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                        ),
                      ),
                      SizedBox(height: 15),

                      // Forgot Password
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              '/wellnessbridge/page/forgot-password',
                            );
                          },
                          child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                              color: AppTheme.amber,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20),

                      // Sign Up Link
                      Center(
                        child: TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              '/wellnessbridge/page/signup',
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(color: AppTheme.navy),
                              children: [
                                TextSpan(
                                  text: "Sign Up",
                                  style: TextStyle(
                                    color: AppTheme.blue,
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
