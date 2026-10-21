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



}
