import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationHelper {
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  get userId => _auth.currentUser?.uid;
  get email => _auth.currentUser?.email;
  get emailVerified => _auth.currentUser?.emailVerified;

  Future signUp({required String email, required String password}) async {
    try {
      await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      _auth.currentUser?.sendEmailVerification();
      return null;
    } on FirebaseAuthException catch (e) {
      return e.code;
    }
  }

  Future resetPassword() async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
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
