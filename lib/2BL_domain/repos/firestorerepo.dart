// main.dart
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

import 'supgitignore.dart';

class FirestoreRepo {
  late final FirebaseFirestore firestoreDb;

  Future init() async {
    final FirebaseApp fireApp =
        await Firebase.initializeApp(options: firebaseOptions);

    firestoreDb = FirebaseFirestore.instanceFor(app: fireApp);
  }

  //------------------------------------------------------------------create
  void rowmapDailySave(Map rowMap) async {
    await firestoreDb
        .collection("todayRows")
        .add(rowMap as Map<String, dynamic>);
  }

  //-------------------------------------------------------------------update

  void tagsUpdateAdd(String tags, rownoKey) async {
    late DocumentReference rowRef;

    try {
      firestoreDb.collection("todayRows").get().then(
        (querySnapshot) {
          for (var docSnapshot in querySnapshot.docs) {
            if (docSnapshot.data()['rownokey'] != rownoKey) continue;
            rowRef = docSnapshot.reference;

            rowRef.update({"tags": tags}).then((value) => () {},
                onError: (e) => debugPrint(
                    "FirestoreRepo.tagsUpdateAdd $rownoKey Error updating document $e"));

            break;
          }
        },
        onError: (e) => debugPrint(
            "FirestoreRepo.tagsUpdateAdd $rownoKey Error completing: $e"),
      );
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
