import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:goreader/helpers/authentication_helper.dart';
import 'tag.dart';

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
