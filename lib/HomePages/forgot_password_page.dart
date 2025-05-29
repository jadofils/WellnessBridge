import 'package:flutter/material.dart';
import '../backend_api/forgot_password/forgot_password_api.dart';
import '../theme/theme.dart';
import '../theme/snack_bar.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final TextEditingController _emailController = TextEditingController();
  bool _isEmailValid = true;
  bool _isLoading = false;
  final _forgotPasswordApi = ForgotPasswordApi();

  bool _isValidEmail(String email) {
    String pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$';
    RegExp regex = RegExp(pattern);
    return regex.hasMatch(email);
  }

  Future<void> _handlePasswordReset() async {
    setState(() {
      _isEmailValid = _isValidEmail(_emailController.text);
    });

    if (_isEmailValid) {
      setState(() => _isLoading = true);
      try {
        final result = await _forgotPasswordApi.requestPasswordReset(
          _emailController.text.trim(),
        );

        if (result['success']) {
          if (mounted) {
            context.showSuccessSnackBar(
              "We have emailed your password reset link.",
            );
            Navigator.pushNamed(
              context,
              '/wellnessbridge/page/reset-password',
            );
          }
        } else {
          if (mounted) {
            context.showErrorSnackBar(result['error']);
          }
        }
      } catch (e) {
        if (mounted) {
          context.showErrorSnackBar('An unexpected error occurred');
        }
      } finally {
        if (mounted) {
          setState(() => _isLoading = false);
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double contentWidth = screenWidth > 600 ? 600 : screenWidth;

    return Scaffold(
      backgroundColor: AppTheme.sunBackgroundColor,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: Container(
              width: contentWidth,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.blue.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 8,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
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
                            fit: BoxFit.cover,
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
                  SizedBox(height: 20),
                  Text(
                    'Enter your email to reset password',
                    style: AppTheme.subtitleTextStyle.copyWith(
                      fontSize: 18,
                      color: AppTheme.navy,
                    ),
                  ),
                  SizedBox(height: 30),
                  TextField(
                    controller: _emailController,
                    decoration: InputDecoration(
                      icon: Icon(Icons.email, color: AppTheme.blue),
                      labelText: 'Enter your email address',
                      labelStyle: AppTheme.bodyTextStyle,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: AppTheme.blue),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppTheme.rustOrange,
                          width: 2,
                        ),
                      ),
                      errorText:
                          _isEmailValid
                              ? null
                              : 'Please enter a valid email address',
                      errorStyle: TextStyle(color: AppTheme.rustOrange),
                    ),
                  ),
                  SizedBox(height: 20),
                  TextButton(
                    onPressed: _isLoading ? null : _handlePasswordReset,
                    style: TextButton.styleFrom(
                      backgroundColor: AppTheme.rustOrange,
                      minimumSize: Size(double.infinity, 48),
                      padding: EdgeInsets.symmetric(
                        vertical: 12,
                        horizontal: 20,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child:
                        _isLoading
                            ? CircularProgressIndicator(color: Colors.white)
                            : Text(
                              "Reset Password",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Remember your password?",
                        style: AppTheme.bodyTextStyle.copyWith(
                          color: AppTheme.navy,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          //navigate to login page
                          Navigator.pushNamed(
                            context,
                            '/wellnessbridge/page/login',
                          );
                        },
                        child: Text(
                          'Back to Login',
                          style: AppTheme.bodyTextStyle.copyWith(
                            color: AppTheme.blue,
                            decoration: TextDecoration.underline,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
