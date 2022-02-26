import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class AuthenticationHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  get userId => _auth.currentUser?.uid;
  static var isAuthenticated = false;
  final authenticateCheck =
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
    if (user == null) {
      log('user signed out');
      isAuthenticated = false;
    } else {
      log('user signed in');
      isAuthenticated = true;
    }
  });
  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future signIn({required String email, required String password}) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future signOut() async {
    await _auth.signOut();
  }
}
