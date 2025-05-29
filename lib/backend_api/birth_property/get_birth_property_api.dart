import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class GetBirthPropertyApi {
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
}
