import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class EditBirthPropertyApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1/birth-properties';

  static Future<Map<String, dynamic>> editBirthProperty({
    required int id,
    required Map<String, dynamic> data,
    bool isByChild = false,
  }) async {
    try {
      final token = await LoginApi.getAuthToken();
      if (token == null) {
        throw Exception('Authentication token not found');
      }

      final url = isByChild ? '$baseUrl/by-child/$id' : '$baseUrl/$id';

      final response = await http.put(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to edit birth property: ${response.body}');
      }
    } catch (e) {
      throw Exception('Error editing birth property: $e');
    }
  }
}
