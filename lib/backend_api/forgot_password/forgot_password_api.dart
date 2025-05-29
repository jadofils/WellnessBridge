import 'dart:convert';
import 'package:http/http.dart' as http;

class ForgotPasswordApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  Future<Map<String, dynamic>> requestPasswordReset(String email) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/password/forgot'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email}),
      );

      if (response.statusCode == 200) {
        print(response.body);
        return {
          'success': true,
          'message': 'Password reset link sent successfully',
          'data': jsonDecode(response.body),
        };
      } else {
        print(jsonDecode(response.body)['message'] ?? 'Unknown error occurred');

        return {
          'success': false,
          'message': 'Failed to send password reset link',
          'error':
              jsonDecode(response.body)['message'] ?? 'Unknown error occurred',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Network error occurred',
        'error': e.toString(),
      };
    }
  }
}
