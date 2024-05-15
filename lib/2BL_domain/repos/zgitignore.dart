//import 'package:firebase_core/firebase_core.dart';

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

// FirebaseOptions firebaseOptions = const FirebaseOptions(
//     apiKey: "AIzaSyAkYa8JWHVofu05cDDphpfo2ctk61p3UMU",
//     authDomain: "sheetviewer-9eb27.firebaseapp.com",
//     databaseURL:
//         "https://sheetviewer-9eb27-default-rtdb.europe-west1.firebasedatabase.app",
//     projectId: "sheetviewer-9eb27",
//     storageBucket: "sheetviewer-9eb27.appspot.com",
//     messagingSenderId: "163665467888",
//     appId: "1:163665467888:web:55a510a9dc62c52a0de535",
//     measurementId: "G-C49366WV09");
