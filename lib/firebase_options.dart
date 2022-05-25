// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
    }
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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDg1qKQfK3Q1UCOrL1p4qzq3Gu43zP-OEE',
    appId: '1:1013286674196:android:a06d71c788ab3e7d172c01',
    messagingSenderId: '1013286674196',
    projectId: 'myfin-99',
    storageBucket: 'myfin-99.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDHk8GsqQ1N5AmeVjWAQbfPr8Wtyhrg_r0',
    appId: '1:1013286674196:ios:f9408f4bd98b62d1172c01',
    messagingSenderId: '1013286674196',
    projectId: 'myfin-99',
    storageBucket: 'myfin-99.appspot.com',
    iosClientId: '1013286674196-4u2kb7icl4aoi5jj9j55u5stkb4cnj81.apps.googleusercontent.com',
    iosBundleId: 'com.patrykstraczek.myfin',
  );
}