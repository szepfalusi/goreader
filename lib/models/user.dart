import 'package:flutter/foundation.dart';
import 'tag.dart';

class User extends ChangeNotifier {
  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String note;
  final bool admin;
  final List<String> tags;

  User({
    required this.id,
    required this.name,
    required this.address,
    required this.phoneNumber,
    required this.note,
    required this.tags,
    this.admin = false,
  });
}
