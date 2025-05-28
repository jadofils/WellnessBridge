//use http://127.0.0.1:8000/api/v1/login#
//email,password, and role

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';

class LoginApi {
  static const String _baseUrl = 'http://127.0.0.1:8000';
  static const String _loginEndpoint = '/api/v1/healthworkers/login';

  /// Authenticates a user with email and password
  ///
  /// [email] The user's email address
  /// [password] The user's password
  /// [role] The user's role (admin, parent, or health_worker)
  ///
  /// Returns a [Map<String, dynamic>] containing the user data and token on success
  /// Throws an [Exception] if the login fails
  static Future<Map<String, dynamic>> loginUser({
    required String email,
    required String password,
    required String role,
  }) async {
    final uri = Uri.parse('$_baseUrl$_loginEndpoint');
    print('Sending login request to: $uri');

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode({
          'email': email,
          'password': password,
          'role': role.toLowerCase().replaceAll(' ', '_'),
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        // Validate role match
        final userRole =
            responseData['user']['role']?.toString().toLowerCase() ?? '';
        final requestedRole = role.toLowerCase().replaceAll(' ', '_');

        if (userRole.isEmpty || userRole != requestedRole) {
          throw Exception(
            'Role mismatch: You are not authorized to access this role',
          );
        }

        // Store the token and user data in shared preferences
        if (responseData['token'] != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString('auth_token', responseData['token']);
          await prefs.setString('user_data', jsonEncode(responseData['user']));
          await prefs.setString('user_role', userRole);
        }

        return responseData;
      }

      // Handle error responses
      Map<String, dynamic> errorData = {};
      try {
        errorData = jsonDecode(response.body);
      } catch (e) {
        errorData = {'message': 'Unknown error occurred'};
      }

      String errorMessage = errorData['message'] ?? 'Login failed';
      if (errorData['errors'] != null) {
        final errors = errorData['errors'] as Map<String, dynamic>;
        errorMessage = errors.values.first[0] ?? errorMessage;
      }

      switch (response.statusCode) {
        case 401:
          throw Exception('Invalid credentials');
        case 403:
          throw Exception(
            'Role mismatch: You are not authorized to access this role',
          );
        case 404:
          throw Exception('User not found');
        case 405:
          throw Exception('Invalid request method. Please contact support.');
        case 422:
          throw Exception(errorMessage);
        case 429:
          throw Exception('Too many login attempts. Please try again later.');
        default:
          throw Exception(errorMessage);
      }
    } on SocketException {
      throw Exception(
        'Network error: Could not connect to the server. Please ensure the backend is running and accessible at $_baseUrl.',
      );
    } on FormatException catch (e) {
      throw Exception(
        'Data format error: Invalid JSON response from server during login. Error: $e',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred during login: $e');
    }
  }

  /// Logs out the current user by clearing stored credentials
  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_data');
    await prefs.remove('user_role');
  }

  /// Checks if a user is currently logged in
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.containsKey('auth_token');
  }

  /// Gets the current user's auth token
  static Future<String?> getAuthToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  /// Gets the current user's data
  static Future<Map<String, dynamic>?> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final userDataString = prefs.getString('user_data');
    if (userDataString != null) {
      return jsonDecode(userDataString);
    }
    return null;
  }

  /// Gets the current user's role
  static Future<String?> getUserRole() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_role');
  }
}
