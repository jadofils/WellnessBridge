import 'dart:convert'; // For encoding and decoding JSON
import 'package:http/http.dart' as http; // For making HTTP requests
import 'dart:io'; // For SocketException

/// A class to handle API calls related to user signup.
class SignUpApi {
  // The base URL for your backend API.
  // Make sure this matches your actual backend server address.
  static const String _baseUrl = 'http://127.0.0.1:8000';
  static const String _healthworkersEndpoint = '/api/v1/healthworkers';
  static const String _cadresEndpoint = '/api/v1/cadres';

  /// Registers a new health worker user by sending their data to the backend.
  ///
  /// [userData] A map containing the user's registration details.
  /// Expected keys in userData:
  /// - 'name': String (required)
  /// - 'gender': String (required)
  /// - 'role': String (required)
  /// - 'email': String (required)
  /// - 'password': String (required)
  /// - 'cadID': String (required)
  ///
  /// Optional fields:
  /// - 'dob': String (date)
  /// - 'telephone': String
  /// - 'address': String
  /// - 'image': String
  ///
  /// Returns a [Map<String, dynamic>] on successful registration,
  /// containing the parsed JSON response from the server.
  ///
  /// Throws an [Exception] if the API call fails or returns an error.
  static Future<Map<String, dynamic>> signUpUser(
    Map<String, dynamic> userData,
  ) async {
    final uri = Uri.parse('$_baseUrl$_healthworkersEndpoint');
    print('Sending signup request to: $uri'); // Debugging: print the URI
    // print(
    //   'Request body: ${json.encode(userData)}',
    // ); // Debugging: print the request body

    try {
      final response = await http.post(
        uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(userData), // Encode the map to a JSON string
      );

      print(
        'Response status: ${response.statusCode}',
      ); // Debugging: print status code
      print(
        'Response body: ${response.body}',
      ); // Debugging: print response body

      if (response.statusCode == 201) {
        // Status 201 Created indicates successful resource creation
        return jsonDecode(response.body);
      } else if (response.statusCode == 400) {
        // Bad request, likely due to validation errors
        final errorData = jsonDecode(response.body);
        // Attempt to extract a more specific error message from the backend response
        throw Exception(
          'Validation Error: ${errorData['message'] ?? errorData['error'] ?? errorData['detail'] ?? 'Invalid data provided.'}',
        );
      } else if (response.statusCode == 409) {
        // Conflict, e.g., email already exists
        final errorData = jsonDecode(response.body);
        throw Exception(
          'Conflict: ${errorData['message'] ?? errorData['error'] ?? errorData['detail'] ?? 'Resource already exists.'}',
        );
      } else {
        // Handle other HTTP errors
        throw Exception(
          'Failed to sign up. Status code: ${response.statusCode}. Response: ${response.body}',
        );
      }
    } on SocketException {
      throw Exception(
        'Network error: Could not connect to the server. Please ensure the backend is running and accessible at $_baseUrl.',
      );
    } on FormatException catch (e) {
      throw Exception(
        'Data format error: Invalid JSON response from server during signup. Error: $e',
      );
    } catch (e) {
      // Catch any other unexpected errors
      throw Exception('An unexpected error occurred during signup: $e');
    }
  }

  /// Fetches a list of available CadIDs and their names from the backend.
  ///
  /// This method makes an HTTP GET request to the cadres endpoint
  /// and parses the response to return a list of maps, each containing
  /// 'cadID' and 'name'.
  ///
  /// Returns a [Future<List<Map<String, dynamic>>>] containing the list of cadres.
  /// Throws an [Exception] if the API call fails or if the JSON format is invalid.
  static Future<List<Map<String, dynamic>>> fetchCadres() async {
    final uri = Uri.parse('$_baseUrl$_cadresEndpoint');
    print('Fetching cadres from: $uri'); // Debugging: print the URI

    try {
      final response = await http.get(uri);
      print(
        'Cadres Response status: ${response.statusCode}',
      ); // Debugging: print status code
      // print(
      //   'Cadres Response body: ${response.body}',
      // ); // Debugging: print response body

      if (response.statusCode == 200) {
        final dynamic decodedBody = jsonDecode(response.body);

        // Check if the decoded body is a Map and contains a 'data' key
        if (decodedBody is Map<String, dynamic> &&
            decodedBody.containsKey('data')) {
          final List<dynamic> dataList = decodedBody['data'];
          return dataList
              .map((item) {
                // Ensure item is a Map and has 'cadID' and 'name'
                if (item is Map<String, dynamic> &&
                    item.containsKey('cadID') &&
                    item.containsKey('name')) {
                  return {
                    'cadID':
                        item['cadID']
                            .toString(), // Convert to string for consistency
                    'name': item['name'].toString(),
                  };
                } else {
                  // Handle malformed individual items in the list
                  print('Warning: Malformed cadre item received: $item');
                  return {
                    'cadID': '',
                    'name': '',
                  }; // Return empty or handle as error
                }
              })
              .where((item) => item['cadID']!.isNotEmpty)
              .toList(); // Filter out any items with empty cadIDs
        } else {
          // If the backend returns a single object or other type instead of a list under 'data'
          throw FormatException(
            'Expected a JSON object with a "data" key containing an array for cadres, but received a different structure.',
          );
        }
      } else {
        throw Exception(
          'Failed to load cadres. Status code: ${response.statusCode}. Response: ${response.body}',
        );
      }
    } on SocketException {
      throw Exception(
        'Network error: Could not connect to the server to fetch cadres. Please ensure the backend is running and accessible at $_baseUrl.',
      );
    } on FormatException catch (e) {
      // Catch specific JSON parsing errors
      throw Exception(
        'Data format error: Invalid JSON response from server when fetching cadres. Please ensure your backend returns valid JSON. Error: $e',
      );
    } catch (e) {
      throw Exception('An unexpected error occurred while fetching cadres: $e');
    }
  }
}
