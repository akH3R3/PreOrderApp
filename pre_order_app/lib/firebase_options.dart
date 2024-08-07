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
    apiKey: 'AIzaSyCGI9XDSu8YV11_NvkY0crQZjG-AVmBhtQ',
    appId: '1:664737093200:web:b4cf1daad03a4b133ce355',
    messagingSenderId: '664737093200',
    projectId: 'preorderapp-e0805',
    authDomain: 'preorderapp-e0805.firebaseapp.com',
    storageBucket: 'preorderapp-e0805.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAEUk8wKO1Z4X4i9RIqi5qUfeXm6PuDFD4',
    appId: '1:664737093200:android:cd5596ea3d4ff90d3ce355',
    messagingSenderId: '664737093200',
    projectId: 'preorderapp-e0805',
    storageBucket: 'preorderapp-e0805.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDBN4tomI8xWlk67rp_elxlPFd0BkStlOA',
    appId: '1:664737093200:ios:a4ac9099ca9b76203ce355',
    messagingSenderId: '664737093200',
    projectId: 'preorderapp-e0805',
    storageBucket: 'preorderapp-e0805.appspot.com',
    iosBundleId: 'com.example.preOrderApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDBN4tomI8xWlk67rp_elxlPFd0BkStlOA',
    appId: '1:664737093200:ios:a4ac9099ca9b76203ce355',
    messagingSenderId: '664737093200',
    projectId: 'preorderapp-e0805',
    storageBucket: 'preorderapp-e0805.appspot.com',
    iosBundleId: 'com.example.preOrderApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCGI9XDSu8YV11_NvkY0crQZjG-AVmBhtQ',
    appId: '1:664737093200:web:dfaddeb48675cb093ce355',
    messagingSenderId: '664737093200',
    projectId: 'preorderapp-e0805',
    authDomain: 'preorderapp-e0805.firebaseapp.com',
    storageBucket: 'preorderapp-e0805.appspot.com',
  );
}
