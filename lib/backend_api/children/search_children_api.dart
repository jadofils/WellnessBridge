import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class SearchChildrenApi {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/v1/children';

  static Future<Map<String, dynamic>> searchChildren(String query) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl?search=$query'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to search children');
    }
  }
}
