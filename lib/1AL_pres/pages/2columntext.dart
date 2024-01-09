// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../controllers/alib/alib.dart';
import 'filterspages/_selectview.dart';

import 'searchshow.dart';

class ColumnTextFiltersAL {
  Future doItem(MenuTile item, BuildContext context) async {
    al.messageLoading(context, 'Searching in cloud', item.tileName, 25);
    switch (item.tileName) {
      case 'New Author&text':
        //currentSS.filterIcon = const Icon(Icons.person);
        String author = '';
        try {
          author = await authorSelect(context);
        } catch (_) {
          return;
        }
        if (author.isEmpty) {
          return;
        }
        String searchWord = '';
        try {
          // ignore: use_build_context_synchronously
          searchWord = await inputWord(context);
        } catch (_) {
          return;
        }
        if (searchWord.isEmpty) {
          return;
        }
        // ignore: use_build_context_synchronously
        await searchColumnQuote('author', author, searchWord, context);
        break;

      case 'Stored Author&text':
        String columnTextKey = '';
        //currentSS.filterIcon = const Icon(Icons.person);
        try {
          // ignore: use_build_context_synchronously
          columnTextKey = await authorTextSelect(context);
        } catch (_) {
          return;
        }

        if (columnTextKey.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchColumnText(columnTextKey, context);
        break;

      default:
    }
  }
}
