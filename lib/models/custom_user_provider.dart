import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:goreader/helpers/authentication_helper.dart';
import 'package:goreader/models/tag.dart';
import 'package:goreader/models/tags.dart';
import 'package:provider/provider.dart';

import 'custom_user.dart';

class CustomUserProvider extends ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference userRef = FirebaseFirestore.instance.collection('user');
  CustomUser _customUser = CustomUser(id: '');

  get user => _customUser;

  Future<void> addUser(CustomUser user, List<Tag> tags) async {
    final userId = AuthenticationHelper().userId;
    var userModify = await userRef.doc(user.id).get();
    var userDoc = await userRef.doc(user.id);
    // if (userModify.exists && userModify['id'] == userId) {
    //   userRef
    //       .doc(user.id)
    //       .update(user.toJson())
    //       .then((value) => getUsersFromAPI())
    //       .catchError((error) => print(error));
    // }
    userDoc.set({
      'id': userId,
      'name': user.name,
      'address': user.address,
      'phoneNumber': user.phoneNumber,
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
}
