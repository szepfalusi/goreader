import 'package:flutter/foundation.dart';

class UserSettings extends ChangeNotifier {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String note;
  final bool admin;
  final List<String> tagIds;

  UserSettings({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.note,
    required this.tagIds,
    this.admin = false,
  });
}
