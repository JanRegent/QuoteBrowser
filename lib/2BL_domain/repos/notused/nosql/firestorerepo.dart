//----flutter web loading problem

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/foundation.dart';

// import '../supgitignore.dart';

// class FirestoreRepo {
//   late final FirebaseFirestore firestoreDb;

//   Future init() async {
//     final FirebaseApp fireApp =
//         await Firebase.initializeApp(options: firebaseOptions);

//     firestoreDb = FirebaseFirestore.instanceFor(app: fireApp);
//   }

//   //------------------------------------------------------------------create
//   void rowmapDailySave(Map rowMap) async {
//     await firestoreDb
//         .collection("todayRows")
//         .add(rowMap as Map<String, dynamic>);
//   }

//   //-------------------------------------------------------------------read
//   Future<String> docIdByRowKey(String collection, String rowkey) async {
//     String docId = '';
//     try {
//       await firestoreDb
//           .collection(collection)
//           .where("rowkey", isEqualTo: rowkey)
//           .limit(1)
//           .get()
//           .then((querySnapshot) {
//         docId = querySnapshot.docs[0].reference.id;
//       });
//     } catch (e) {
//       debugPrint("FirestoreRepo.docByRowkey $rowkey Error: $e");
//     }
//     return docId;
//   }

//   //-------------------------------------------------------------------update

//   void valueUpdate(
//       String collection, String docId, String keyName, String value) async {
//     final songsCollection = firestoreDb.collection(collection);
//     try {
//       await songsCollection.doc(docId).update({keyName: value});
//     } catch (e) {
//       debugPrint(
//           "FirestoreRepo.valueUpdate: docId: $docId \n $keyName \n $value \n\n $e");
//     }
//   }

//   void tagsUpdateSet(String tags, rowkey) async {
//     String docId = await docIdByRowkey('todayRows', rowkey);
//     if (docId.isEmpty) return; //todo
//     valueUpdate('todayRows', docId, 'tags', tags);
//   }
// }
