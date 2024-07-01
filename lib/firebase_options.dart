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
    apiKey: 'AIzaSyBljggeDsnGi4dfTcCP5dlfS7cDDH-FfSQ',
    appId: '1:25393004909:web:4ee272a3e91758b1591a64',
    messagingSenderId: '25393004909',
    projectId: 'maya-calendar-1313',
    authDomain: 'maya-calendar-1313.firebaseapp.com',
    storageBucket: 'maya-calendar-1313.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB_RQFQldIR3wMfb8__1kfspGXDHNpMZLg',
    appId: '1:25393004909:android:c26103223e68aa68591a64',
    messagingSenderId: '25393004909',
    projectId: 'maya-calendar-1313',
    storageBucket: 'maya-calendar-1313.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBDQMtDSycuzGqcCIIx2507kkFwTxKLkR8',
    appId: '1:25393004909:ios:43159afcbe5369e4591a64',
    messagingSenderId: '25393004909',
    projectId: 'maya-calendar-1313',
    storageBucket: 'maya-calendar-1313.appspot.com',
    iosBundleId: 'com.software.maya',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBDQMtDSycuzGqcCIIx2507kkFwTxKLkR8',
    appId: '1:25393004909:ios:43159afcbe5369e4591a64',
    messagingSenderId: '25393004909',
    projectId: 'maya-calendar-1313',
    storageBucket: 'maya-calendar-1313.appspot.com',
    iosBundleId: 'com.software.maya',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBljggeDsnGi4dfTcCP5dlfS7cDDH-FfSQ',
    appId: '1:25393004909:web:4571666114ecaa04591a64',
    messagingSenderId: '25393004909',
    projectId: 'maya-calendar-1313',
    authDomain: 'maya-calendar-1313.firebaseapp.com',
    storageBucket: 'maya-calendar-1313.appspot.com',
  );
}
