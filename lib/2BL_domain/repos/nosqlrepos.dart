import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class NoSqlRepos {
  // ignore: prefer_typing_uninitialized_variables
  late var firebase;
  // ignore: prefer_typing_uninitialized_variables
  late var db;

  static const String name = 'SheetViewer';

  late final FirebaseApp app;
  late final FirebaseAuth auth;
  late final FirebaseFirestore store;
}
