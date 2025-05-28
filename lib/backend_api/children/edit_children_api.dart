import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class EditChildrenApi {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/v1/children';

  // Helper method to handle common API call logic and error parsing
  static Future<Map<String, dynamic>> _sendRequest(
    String method,
    Uri uri,
    Map<String, dynamic> data,
    String token,
  ) async {
    // Convert gender to lowercase if it exists and is a String
    if (data.containsKey('gender') && data['gender'] is String) {
      data['gender'] = data['gender'].toString().toLowerCase();
    }

    http.Response response;

    print('EditChildrenApi - ${method.toUpperCase()} Request to: $uri');
    print('Request Data: ${jsonEncode(data)}');

    try {
      switch (method.toLowerCase()) {
        case 'post':
          response = await http.post(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          );
          break;
        case 'put':
          response = await http.put(
            uri,
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
            body: jsonEncode(data),
          );
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }
    } catch (e) {
      // Handle network or request preparation errors
      print('Network or request error: $e');
      throw Exception(
        'Failed to connect to the server. Please check your internet connection.',
      );
    }

    print('Response Status Code: ${response.statusCode}');
    print('Response Body: ${response.body}');

    final responseData = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200: // OK (for PUT)
      case 201: // Created (for POST)
        print('Operation successful. Parsed Response Data: $responseData');
        return responseData;

      case 400:
        final error = responseData['error'] ?? 'Invalid request data';
        print('Bad Request Error: $error');
        throw Exception('Invalid data: $error');

      case 401:
        print('Authentication Error: Not authorized');
        throw Exception('Authentication failed. Please login again.');

      case 403:
        print('Forbidden Error: Insufficient permissions');
        throw Exception('You do not have permission to perform this action.');

      case 404:
        print('Not Found Error: Resource not found');
        throw Exception('Resource not found.');

      case 422:
        final error = responseData['error'] ?? 'Validation failed';
        print('Validation Error: $error');
        throw Exception('Validation error: $error');

      case 500:
        final error = responseData['error'] ?? 'Server error';
        print('Server Error: $error');
        throw Exception('Server error: $error');

      default:
        print('Unexpected Error: ${response.body}');
        throw Exception(
          'An unexpected error occurred: ${responseData['message'] ?? 'Unknown error'}',
        );
    }
  }

  static Future<Map<String, dynamic>> createChild(
    Map<String, dynamic> data,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }
    return _sendRequest('post', Uri.parse(_baseUrl), data, token);
  }

  static Future<Map<String, dynamic>> updateChild(
    String id,
    Map<String, dynamic> data,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }
    return _sendRequest('put', Uri.parse('$_baseUrl/$id'), data, token);
  }
}
