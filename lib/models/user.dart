import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'tag.dart';

class CustomUser with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('user');

  final String id;
  final String name;
  final String address;
  final String phoneNumber;
  final String note;
  final bool admin;
  final List<String> tags;

  CustomUser({
    required this.id,
    this.name = '',
    this.address = '',
    this.phoneNumber = '',
    this.note = '',
    this.tags = const [],
    this.admin = false,
  });

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'address': address,
        'phoneNumber': phoneNumber,
        'note': note,
        'tags': tags,
      };

  Future<void> addUser(CustomUser user) async {
    userRef.add({
      'id': user.id,
      'name': user.name,
      'address': user.address,
      'phoneNumber': user.phoneNumber,
      'note': user.note,
      'tags': user.tags,
    }).then((value) {
      print("User created successfully");
      notifyListeners();
    }).catchError((error) => log("Failed to add user: $error"));
  }
}
