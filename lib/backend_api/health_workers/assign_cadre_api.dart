import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/cadre.dart';
import '../../models/health_worker.dart';

class AssignCadreApi {
  static const String baseUrl = 'http://127.0.0.1:8000/api/v1';

  // Get all available cadres
  static Future<List<Cadre>> getAllCadres() async {
    try {
      final response = await http.get(Uri.parse('$baseUrl/cadres'));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        final List<dynamic> cadresJson = data['data'];
        return cadresJson.map((json) => Cadre.fromJson(json)).toList();
      } else {
        throw Exception('Failed to load cadres: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching cadres: $e');
    }
  }

  // Assign cadre to health worker
  static Future<HealthWorker> assignCadre(
    int healthWorkerId,
    int cadreId,
  ) async {
    try {
      final response = await http.patch(
        Uri.parse('$baseUrl/healthworkers/$healthWorkerId/assign-cadre'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'cadID': cadreId}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = json.decode(response.body);
        return HealthWorker.fromJson(data['data']);
      } else {
        throw Exception('Failed to assign cadre: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error assigning cadre: $e');
    }
  }

  // Create new cadre
  static Future<Cadre> createCadre(Cadre cadre) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/cadres'),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(cadre.toJson()),
      );

      if (response.statusCode == 201) {
        final Map<String, dynamic> data = json.decode(response.body);
        return Cadre.fromJson(data['data']);
      } else {
        throw Exception('Failed to create cadre: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error creating cadre: $e');
    }
  }
}
