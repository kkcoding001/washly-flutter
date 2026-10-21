import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  // Development URL for your phone connected by USB.
  static const String baseUrl = 'http://localhost:8080';

  static Future<Map<String, dynamic>> register({
    required String name,
    required String email,
    required String phone,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/api/auth/register');

    try {
      final response = await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name.trim(),
          'email': email.trim(),
          'phone': phone.trim(),
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 15));

      final dynamic decoded = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : <String, dynamic>{};

      if (decoded is Map<String, dynamic>) {
        if (response.statusCode == 201 ||
            response.statusCode == 200) {
          return {
            'success': true,
            'data': decoded,
          };
        }

        return {
          'success': false,
          'message': decoded['message'] ??
              decoded['error'] ??
              'Registration failed (${response.statusCode}).',
        };
      }

      return {
        'success': false,
        'message': 'Unexpected response from the server.',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'The server returned an invalid response.',
      };
    } catch (e) {
      return {
        'success': false,
        'message': e is http.ClientException
            ? 'Cannot connect to the server. Check that the backend is running.'
            : 'Request failed. Check your connection and try again.',
      };
    }
  }


  static Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final uri = Uri.parse('$baseUrl/api/auth/login');

    try {
      final response = await http
          .post(
        uri,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      )
          .timeout(const Duration(seconds: 15));

      final dynamic decoded = response.body.isNotEmpty
          ? jsonDecode(response.body)
          : <String, dynamic>{};

      if (decoded is Map<String, dynamic>) {
        if (response.statusCode == 200) {
          return {'success': true, 'data': decoded};
        }

        return {
          'success': false,
          'message': decoded['message'] ??
              decoded['error'] ??
              'Login failed (${response.statusCode}).',
        };
      }

      return {
        'success': false,
        'message': 'Unexpected response from the server.',
      };
    } on FormatException {
      return {
        'success': false,
        'message': 'The server returned an invalid response.',
      };
    } catch (_) {
      return {
        'success': false,
        'message': 'Cannot connect to the server. Check your connection.',
      };
    }
  }



  // This uses the same secure-storage key used during login: jwt_token
  static const FlutterSecureStorage _storage =
  FlutterSecureStorage();

  static Future<Map<String, dynamic>> getProfile() async {
    final token = await _storage.read(key: 'jwt_token');

    if (token == null || token.isEmpty) {
      return {
        'success': false,
        'message': 'Please sign in again.',
        'unauthorized': true,
      };
    }

    try {
      final response = await http
          .get(
        Uri.parse('$baseUrl/api/customer/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Accept': 'application/json',
        },
      )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        if (decoded is Map<String, dynamic>) {
          return {'success': true, 'data': decoded};
        }

        return {
          'success': false,
          'message': 'Unexpected profile response.',
        };
      }

      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Your session has expired. Please sign in again.',
          'unauthorized': true,
        };
      }

      return {
        'success': false,
        'message': 'Unable to load profile (${response.statusCode}).',
      };
    } catch (_) {
      return {
        'success': false,
        'message': 'Cannot connect to the server. Check your connection.',
      };
    }
  }



  static Future<Map<String, dynamic>> updateProfile({
    required String name,
    String? phone,
  }) async {
    final token = await _storage.read(key: 'jwt_token');

    if (token == null || token.isEmpty) {
      return {
        'success': false,
        'message': 'Please sign in again.',
      };
    }

    try {
      final response = await http
          .put(
        Uri.parse('$baseUrl/api/customer/profile'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: jsonEncode({
          'name': name.trim(),
          'phone': phone?.trim(),
        }),
      )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode == 200) {
        final decoded = jsonDecode(response.body);

        return {
          'success': true,
          'data': decoded,
          'message': 'Profile updated successfully.',
        };
      }

      if (response.statusCode == 401) {
        return {
          'success': false,
          'message': 'Your session has expired. Please sign in again.',
        };
      }

      if (response.statusCode == 400) {
        return {
          'success': false,
          'message': 'Please check the information you entered.',
        };
      }

      return {
        'success': false,
        'message':
        'Unable to update profile (${response.statusCode}).',
      };
    } catch (e) {

      return {
        'success': false,
        'message': 'Cannot connect to the server. Check your connection.',
      };
    }
  }



  // Load all vehicles belonging to the logged-in customer.
  static Future<Map<String, dynamic>> getVehicles() async {
    return _vehicleRequest(
      method: 'GET',
      path: '/api/customer/vehicles',
    );
  }

  // Add a new vehicle.
  static Future<Map<String, dynamic>> addVehicle({
    required String brand,
    required String model,
    required String registrationNumber,
  }) async {
    return _vehicleRequest(
      method: 'POST',
      path: '/api/customer/vehicles',
      body: {
        'brand': brand.trim(),
        'model': model.trim(),
        'registrationNumber': registrationNumber.trim(),
      },
    );
  }

  // Update an existing vehicle using its database ID.
  static Future<Map<String, dynamic>> updateVehicle({
    required String id,
    required String brand,
    required String model,
    required String registrationNumber,
  }) async {
    return _vehicleRequest(
      method: 'PUT',
      path: '/api/customer/vehicles/$id',
      body: {
        'brand': brand.trim(),
        'model': model.trim(),
        'registrationNumber': registrationNumber.trim(),
      },
    );
  }

  // Delete a vehicle using its database ID.
  static Future<Map<String, dynamic>> deleteVehicle({
    required String id,
  }) async {
    return _vehicleRequest(
      method: 'DELETE',
      path: '/api/customer/vehicles/$id',
    );
  }

  // Shared authenticated request handler for vehicle APIs.
  static Future<Map<String, dynamic>> _vehicleRequest({
    required String method,
    required String path,
    Map<String, dynamic>? body,
  }) async {
    final token = await _storage.read(key: 'jwt_token');

    if (token == null || token.isEmpty) {
      return {
        'success': false,
        'message': 'Please sign in again.',
        'unauthorized': true,
      };
    }

    try {
      final uri = Uri.parse('$baseUrl$path');
      final headers = {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
        if (body != null) 'Content-Type': 'application/json',
      };

      late http.Response response;

      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response = await http.post(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'PUT':
          response = await http.put(
            uri,
            headers: headers,
            body: jsonEncode(body),
          );
          break;
        case 'DELETE':
          response = await http.delete(uri, headers: headers);
          break;
        default:
          return {
            'success': false,
            'message': 'Unsupported request method.',
          };
      }

      // DELETE returns 204 with no response body.
      if (response.statusCode == 204) {
        return {'success': true};
      }

      dynamic decoded;
      if (response.body.isNotEmpty) {
        try {
          decoded = jsonDecode(response.body);
        } on FormatException {
          decoded = null;
        }
      }

      if (response.statusCode >= 200 &&
          response.statusCode < 300) {
        return {
          'success': true,
          'data': decoded,
        };
      }

      if (response.statusCode == 401 ||
          response.statusCode == 403) {
        return {
          'success': false,
          'message': response.statusCode == 401
              ? 'Your session has expired. Please sign in again.'
              : 'You are not authorized to perform this action.',
          'unauthorized': response.statusCode == 401,
        };
      }

      String message = 'Request failed (${response.statusCode}).';

      if (decoded is Map<String, dynamic>) {
        message = decoded['message']?.toString() ??
            decoded['error']?.toString() ??
            message;
      }

      return {
        'success': false,
        'message': message,
      };
    } catch (e) {
      return {
        'success': false,
        'message':
        'Cannot connect to the server. Check that the backend is running.',
      };
    }
  }

  // Convert a backend vehicle response to the keys used by the UI.
  static Map<String, String> vehicleToUiMap(
      Map<String, dynamic> vehicle,
      ) {
    return {
      'id': vehicle['id']?.toString() ?? '',
      'type': vehicle['vehicleType']?.toString() ?? 'Car',
      'brand': vehicle['brand']?.toString() ?? '',
      'model': vehicle['model']?.toString() ?? '',
      'registration':
      vehicle['registrationNumber']?.toString() ?? '',
    };
  }


}
