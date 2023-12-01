import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';

import '../../DL/dl.dart';
import '../bl.dart';

part 'authorscrud.g.dart'; //dart run build_runner build

@collection
class Author {
  @Id()
  String auhor = '';
  String authorsAliases = '';
}

class AuthorCRUD {
  Future clear() async {
    isar.write((isar) async {
      isar.authors.clear();
    });
  }

  Future<List<String>> readAllAuthors() async {
    try {
      return isar.authors.where().auhorProperty().findAll();
    } catch (e) {
      debugPrint('AuthorCRUD().readAll()\n$e');
      return [];
    }
  }

  //-----------------------------------------------------------------update
  Future updateAuthors() async {
    await clear();

    List authorsDyn = await dl.httpService.getAuthors();
    for (var i = 1; i < authorsDyn.length; i++) {
      update(authorsDyn[i][0], authorsDyn[i][1]);
    }
    debugPrint('AuthorCRUD.updateAuthors() ${authorsDyn.length}');
  }

  Future update(String author, String aliases) async {
    if (author.isEmpty) return;
    final newAuthor = Author()
      ..auhor = author
      ..authorsAliases = aliases;

    isar.write((isar) async {
      isar.authors.put(newAuthor);
    });
  }
}
