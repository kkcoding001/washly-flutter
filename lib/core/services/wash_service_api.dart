//
// import 'dart:convert';
// import 'package:http/http.dart' as http;
//
// import '../../models/wash_service.dart';
//
// class WashServiceApi {
//   static const String baseUrl = 'http://10.0.2.2:8080';
//
//   Future<List<WashService>> getServices() async {
//     final response = await http.get(
//       Uri.parse('$baseUrl/api/services'),
//       headers: {'Accept': 'application/json'},
//     );
//
//     if (response.statusCode != 200) {
//       throw Exception(
//         'Unable to load services (${response.statusCode})',
//       );
//     }
//
//     final decoded = jsonDecode(response.body);
//
//     final List<dynamic> data = decoded is List
//         ? decoded
//         : decoded is Map<String, dynamic> &&
//         decoded['data'] is List
//         ? decoded['data'] as List<dynamic>
//         : throw Exception('Unexpected services API response.');
//
//     return data
//         .map(
//           (item) => WashService.fromJson(
//         item as Map<String, dynamic>,
//       ),
//     )
//         .where((service) => service.active)
//         .toList();
//   }
// }


import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../models/wash_service.dart';

class WashServiceApi {
  static const String baseUrl = 'http://localhost:8080';

  Future<List<WashService>> getServices() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/services'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception(
        'Unable to load services (${response.statusCode})',
      );
    }

    final decoded = jsonDecode(response.body);

    final List<dynamic> data;
    if (decoded is List) {
      data = decoded;
    } else if (decoded is Map<String, dynamic> &&
        decoded['data'] is List) {
      data = decoded['data'] as List<dynamic>;
    } else {
      throw Exception('Unexpected services API response.');
    }

    return data
        .map((item) => WashService.fromJson(
      item as Map<String, dynamic>,
    ))
        .where((service) => service.active)
        .toList();
  }
}
