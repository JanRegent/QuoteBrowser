//import 'package:firebase_core/firebase_core.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:postgres/postgres.dart';

const supUrl = "https://gbwcwebsyirnjdmmipup.supabase.co";

const anonKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdid2N3ZWJzeWlybmpkbW1pcHVwIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDkyODU0ODAsImV4cCI6MjAyNDg2MTQ4MH0.7SGQQZKGHnIScFhYkvxfZaWfGsUtfl8uqTal0vcl2ko";

const serviceRoleKey =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imdid2N3ZWJzeWlybmpkbW1pcHVwIiwicm9sZSI6InNlcnZpY2Vfcm9sZSIsImlhdCI6MTcwOTI4NTQ4MCwiZXhwIjoyMDI0ODYxNDgwfQ.i4xVw4RNDfqa8gOYuKdZ662Ph4CzaUsI9-LR1lE5t-E";

Future<Connection> initNeon() async {
  //Neon postgresql://jan.regent:TUSOC4bsFYP6@ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech/neondb?sslmode=require
  return await Connection.open(Endpoint(
    host: 'ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech',
    database: 'neondb',
    username: 'jan.regent',
    password: 'TUSOC4bsFYP6',
  ));
}

Future initXata() async {
  //Neon postgresql://jan.regent:TUSOC4bsFYP6@ep-fragrant-sea-a2zurdgp.eu-central-1.aws.neon.tech/neondb?sslmode=require
  //HTTP endpoint
// https://Jan-Regent-s-workspace-qeon5d.eu-central-1.xata.sh/db/qb24db:main

// API key
// xau_I5hDiQvvIxwMPvbVkIYWm9uptkP2WRHUf
}

Future<Connection> initKoyeb() async {
  //postgres://koyeb-adm:oFVTxN5mjp1d@ep-calm-sunset-a2dcp39d.eu-central-1.pg.koyeb.app/qb24db
  return await Connection.open(Endpoint(
    host: 'ep-calm-sunset-a2dcp39d.eu-central-1.pg.koyeb.app',
    database: 'qb24db',
    username: 'koyeb-adm',
    password: 'oFVTxN5mjp1d',
  ));
}

Future<Connection> initPgedge() async {
  return await Connection.open(Endpoint(
    host: 'socially-proven-firefly-iad.a1.pgedge.io',
    database: 'defaultdb',
    username: 'admin',
    password: '2G9982dhe7PoT376kJry4PTc',
  ));
}

Future<Connection> initElephant() async {
  //postgres://koyeb-adm:oFVTxN5mjp1d@ep-calm-sunset-a2dcp39d.eu-central-1.pg.koyeb.app/qb24db
  return await Connection.open(Endpoint(
    host: 'trumpet.db.elephantsql.com',
    database: 'qizxnaga',
    username: 'qizxnaga',
    password: 'V3FVFh0dGEiwLMGSzIob4TsgLsDJ5tEH',
  ));
}

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
      apiKey: "AIzaSyAkYa8JWHVofu05cDDphpfo2ctk61p3UMU",
      authDomain: "sheetviewer-9eb27.firebaseapp.com",
      databaseURL:
          "https://sheetviewer-9eb27-default-rtdb.europe-west1.firebasedatabase.app",
      projectId: "sheetviewer-9eb27",
      storageBucket: "sheetviewer-9eb27.appspot.com",
      messagingSenderId: "163665467888",
      appId: "1:163665467888:web:55a510a9dc62c52a0de535",
      measurementId: "G-C49366WV09");

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCdRjCVZlhrq72RuEklEyyxYlBRCYhI2Sw',
    appId: '1:406099696497:android:899c6485cfce26c13574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:406099696497:ios:24bb8dcaefc434a73574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId:
        '406099696497-65v1b9ffv6sgfqngfjab5ol5qdikh2rm.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebaseUiExample',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDooSUGSf63Ghq02_iIhtnmwMDs4HlWS6c',
    appId: '1:406099696497:ios:24bb8dcaefc434a73574d0',
    messagingSenderId: '406099696497',
    projectId: 'flutterfire-e2e-tests',
    databaseURL:
        'https://flutterfire-e2e-tests-default-rtdb.europe-west1.firebasedatabase.app',
    storageBucket: 'flutterfire-e2e-tests.appspot.com',
    androidClientId:
        '406099696497-17qn06u8a0dc717u8ul7s49ampk13lul.apps.googleusercontent.com',
    iosClientId:
        '406099696497-65v1b9ffv6sgfqngfjab5ol5qdikh2rm.apps.googleusercontent.com',
    iosBundleId: 'io.flutter.plugins.firebaseUiExample',
  );
}
