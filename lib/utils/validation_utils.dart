// lib/utils/validation_utils.dart
import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/theme/theme.dart';

class ValidationUtils {
  // Email validation
  static bool isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  // Strong password validation
  static bool isStrongPassword(String password) {
    if (password.length < 8) return false;
    if (!password.contains(RegExp(r'[A-Z]'))) return false;
    if (!password.contains(RegExp(r'[a-z]'))) return false;
    if (!password.contains(RegExp(r'[0-9]'))) return false;
    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) return false;
    return true;
  }

  // Phone validation
  static bool isValidPhone(String phone) {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(phone);
  }

  // Password validation
  static bool isValidPassword(String password) {
    return password.length >= 8;
  }

  // Phone number validation
  static bool isValidPhoneNumber(String phone) {
    return RegExp(r'^\+?[\d\s-]{10,}$').hasMatch(phone);
  }

  // Show password requirements dialog
  static void showPasswordRequirements(BuildContext context) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(
              "Password Requirements",
              style: TextStyle(
                color: AppTheme.rustOrange,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _requirementRow("At least 8 characters"),
                _requirementRow("1 uppercase letter"),
                _requirementRow("1 lowercase letter"),
                _requirementRow("1 number"),
                _requirementRow("1 special character"),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: Text("OK", style: TextStyle(color: AppTheme.rustOrange)),
              ),
            ],
            backgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
          ),
    );
  }

  // Helper for password requirements dialog
  static Widget _requirementRow(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Icon(Icons.check_circle, color: AppTheme.blue, size: 16),
          SizedBox(width: 8),
          Text(text, style: TextStyle(color: AppTheme.navy)),
        ],
      ),
    );
  }

  // Validate form and show error if invalid
  static bool validateForm(BuildContext context, GlobalKey<FormState> formKey) {
    if (!formKey.currentState!.validate()) {
      context.showErrorSnackBar("Please correct the errors in the form");
      return false;
    }
    return true;
  }
}

// Extension method for easier validation error messages
extension FormFieldValidators on String? {
  String? validateEmail() {
    if (this == null || this!.isEmpty) return "Email is required";
    if (!ValidationUtils.isValidEmail(this!)) return "Enter a valid email";
    return null;
  }

  String? validatePassword() {
    if (this == null || this!.isEmpty) return "Password is required";
    if (!ValidationUtils.isStrongPassword(this!)) {
      return "Password doesn't meet requirements";
    }
    return null;
  }

  String? validatePhone() {
    if (this == null || this!.isEmpty) return "Phone number is required";
    if (!ValidationUtils.isValidPhone(this!)) {
      return "Enter a valid phone number";
    }
    return null;
  }

  String? validateName() {
    if (this == null || this!.isEmpty) return "Name is required";
    if (this!.length < 2) return "Name is too short";
    return null;
  }

  String? validatePasswordMatch(String password) {
    if (this != password) return "Passwords don't match";
    return null;
  }
}
