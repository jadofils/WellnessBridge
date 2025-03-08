import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  final snackBar = SnackBar(
    content: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            message,
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        IconButton(
          icon: Icon(Icons.close, color: Colors.white),
          onPressed: () {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
          },
        ),
      ],
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red, // Green for success, red for failure
    behavior: SnackBarBehavior.floating, // Floating style
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded edges
    duration: Duration(seconds: 3), // Auto-dismiss after 3 seconds
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
