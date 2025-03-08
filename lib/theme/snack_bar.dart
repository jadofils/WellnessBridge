import 'package:flutter/material.dart';

void showCustomSnackBar(BuildContext context, String message, bool isSuccess) {
  // Get the screen width
  double screenWidth = MediaQuery.of(context).size.width;

  // Set the max width for the SnackBar to be 600px
  double snackBarWidth = screenWidth > 600 ? 600 : screenWidth;

  final snackBar = SnackBar(
    content: Container(
      width: snackBarWidth, // Set the width dynamically based on screen size
      height: 35,  // Fixed height of 35px
      child: Row(
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
    ),
    backgroundColor: isSuccess ? Colors.green : Colors.red, // Green for success, red for failure
    behavior: SnackBarBehavior.floating, // Floating style
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Rounded edges
    duration: Duration(seconds: 3), // Auto-dismiss after 3 seconds
    margin: EdgeInsets.only(top: 16, right: 16), // Position at top-right corner
  );

  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
