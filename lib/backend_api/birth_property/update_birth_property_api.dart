import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class UpdateBirthPropertyApi {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api/v1/birth-properties';

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
}
