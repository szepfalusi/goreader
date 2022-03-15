import 'package:flutter/foundation.dart';

class CustomUser with ChangeNotifier {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String note;
  final bool admin;

  CustomUser({
    required this.id,
    this.name = '',
    this.address = '',
    this.phoneNumber = '',
    this.note = '',
    this.admin = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phoneNumber': phoneNumber,
        'note': note,
      };
}
