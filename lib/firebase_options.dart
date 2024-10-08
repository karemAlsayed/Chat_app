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
    apiKey: 'AIzaSyD7Aks4Igbzkbk2XE_Bno9nKQT8BNFf0D8',
    appId: '1:220318267442:web:8ac659f89fef1204cd242b',
    messagingSenderId: '220318267442',
    projectId: 'chat-app-86207',
    authDomain: 'chat-app-86207.firebaseapp.com',
    storageBucket: 'chat-app-86207.appspot.com',
    measurementId: 'G-S66H729HK2',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCRpnKy3Au0eqa_g7UhD9kXC0SINuHes8A',
    appId: '1:220318267442:android:b306135230782cb0cd242b',
    messagingSenderId: '220318267442',
    projectId: 'chat-app-86207',
    storageBucket: 'chat-app-86207.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCO-WoTjp1M00h35tv8Ol1nFB10Umy_PXU',
    appId: '1:220318267442:ios:c70f340800652a6dcd242b',
    messagingSenderId: '220318267442',
    projectId: 'chat-app-86207',
    storageBucket: 'chat-app-86207.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCO-WoTjp1M00h35tv8Ol1nFB10Umy_PXU',
    appId: '1:220318267442:ios:c70f340800652a6dcd242b',
    messagingSenderId: '220318267442',
    projectId: 'chat-app-86207',
    storageBucket: 'chat-app-86207.appspot.com',
    iosBundleId: 'com.example.chatApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD7Aks4Igbzkbk2XE_Bno9nKQT8BNFf0D8',
    appId: '1:220318267442:web:ea1e9bd05a16076dcd242b',
    messagingSenderId: '220318267442',
    projectId: 'chat-app-86207',
    authDomain: 'chat-app-86207.firebaseapp.com',
    storageBucket: 'chat-app-86207.appspot.com',
    measurementId: 'G-7KB45C3CN1',
  );
}
