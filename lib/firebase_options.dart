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
    apiKey: 'AIzaSyDQeSGjUROk1V6aXZTUiBYVJQwcFOhV89w',
    appId: '1:1033015307529:web:d2680f109c1d76440877d8',
    messagingSenderId: '1033015307529',
    projectId: 'spit-ps9',
    authDomain: 'spit-ps9.firebaseapp.com',
    storageBucket: 'spit-ps9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDYpak9D6UThyIGR5y6VTkLZibX96MgpA0',
    appId: '1:1033015307529:android:12e11dff4cd350370877d8',
    messagingSenderId: '1033015307529',
    projectId: 'spit-ps9',
    storageBucket: 'spit-ps9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAgK1MEQi-jhoW3Fc5HkEiRtlAhtkQTIrU',
    appId: '1:1033015307529:ios:e548eeb4cedab7f50877d8',
    messagingSenderId: '1033015307529',
    projectId: 'spit-ps9',
    storageBucket: 'spit-ps9.appspot.com',
    iosClientId: '1033015307529-6k0j1kc0mq1d85s8vtoc09c27chcjk1m.apps.googleusercontent.com',
    iosBundleId: 'in.adityabodhankar.securingDocuments',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAgK1MEQi-jhoW3Fc5HkEiRtlAhtkQTIrU',
    appId: '1:1033015307529:ios:e548eeb4cedab7f50877d8',
    messagingSenderId: '1033015307529',
    projectId: 'spit-ps9',
    storageBucket: 'spit-ps9.appspot.com',
    iosClientId: '1033015307529-6k0j1kc0mq1d85s8vtoc09c27chcjk1m.apps.googleusercontent.com',
    iosBundleId: 'in.adityabodhankar.securingDocuments',
  );
}