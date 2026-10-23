//
// class WashService {
//   final int id;
//   final String name;
//   final String description;
//   final int durationMinutes;
//   final double price;
//   final bool active;
//
//   const WashService({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.durationMinutes,
//     required this.price,
//     required this.active,
//   });
//
//   factory WashService.fromJson(Map<String, dynamic> json) {
//     return WashService(
//       id: (json['id'] as num).toInt(),
//       name: json['name']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       durationMinutes:
//       ((json['durationMinutes'] ?? json['duration_minutes'] ?? 0) as num)
//           .toInt(),
//       price: (json['price'] as num).toDouble(),
//       active: json['active'] == true,
//     );
//   }
// }

//
// class WashService {
//   final int id;
//   final String name;
//   final String description;
//   final double price;
//   final int durationMinutes;
//   final bool active;
//
//   const WashService({
//     required this.id,
//     required this.name,
//     required this.description,
//     required this.price,
//     required this.durationMinutes,
//     required this.active,
//   });
//
//   factory WashService.fromJson(Map<String, dynamic> json) {
//     return WashService(
//       id: (json['id'] as num).toInt(),
//       name: json['name']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       price: (json['price'] as num).toDouble(),
//       durationMinutes: (json['durationMinutes'] as num).toInt(),
//       active: json['active'] == true,
//     );
//   }
//
//   Map<String, dynamic> toSelectionMap() => {
//     'id': id,
//     'name': name,
//     'description': description,
//     'duration': '$durationMinutes min',
//     'durationMinutes': durationMinutes,
//     'price': price,
//     'icon': _iconForName(name),
//     'popular': name.toLowerCase().contains('premium'),
//     'active': active,
//   };
//
//   static String _iconForName(String name) {
//     // The UI maps the service name to an icon.
//     return name;
//   }
// }



import 'package:flutter/material.dart';

class WashService {
  final int id;
  final String name;
  final String description;
  final double price;
  final int durationMinutes;
  final bool active;

  const WashService({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.durationMinutes,
    required this.active,
  });

  factory WashService.fromJson(Map<String, dynamic> json) {
    return WashService(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      price: (json['price'] as num).toDouble(),
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      active: json['active'] == true,
    );
  }

  Map<String, dynamic> toSelectionMap() => {
    'id': id,
    'name': name,
    'description': description,
    'duration': '$durationMinutes min',
    'durationMinutes': durationMinutes,
    'price': '₹${price.toStringAsFixed(0)}',
    'icon': iconForName(name),
    'popular': name.toLowerCase().contains('premium'),
    'active': active,
  };

  static IconData iconForName(String name) {
    final value = name.toLowerCase();

    if (value.contains('basic')) {
      return Icons.water_drop_outlined;
    }
    if (value.contains('premium')) {
      return Icons.auto_awesome_outlined;
    }
    if (value.contains('detail')) {
      return Icons.brush_outlined;
    }
    return Icons.local_car_wash_outlined;
  }
}
