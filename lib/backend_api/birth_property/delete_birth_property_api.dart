import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class DeleteBirthPropertyApi {
  static const String _baseUrl =
      'http://127.0.0.1:8000/api/v1/birth-properties';

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
