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

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
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


  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA7A2GAi31vgbziazx4MVx2CsrG--UrH78',
    appId: '1:996430779074:android:172835ec9122867476e15b',
    messagingSenderId: '996430779074',
    projectId: 'antpay',
    storageBucket: 'antpay.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyApya4kJd755uld--gMYvpy_6MRjkhO-NQ',
    appId: '1:489034711974:ios:bbad56f09f9d61bfa98567',
    messagingSenderId: '996430779074',
    projectId: 'antpay',
    storageBucket: 'antpay.appspot.com',
    androidClientId: '489034711974-43f5eckd4ivdf9albr210bug9r56887k.apps.googleusercontent.com',
    iosClientId: '489034711974-hjr90p995rtjar4g85dqpd2ilfn6un9c.apps.googleusercontent.com',
    iosBundleId: 'com.optshine.optFlutter',
  );


}
