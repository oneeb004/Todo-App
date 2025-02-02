// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDmnaRtg8sKdTFBB6xedNxqd0dvBkqrvMw',
    appId: '1:1056355282277:web:5e49e27e22b5822131c58c',
    messagingSenderId: '1056355282277',
    projectId: 'todo-app-1632b',
    authDomain: 'todo-app-1632b.firebaseapp.com',
    storageBucket: 'todo-app-1632b.appspot.com',
    measurementId: 'G-MT66KNGLD4',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDIkT4D4wJPHla4rMZAtczsMVrlEXNZTtw',
    appId: '1:1056355282277:android:ad6e53c8e3cf986631c58c',
    messagingSenderId: '1056355282277',
    projectId: 'todo-app-1632b',
    storageBucket: 'todo-app-1632b.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDWss_lwgwOOpm2MSlb1uBa3IGTG7d85jo',
    appId: '1:1056355282277:ios:76b35db5ce6b6d2a31c58c',
    messagingSenderId: '1056355282277',
    projectId: 'todo-app-1632b',
    storageBucket: 'todo-app-1632b.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDWss_lwgwOOpm2MSlb1uBa3IGTG7d85jo',
    appId: '1:1056355282277:ios:76b35db5ce6b6d2a31c58c',
    messagingSenderId: '1056355282277',
    projectId: 'todo-app-1632b',
    storageBucket: 'todo-app-1632b.appspot.com',
    iosBundleId: 'com.example.toDoApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDmnaRtg8sKdTFBB6xedNxqd0dvBkqrvMw',
    appId: '1:1056355282277:web:866a376102abf20431c58c',
    messagingSenderId: '1056355282277',
    projectId: 'todo-app-1632b',
    authDomain: 'todo-app-1632b.firebaseapp.com',
    storageBucket: 'todo-app-1632b.appspot.com',
    measurementId: 'G-R40BJLSZ6P',
  );
}
