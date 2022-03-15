import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'view_tag.dart';
import 'package:provider/provider.dart';
import '../helpers/authentication_helper.dart';
import 'custom_user_provider.dart';
import 'tag.dart';
import 'custom_user.dart';

class Tags with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference tagsRef = FirebaseFirestore.instance.collection('tags');
  CollectionReference usersRef = FirebaseFirestore.instance.collection('users');

  List<Tag> _tags = [
    // Tag(
    //   id: '123',
    //   name: 'Bloki',
    //   note: '3-as csengo',
    //   imageUrl: 'nincs',
    //   visibleName: true,
    //   visibleAddress: true,
    //   visiblePhone: false,
    //   visibleNote: true,
    //   userId: 'teszt123',
    // ),
    // Tag(
    //   id: '2345',
    //   name: 'Papers',
    //   note: '5-os csengo',
    //   imageUrl: 'nincs',
    //   visibleName: true,
    //   visibleAddress: true,
    //   visiblePhone: true,
    //   visibleNote: true,
    //   userId: 'teszt1234',
    // ),
  ];

  List<Tag> get tags {
    return [..._tags];
  }

  Tag? findTag(String id) {
    return _tags.firstWhereOrNull((element) => element.id == id);
  }

  Future<ViewTag> findTagFromFirebase(String id) async {
    final firebaseJson = await tagsRef.doc(id).get();
    print(firebaseJson);
    if (firebaseJson.exists) {
      final tagData = firebaseJson.data() as Map<String, dynamic>;
      final userRef = await usersRef.doc(tagData['userId']).get();
      final userData = userRef.data() as Map<String, dynamic>?;
      return ViewTag(
        tagName: tagData['name'],
        imageUrl: tagData['imageUrl'],
        note: tagData['note'],
        userName:
            tagData['visibleName'] == true ? (userData?['name'] ?? '') : '',
        userAddress: tagData['visibleAddress'] == true
            ? (userData?['address'] ?? '')
            : '',
        userNote:
            tagData['visibleNote'] == true ? (userData?['note'] ?? '') : '',
        userPhone: tagData['visiblePhone'] == true
            ? (userData?['phoneNumber'] ?? '')
            : '',
        email: tagData['email'],
      );
    }
    return ViewTag();
  }

  Future<void> getTagsFromAPI() async {
    final userId = AuthenticationHelper().userId;
    var snapshot = await tagsRef.get();
    _tags = snapshot.docs
        .map((e) => Tag(
              id: e.reference.id,
              name: e['name'],
              note: e['note'],
              imageUrl: e['imageUrl'],
              visibleName: e['visibleName'],
              visibleAddress: e['visibleAddress'],
              visiblePhone: e['visiblePhone'],
              visibleNote: e['visibleNote'],
              userId: e['userId'],
            ))
        .where((element) => element.userId == userId)
        .toList();
    notifyListeners();
  }

  Future<void> addTag(Tag tag) async {
    final userId = AuthenticationHelper().userId;
    final email = AuthenticationHelper().email;

    var tagModify = await tagsRef.doc(tag.id).get();
    if (tagModify.exists && tagModify['userId'] == userId) {
      tagsRef
          .doc(tag.id)
          .update(tag.toJson())
          .then((value) => getTagsFromAPI())
          .catchError((error) => print(error));
    } else {
      tagsRef.add({
        'name': tag.name,
        'note': tag.note,
        'imageUrl': tag.imageUrl,
        'visibleName': tag.visibleName,
        'visibleAddress': tag.visibleAddress,
        'visiblePhone': tag.visiblePhone,
        'visibleNote': tag.visibleNote,
        'userId': userId,
        'email': email
      }).then((value) {
        _tags.add(tag.setIdFromFirebase(value.id, tag));
        print("Tag Added");
        notifyListeners();
      }).catchError((error) => print("Failed to add tag: $error"));
    }
  }

  Future<void> removeTag(String id) async {
    return tagsRef.doc(id).delete().then(
      (value) {
        _tags.removeWhere((element) => element.id == id);
        notifyListeners();
      },
    ).catchError(
        (error) => print('Something went wrong at removing this tag.'));
  }

  Future<String> saveImageURL(File imgFile) async {
    var url = '';
    Reference storageRef = FirebaseStorage.instance
        .ref()
        .child('image' + DateTime.now().toIso8601String());
    await storageRef.putFile(imgFile).whenComplete(() async {
      url = await storageRef.getDownloadURL();
    });
    return url;
  }
}
