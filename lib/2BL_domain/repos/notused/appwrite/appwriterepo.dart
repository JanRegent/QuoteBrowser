import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';

import '../../zgitignore.dart';

class AppwriteRepo extends ChangeNotifier {
  Client client = Client();
  late Account account;
  late Databases databases;
  late bool _isLoading;
  List<ListItem>? _listItem;

  bool get isLoading => _isLoading;
  List<ListItem>? get listItem => _listItem;

  AppwriteRepo() {
    _isLoading = true;
    initialize();
  }

  initialize() {
    client
      ..setEndpoint(AppwriteConstants.endpoint)
      ..setProject(AppwriteConstants.projectid);

    account = Account(client);
    databases = Databases(client);
    createAnon();
  }

  createAnon() async {
    try {
      await account.get();
    } catch (_) {
      await account.createAnonymousSession();
      _isLoading = false;
      notifyListeners();
    }
  }

  createDocument(String newTitle, String newSubtitle, context) async {
    try {
      final response = await databases.createDocument(
          databaseId: AppwriteConstants.dbID,
          collectionId: AppwriteConstants.collectionID,
          documentId: ID.unique(),
          data: {'title': newTitle, 'subtitle': newSubtitle});
      if (response.data.isNotEmpty) {
        await listDocument();
        Navigator.pop(context);
      }
    } catch (e) {
      rethrow;
    }
  }

  void readAll() async {
    try {
      final res = await account.createAnonymousSession();
      debugPrint(res.toString());
    } on AppwriteException catch (e) {
      debugPrint(e.message);
    }
    DocumentList result = await databases.listDocuments(
      databaseId: AppwriteConstants.dbID,
      collectionId: AppwriteConstants.collectionID,
      queries: [], // optional
    );
    for (var doc in result.documents) {
      debugPrint(doc.toString());
    }
  }

  listDocument() async {
    try {
      final response = await databases.listDocuments(
          databaseId: AppwriteConstants.dbID,
          collectionId: AppwriteConstants.collectionID);
      _listItem = response.documents
          .map((listitem) => ListItem.fromJson(listitem.data))
          .toList();
      _isLoading = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  updateDocument(
      String documentId, String updateTitle, String updateSubtitle) async {
    try {
      await databases.updateDocument(
          databaseId: AppwriteConstants.dbID,
          collectionId: AppwriteConstants.collectionID,
          documentId: documentId,
          data: {'title': updateTitle, 'subtitle': updateSubtitle});
    } catch (e) {
      rethrow;
    }
  }

  removeDocument(String documentID, int index) async {
    try {
      await databases.deleteDocument(
          databaseId: AppwriteConstants.dbID,
          collectionId: AppwriteConstants.collectionID,
          documentId: documentID);
      _listItem!.removeAt(index);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }
}

class UserFields {
  static const String id = "\$id";
  static const String title = "title";
  static const String subtitle = "subtitle";
}

class ListItem {
  String? id;
  String? title;
  String? subtitle;
  ListItem({
    required this.id,
    required this.title,
    required this.subtitle,
  });
  ListItem.fromJson(Map<String, dynamic> json) {
    id = json[UserFields.id];
    title = json[UserFields.title];
    subtitle = json[UserFields.subtitle];
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data[UserFields.id] = id;
    data[UserFields.title] = title;
    data[UserFields.subtitle] = subtitle;
    return data;
  }
}
