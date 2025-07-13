import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
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

  // Firebase configuration for worklytics-c8099 project
  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCV6UIid_eyGIzgzrAABtR9IefWz1R6eLs',
    appId: '1:748084364532:android:a25605cb6bec8ce43b8aa1',
    messagingSenderId: '748084364532',
    projectId: 'worklytics-c8099',
    authDomain: 'worklytics-c8099.firebaseapp.com',
    storageBucket: 'worklytics-c8099.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCV6UIid_eyGIzgzrAABtR9IefWz1R6eLs',
    appId: '1:748084364532:android:a25605cb6bec8ce43b8aa1',
    messagingSenderId: '748084364532',
    projectId: 'worklytics-c8099',
    storageBucket: 'worklytics-c8099.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCV6UIid_eyGIzgzrAABtR9IefWz1R6eLs',
    appId: '1:748084364532:android:a25605cb6bec8ce43b8aa1',
    messagingSenderId: '748084364532',
    projectId: 'worklytics-c8099',
    storageBucket: 'worklytics-c8099.firebasestorage.app',
    iosClientId: '748084364532-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com',
    iosBundleId: 'com.example.worklytics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCV6UIid_eyGIzgzrAABtR9IefWz1R6eLs',
    appId: '1:748084364532:android:a25605cb6bec8ce43b8aa1',
    messagingSenderId: '748084364532',
    projectId: 'worklytics-c8099',
    storageBucket: 'worklytics-c8099.firebasestorage.app',
    iosClientId: '748084364532-xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx.apps.googleusercontent.com',
    iosBundleId: 'com.example.worklytics',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyCV6UIid_eyGIzgzrAABtR9IefWz1R6eLs',
    appId: '1:748084364532:android:a25605cb6bec8ce43b8aa1',
    messagingSenderId: '748084364532',
    projectId: 'worklytics-c8099',
    storageBucket: 'worklytics-c8099.firebasestorage.app',
  );
} 