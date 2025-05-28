// lib/backend_api/health_workers/delete_healthworker.dart
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:wellnessbridge/theme/snack_bar.dart';
import 'package:wellnessbridge/backend_api/health_workers/health_workers_api.dart';
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

Future<void> deleteHealthWorker(
  BuildContext context,
  String workerId,
  bool isDarkMode,
  Function() onRefresh,
) async {
  try {
    // Check for authentication token first
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      CustomSnackBar.showError(context, 'Please login to perform this action');
      return;
    }

    final success = await HealthWorkersApi.deleteHealthWorker(
      int.parse(workerId),
    );
    if (success) {
      CustomSnackBar.showSuccess(context, 'Health worker deleted successfully');
      onRefresh(); // Call the refresh function passed from the parent
    }
  } on Exception catch (e) {
    CustomSnackBar.showError(context, e.toString());
  } on TimeoutException catch (_) {
    CustomSnackBar.showError(context, 'Request timed out. Please try again.');
  } catch (e) {
    CustomSnackBar.showError(context, 'An unexpected error occurred: $e');
  }
}
