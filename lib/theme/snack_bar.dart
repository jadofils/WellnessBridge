import 'package:flutter/material.dart';
import 'package:health_assistant_app/theme/theme.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  // Get the screen width
  double screenWidth = MediaQuery.of(context).size.width;

  // Set the max width for the SnackBar to be 600px
  double snackBarWidth = screenWidth > 600 ? 600 : screenWidth * 0.9;

  // Use your brand colors from AppTheme
  final backgroundColor = isSuccess 
      ? AppTheme.amber         // Success color (amber)
      : AppTheme.rustOrange;   // Error color (rust orange)
  
  final textColor = isSuccess 
      ? AppTheme.sage          // Text color for success (sage)
      : Colors.white;          // Text color for error (white for better contrast)

  final snackBar = SnackBar(
    content: SizedBox(
      width: snackBarWidth,
      height: 35,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
          IconButton(
            icon: Icon(Icons.close, color: textColor, size: 18),
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ],
      ),
    ),
    backgroundColor: backgroundColor,
    behavior: SnackBarBehavior.floating,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
    duration: Duration(seconds: 3),
    // Position at top-right corner
    margin: EdgeInsets.only(
      top: 16, 
      right: 16,
      // For smaller screens, adjust left margin to maintain the right alignment
      left: screenWidth - snackBarWidth - 16 > 0 ? screenWidth - snackBarWidth - 16 : 16,
      bottom: MediaQuery.of(context).size.height - 100, // Push to top
    ),
  );

  // Show the snack bar at the top
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(snackBar);
}

// Extension method to make it easier to show snack bars
extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar(String message) {
    showCustomSnackBar(this, message, true);
  }
  
  void showErrorSnackBar(String message) {
    showCustomSnackBar(this, message, false);
  }
}