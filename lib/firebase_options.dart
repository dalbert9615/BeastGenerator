// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:BeastGenerator/config.dart'
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
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: Config.firebase_apiKey,
    appId: '1:49012456078:web:ddb2650d43bfb2375ba7df',
    messagingSenderId: '49012456078',
    projectId: 'pdm2022-c0dcb',
    authDomain: 'pdm2022-c0dcb.firebaseapp.com',
    databaseURL:
        'https://pdm2022-c0dcb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'pdm2022-c0dcb.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: Config.firebase_apiKey,
    appId: '1:49012456078:android:1661f1643383305f5ba7df',
    messagingSenderId: '49012456078',
    projectId: 'pdm2022-c0dcb',
    databaseURL:
        'https://pdm2022-c0dcb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'pdm2022-c0dcb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: Config.firebase_apiKey,
    appId: '1:49012456078:ios:4fb372e2d0c7ac115ba7df',
    messagingSenderId: '49012456078',
    projectId: 'pdm2022-c0dcb',
    databaseURL:
        'https://pdm2022-c0dcb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'pdm2022-c0dcb.appspot.com',
    iosClientId:
        '49012456078-v4pqdupo9gmnbo9nhucislmhhqke8t4c.apps.googleusercontent.com',
    iosBundleId: 'com.example.projecteTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: Config.firebase_apiKey,
    appId: '1:49012456078:ios:4fb372e2d0c7ac115ba7df',
    messagingSenderId: '49012456078',
    projectId: 'pdm2022-c0dcb',
    databaseURL:
        'https://pdm2022-c0dcb-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'pdm2022-c0dcb.appspot.com',
    iosClientId:
        '49012456078-v4pqdupo9gmnbo9nhucislmhhqke8t4c.apps.googleusercontent.com',
    iosBundleId: 'com.example.projecteTest',
  );
}

// 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