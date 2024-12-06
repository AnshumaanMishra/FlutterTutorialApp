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
    apiKey: 'AIzaSyB-Fezcyke2DnYbqK4232j5XvVRC9zzWKY',
    appId: '1:369972350639:web:d04137417364e4b6030e5a',
    messagingSenderId: '369972350639',
    projectId: 'futtertutorialnotesapp-41cd7',
    authDomain: 'futtertutorialnotesapp-41cd7.firebaseapp.com',
    storageBucket: 'futtertutorialnotesapp-41cd7.firebasestorage.app',
    measurementId: 'G-HVCYGHQ8SH',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAj_MwgHXFO3H4NPssVNyLNCNDESgqLT0c',
    appId: '1:369972350639:android:83bb52cced2a810e030e5a',
    messagingSenderId: '369972350639',
    projectId: 'futtertutorialnotesapp-41cd7',
    storageBucket: 'futtertutorialnotesapp-41cd7.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAK4R7fsKln45egkfxfP8s5pp8aZuaXsHU',
    appId: '1:369972350639:ios:bb0f80f4b368a834030e5a',
    messagingSenderId: '369972350639',
    projectId: 'futtertutorialnotesapp-41cd7',
    storageBucket: 'futtertutorialnotesapp-41cd7.firebasestorage.app',
    iosBundleId: 'com.psm-tip.futtertutorialnotesapp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAK4R7fsKln45egkfxfP8s5pp8aZuaXsHU',
    appId: '1:369972350639:ios:bb0f80f4b368a834030e5a',
    messagingSenderId: '369972350639',
    projectId: 'futtertutorialnotesapp-41cd7',
    storageBucket: 'futtertutorialnotesapp-41cd7.firebasestorage.app',
    iosBundleId: 'com.psm-tip.futtertutorialnotesapp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB-Fezcyke2DnYbqK4232j5XvVRC9zzWKY',
    appId: '1:369972350639:web:441a41c6bac44a64030e5a',
    messagingSenderId: '369972350639',
    projectId: 'futtertutorialnotesapp-41cd7',
    authDomain: 'futtertutorialnotesapp-41cd7.firebaseapp.com',
    storageBucket: 'futtertutorialnotesapp-41cd7.firebasestorage.app',
    measurementId: 'G-QL7VDFN3QQ',
  );
}
