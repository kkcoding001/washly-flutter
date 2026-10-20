import 'dart:convert';
import 'package:http/http.dart' as http;

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



}
