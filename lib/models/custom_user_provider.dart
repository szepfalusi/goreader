// ignore_for_file: invalid_return_type_for_catch_error

import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../helpers/authentication_helper.dart';
import 'custom_user.dart';
import 'tag.dart';

class CustomUserProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('users');
  CustomUser _customUser = CustomUser(id: '');

  get user => _customUser;

  Future<void> addUser(CustomUser user, List<Tag> tags) async {
    final userId = AuthenticationHelper().userId;
    var userDoc = userRef.doc(user.id);
    userDoc.set({
      'id': userId,
      'name': user.name,
      'address': user.address,
      'phoneNumber': user.phoneNumber != '' ? '+' + user.phoneNumber : '',
      'note': user.note,
    }).then((value) {
      _customUser = CustomUser(
        id: userId,
        name: user.name,
        address: user.address,
        phoneNumber: user.phoneNumber,
        note: user.note,
      );
      log("User created/modified successfully");
      notifyListeners();
    }).catchError((error) => log("Failed to add user: $error"));
  }

  Future<CustomUser> getUserFromAPI() async {
    final userId = AuthenticationHelper().userId;

    var userDoc = await userRef.doc(userId).get();
    if (!userDoc.exists) {
      return CustomUser(id: userId);
    }
    _customUser = CustomUser(
        id: userId,
        name: userDoc['name'],
        phoneNumber: userDoc['phoneNumber'],
        address: userDoc['address'],
        note: userDoc['note']);
    notifyListeners();

    return _customUser;
  }

  CustomUser getUser() {
    return _customUser;
  }

  Future<CustomUser> getUserData(String userId) async {
    var userDoc = await userRef.doc(userId).get();
    if (!userDoc.exists) {
      return CustomUser(id: userId);
    }
    return CustomUser(
        id: userId,
        name: userDoc['name'],
        phoneNumber: userDoc['phoneNumber'],
        address: userDoc['address'],
        note: userDoc['note']);
  }
}
