import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class BirthPropertyApi {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api/v1/birth-properties';

  // Get all birth properties with pagination
  static Future<Map<String, dynamic>> getBirthProperties({
    int page = 1,
    int perPage = 10,
  }) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl?page=$page&per_page=$perPage'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load birth properties');
    }
  }

  // Get a single birth property by ID
  static Future<Map<String, dynamic>> getBirthPropertyById(int id) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load birth property details');
    }
  }

  // Search birth properties
  static Future<Map<String, dynamic>> searchBirthProperties(
    String query,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/search?query=$query'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search birth properties');
    }
  }

  // Create a new birth property
  static Future<Map<String, dynamic>> createBirthProperty(
    Map<String, dynamic> data,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create birth property');
    }
  }

  // Update a birth property
  static Future<Map<String, dynamic>> updateBirthProperty(
    int id,
    Map<String, dynamic> data,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update birth property');
    }
  }

  // Delete a birth property
  static Future<void> deleteBirthProperty(int id) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete birth property');
    }
  }
}
