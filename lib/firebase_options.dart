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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyCX1jmRxahDC1AnucDMfKeaJHbStiER11w',
    appId: '1:546473234311:web:7e770f68f65d24ffcb4d22',
    messagingSenderId: '546473234311',
    projectId: 'spreadit-5a997',
    authDomain: 'spreadit-5a997.firebaseapp.com',
    storageBucket: 'spreadit-5a997.appspot.com',
    measurementId: 'G-3K9JM9TT9L',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCFSCkNMchvrdapkxEjBYzR036laFNW-cI',
    appId: '1:546473234311:android:1a6d76a6227de7cfcb4d22',
    messagingSenderId: '546473234311',
    projectId: 'spreadit-5a997',
    storageBucket: 'spreadit-5a997.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyANA8YGUMNICV9A89cxXs8R1M-H4_hj8A0',
    appId: '1:546473234311:ios:ff8ce01e89aebed4cb4d22',
    messagingSenderId: '546473234311',
    projectId: 'spreadit-5a997',
    storageBucket: 'spreadit-5a997.appspot.com',
    iosClientId: '546473234311-511m13erocmi67d2qvmrf29hk924qkpg.apps.googleusercontent.com',
    iosBundleId: 'com.example.spreaditCrossplatform',
  );
}
