// class Store {
//   final int id;
//   final String name;
//   final String address;
//   final String area;
//   final String city;
//   final String postalCode;
//   final String phone;
//   final String openingTime;
//   final String closingTime;
//   final double? latitude;
//   final double? longitude;
//   final bool active;
//
//   const Store({
//     required this.id,
//     required this.name,
//     required this.address,
//     required this.area,
//     required this.city,
//     required this.postalCode,
//     required this.phone,
//     required this.openingTime,
//     required this.closingTime,
//     this.latitude,
//     this.longitude,
//     required this.active,
//   });
//
//   factory Store.fromJson(Map<String, dynamic> json) {
//     return Store(
//       id: (json['id'] as num).toInt(),
//       name: json['name'] ?? '',
//       address: json['address'] ?? '',
//       area: json['area'] ?? '',
//       city: json['city'] ?? '',
//       postalCode: json['postalCode'] ?? '',
//       phone: json['phone'] ?? '',
//       openingTime: json['openingTime'] ?? '',
//       closingTime: json['closingTime'] ?? '',
//       latitude: (json['latitude'] as num?)?.toDouble(),
//       longitude: (json['longitude'] as num?)?.toDouble(),
//       active: json['active'] == true,
//     );
//   }
// }

class Store {
  final int id;
  final String name;
  final String address;
  final String area;
  final String city;
  final String postalCode;
  final String phone;
  final String openingTime;
  final String closingTime;
  final bool active;

  const Store({
    required this.id,
    required this.name,
    required this.address,
    required this.area,
    required this.city,
    required this.postalCode,
    required this.phone,
    required this.openingTime,
    required this.closingTime,
    required this.active,
  });

  factory Store.fromJson(Map<String, dynamic> json) {
    return Store(
      id: (json['id'] as num).toInt(),
      name: json['name']?.toString() ?? '',
      address: json['address']?.toString() ?? '',
      area: json['area']?.toString() ?? '',
      city: json['city']?.toString() ?? '',
      postalCode: json['postalCode']?.toString() ?? '',
      phone: json['phone']?.toString() ?? '',
      openingTime: json['openingTime']?.toString() ?? '',
      closingTime: json['closingTime']?.toString() ?? '',
      active: json['active'] == true,
    );
  }

  Map<String, dynamic> toSelectionMap() => {
    'id': id,
    'name': name,
    'location': '$area, $city',
    'address': address,
    'postalCode': postalCode,
    'phone': phone,
    'openingTime': openingTime,
    'closingTime': closingTime,
    'hours': 'Open · $openingTime – $closingTime',
    'active': active,
  };
}