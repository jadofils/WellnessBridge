import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wellnessbridge/backend_api/auth/login_api.dart';

class HealthWorkersApi {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/v1/healthworkers';

  /// Get all health workers
  static Future<Map<String, dynamic>> getHealthWorkers() async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.get(
      Uri.parse(_baseUrl),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load health workers');
    }
  }

  /// Get a single health worker by ID
  static Future<Map<String, dynamic>> getHealthWorker(int id) async {
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
      throw Exception('Failed to load health worker');
    }
  }

  /// Search health workers
  static Future<Map<String, dynamic>> searchHealthWorkers(String query) async {
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
      throw Exception('Failed to search health workers');
    }
  }

  /// Create a new health worker
  static Future<Map<String, dynamic>> createHealthWorker(
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
      throw Exception('Failed to create health worker');
    }
  }

  /// Update a health worker
  static Future<Map<String, dynamic>> updateHealthWorker(
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
      throw Exception('Failed to update health worker');
    }
  }

  /// Delete a health worker
  static Future<bool> deleteHealthWorker(int id) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http
        .delete(
          Uri.parse('$_baseUrl/$id'),
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        )
        .timeout(const Duration(seconds: 30));

    if (response.statusCode == 204 || response.statusCode == 200) {
      return true;
    } else if (response.statusCode == 404) {
      throw Exception('Health worker not found');
    } else {
      final errorData = json.decode(response.body);
      throw Exception(errorData['message'] ?? 'Failed to delete health worker');
    }
  }

  /// Assign a health worker to a cadre
  static Future<Map<String, dynamic>> assignToCadre(
    int healthWorkerId,
    int cadreId,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/$healthWorkerId/assign'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({'cadre_id': cadreId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to assign health worker to cadre');
    }
  }

  /// Update health worker profile
  static Future<Map<String, dynamic>> updateProfile(
    int id,
    Map<String, dynamic> data,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('Not authenticated');
    }

    final response = await http.put(
      Uri.parse('$_baseUrl/$id/update-profile'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update health worker profile');
    }
  }

  static Future<Map<String, dynamic>> assignCadre(
    int workerId,
    int cadreId,
  ) async {
    final token = await LoginApi.getAuthToken();
    if (token == null) {
      throw Exception('User not authenticated');
    }

    final response = await http.post(
      Uri.parse('$_baseUrl/$workerId/assign-cadre'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({'cadre_id': cadreId}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to assign cadre: ${response.body}');
    }
  }
}
