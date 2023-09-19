import 'package:flutter/foundation.dart';
import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/bluti.dart';
import 'package:quotebrowser/BL/params/params.dart';

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
  Future<List<String>> readAllAuthors() async {
    try {
      return isar.authors.where().auhorProperty().findAll();
    } catch (e) {
      debugPrint('CatsCRUD().readAll()\n$e');
      return [];
    }
  }

  //-----------------------------------------------------------------update
  Future updateAuthors() async {
    List authorsDyn =
        await dl.httpService.getAllrows('__Authors__', dataSheetId);
    List<String> auth = blUti.toListString(authorsDyn);

    List<String> authors = [];
    for (var i = 0; i < auth.length; i++) {
      authors.add(auth[i].substring(1, auth[i].length - 1));
    }
    await update(authors);
  }

  Future update(List<String> authorsRows) async {
    await isar.write((isar) async {
      isar.authors.clear();
    });

    for (String catPath in authorsRows) {
      if (catPath.isEmpty) continue;
      final newCatpath = Author()..auhor = catPath;

      isar.write((isar) async {
        isar.authors.put(newCatpath);
      });
    }
  }
}
