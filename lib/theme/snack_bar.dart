import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/theme.dart';

class CustomSnackBar {
  static void show(
    BuildContext context,
    String message, {
    bool isSuccess = true,
    Duration duration = const Duration(seconds: 3),
  }) {
    final overlay = Overlay.of(context);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    // Create overlay entry for top-right positioning
    late OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder:
          (context) => Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            left:
                MediaQuery.of(context).size.width > 600
                    ? MediaQuery.of(context).size.width - 400
                    : 16,
            child: Material(
              color: Colors.transparent,
              child: AnimatedContainer(
                duration: Duration(milliseconds: 300),
                child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  decoration: BoxDecoration(
                    color:
                        isSuccess
                            ? (isDark
                                ? AppTheme.nightPrimaryColor
                                : Colors.green)
                            : Colors.red,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 8,
                        offset: Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        isSuccess ? Icons.check_circle : Icons.error,
                        color: Colors.white,
                        size: 20,
                      ),
                      SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          message,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => overlayEntry.remove(),
                        child: Icon(
                          Icons.close,
                          color: Colors.white.withOpacity(0.8),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
    );

    overlay.insert(overlayEntry);

    // Auto-remove after duration
    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }

  static void showSuccess(BuildContext context, String message) {
    show(context, message, isSuccess: true);
  }

  static void showError(BuildContext context, String message) {
    show(context, message, isSuccess: false);
  }
}

// Extension method to make it easier to show snack bars
extension SnackBarExtension on BuildContext {
  void showSuccessSnackBar(String message) {
    CustomSnackBar.showSuccess(this, message);
  }

  void showErrorSnackBar(String message) {
    CustomSnackBar.showError(this, message);
  }
}
