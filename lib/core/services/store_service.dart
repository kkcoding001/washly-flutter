// import 'dart:convert';
//
// import 'package:http/http.dart' as http;
//
// import '../../models/store.dart';
//
//
// class StoreService {
//   // Android emulator:
//   static const String baseUrl = 'http://10.0.2.2:8080';
//
//   Future<List<Store>> getStores() async {
//     final uri = Uri.parse('$baseUrl/api/stores');
//
//     final response = await http.get(
//       uri,
//       headers: {
//         'Accept': 'application/json',
//       },
//     );
//
//     if (response.statusCode == 200) {
//       final dynamic decoded = jsonDecode(response.body);
//
//       // Supports either a JSON array or an object containing "data".
//       final dynamic records =
//       decoded is List ? decoded : decoded['data'];
//
//       if (records is! List) {
//         throw Exception('Unexpected store API response format.');
//       }
//
//       return records
//           .map((item) => Store.fromJson(
//         item as Map<String, dynamic>,
//       ))
//           .toList();
//     }
//
//     throw Exception(
//       'Failed to load stores. HTTP ${response.statusCode}',
//     );
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../models/store.dart';


class StoreService {
  // Android emulator
  static const String baseUrl = 'http://localhost:8080';

  Future<List<Store>> getStores() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/stores'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to load stores (${response.statusCode})',
      );
    }

    final decoded = jsonDecode(response.body);

    final List<dynamic> data = decoded is List
        ? decoded
        : decoded is Map<String, dynamic> &&
        decoded['data'] is List
        ? decoded['data'] as List<dynamic>
        : throw Exception('Unexpected store API response.');

    return data
        .map((item) => Store.fromJson(
      item as Map<String, dynamic>,
    ))
        .where((store) => store.active)
        .toList();
  }
}