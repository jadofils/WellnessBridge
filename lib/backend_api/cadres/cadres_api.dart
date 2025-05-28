import 'dart:convert';
import 'package:http/http.dart' as http;

class CadresApi {
  static const String _baseUrl = 'http://127.0.0.1:8000/api/v1/cadres';

  /// Get all cadres with pagination
  static Future<Map<String, dynamic>> getCadres({
    required int page,
    required int itemsPerPage,
  }) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/page/$page?per_page=$itemsPerPage'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cadres');
    }
  }

  /// Create a new cadre
  static Future<Map<String, dynamic>> createCadre(
    Map<String, dynamic> data,
  ) async {
    final response = await http.post(
      Uri.parse(_baseUrl),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to create cadre');
    }
  }

  /// Update a cadre
  static Future<Map<String, dynamic>> updateCadre(
    int id,
    Map<String, dynamic> data,
  ) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(data),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to update cadre');
    }
  }

  /// Delete a cadre
  static Future<void> deleteCadre(int id) async {
    final response = await http.delete(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete cadre');
    }
  }

  /// Get a single cadre by ID
  static Future<Map<String, dynamic>> getCadre(int id) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/$id'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load cadre');
    }
  }
}
