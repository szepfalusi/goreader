// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    // ignore: missing_enum_constant_in_switch
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
    }

    throw UnsupportedError(
      'DefaultFirebaseOptions are not supported for this platform.',
    );
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyDDRSZgpYV6htiuZ_8HF7_2dg648B_o8C4',
    appId: '1:962049032982:web:d74ae5f76b698c3fc2c637',
    messagingSenderId: '962049032982',
    projectId: 'goreader-29cda',
    authDomain: 'goreader-29cda.firebaseapp.com',
    databaseURL: 'https://goreader-29cda-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'goreader-29cda.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBC51WkKb7J-l_1b3rrzFznP3xVylfmqto',
    appId: '1:962049032982:android:25520653287b2783c2c637',
    messagingSenderId: '962049032982',
    projectId: 'goreader-29cda',
    databaseURL: 'https://goreader-29cda-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'goreader-29cda.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA2u5Qvrm8JmeYZ49dVrYdxAsmR5TOxlJg',
    appId: '1:962049032982:ios:0d83ef1c83642accc2c637',
    messagingSenderId: '962049032982',
    projectId: 'goreader-29cda',
    databaseURL: 'https://goreader-29cda-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'goreader-29cda.appspot.com',
    iosClientId: '962049032982-i1tg9i4nhggfri31kic9regh5sdcnpc2.apps.googleusercontent.com',
    iosBundleId: 'goreader',
  );
}