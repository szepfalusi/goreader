import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../helpers/authentication_helper.dart';
import 'tag.dart';
import 'user.dart';

class Tags with ChangeNotifier {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference tagsRef = FirebaseFirestore.instance.collection('tags');

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

  Tag findTag(String id) {
    return _tags.firstWhere((element) => element.id == id);
  }

  Future<void> getTagsFromAPI() async {
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
            ))
        .toList();
    notifyListeners();
  }

  Future<void> addTag(Tag tag) async {
    var tagModify = await tagsRef.doc(tag.id).get();
    if (tagModify.exists) {
      tagsRef
          .doc(tag.id)
          .update(tag.toJson())
          .then((value) => getTagsFromAPI())
          .catchError((error) => print(error));
    } else {
      tagsRef.add({
        'id': tag.id,
        'name': tag.name,
        'note': tag.note,
        'imageUrl': tag.imageUrl,
        'visibleName': tag.visibleName,
        'visibleAddress': tag.visibleAddress,
        'visiblePhone': tag.visiblePhone,
        'visibleNote': tag.visibleNote,
        'userId': 'TODO'
      }).then((value) {
        _tags.add(tag);
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
}
