import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../zgitignore.dart';

class FirestoreRepo {
  late CollectionReference sheetrowsRef;

  Future init() async {
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: DefaultFirebaseOptions.web);

    sheetrowsRef = FirebaseFirestore.instance.collection('sheetrows');

    // createRow();
    // readData();
    // updateData();
  }

  //-------------------------------------------------------------------create
  void createRow() async {
    await sheetrowsRef.add({
      'name': 'John Doe ${DateTime.now()}',
      'email': 'john@example.com',
      'age': 25,
    });
  }

  void upsertAll(List maprows) async {
    WriteBatch writeBatch = sheetrowsRef.firestore.batch();

    for (var i = 0; i < maprows.length; i++) {
      DocumentReference rowDocRef = sheetrowsRef.doc(maprows[i]['rowkey']);
      writeBatch.set(rowDocRef, maprows[i]);
    }
    writeBatch.commit();
  }

  //-------------------------------------------------------------------read
  void readData() async {
    // Retrieve all documents in the 'users' collection
    QuerySnapshot querySnapshot = await sheetrowsRef.get();
    for (var doc in querySnapshot.docs) {
      debugPrint(
          'Name: ${doc['name']}, Email: ${doc['email']}, Age: ${doc['age']}');
    }

    // Retrieve a specific document
    DocumentSnapshot documentSnapshot =
        await sheetrowsRef.doc('tYNoHydPk34DZZNsAWl0').get();
    debugPrint(
        'Name: ${documentSnapshot['name']}, Email: ${documentSnapshot['email']}, Age: ${documentSnapshot['age']}');
  }

  //-------------------------------------------------------------------update
  void updateData() async {
    // Update data in a specific document
    await sheetrowsRef.doc('tYNoHydPk34DZZNsAWl0').update({
      'age': 26,
    });
  }

  //-------------------------------------------------------------------delete

  void deleteData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Delete a specific document
    await users.doc('documentId').delete();
  }
}
