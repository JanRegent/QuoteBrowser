// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../BL/filters/searchss.dart';
import '../../../BL/orm.dart';
import '../../filterspages/_selectview.dart';
import '../../zview/_cardsswiper.dart';
import 'common.dart';
import 'menudata.dart';

class ColumnTextFiltersAL {
  Function setstateHome;
  ColumnTextFiltersAL(this.setstateHome);

  Future doItem(MenuTile item, BuildContext context) async {
    switch (item.tileName) {
      case 'New Author&text':
        currentSS.filterIcon = const Icon(Icons.person);
        String author = '';
        try {
          author = await authorSelect(context);
        } catch (_) {
          return;
        }
        if (author.isEmpty) {
          loadingTitle.value = '';
          setstateHome();
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
          loadingTitle.value = '';
          setstateHome();
          return;
        }
        loadingTitle.value = '$author & $searchWord';
        // ignore: use_build_context_synchronously
        await searchColumnQuote('author', author, searchWord, context);
        loadingTitle.value = '';
        setstateHome();
        break;

      case 'Last days':
        currentSS.filterIcon = const Icon(Icons.date_range);
        String searchDate = '';
        currentSS.filterIcon = const Icon(Icons.date_range);
        try {
          // ignore: use_build_context_synchronously
          searchDate = await dateSelect(context);
        } catch (_) {
          return;
        }

        if (searchDate.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchText(searchDate, context, setstateHome);
        break;

      case 'To read':
        currentSS.filterIcon = const Icon(Icons.date_range);
        // ignore: use_build_context_synchronously
        await searchText('__toRead__', context, setstateHome);
        break;
      case 'New word search':
        currentSS.filterIcon = const Icon(Icons.wordpress);
        // ignore: use_build_context_synchronously
        String word = await inputWord(context);
        try {
          if (word.isEmpty) return;
        } catch (_) {
          return;
        }
        // ignore: use_build_context_synchronously
        await searchText(word, context, setstateHome);
        break;

      case 'Stored words searches':
        String searchWord = '';
        currentSS.filterIcon = const Icon(Icons.wordpress);
        try {
          // ignore: use_build_context_synchronously
          searchWord = await wordSelect(context);
        } catch (_) {
          return;
        }

        if (searchWord.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchText(searchWord, context, setstateHome);
        break;

      default:
    }
  }

//Future
  Future searchColumnQuote(String columnName, String columnValue,
      String searchText, BuildContext context) async {
    loadingTitle.value = '$columnValue & $searchText';
    print(loadingTitle.value);
    setstateHome();

    searchColumnAndQuote(columnName, columnValue, searchText, context).then(
        (value) async {
      loadingTitle.value = '';
      setstateHome();

      if (value == 0) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) =>
                CardSwiper('$columnValue & $searchText', const {})),
      );
    }, onError: (e) {
      debugPrint(e);
    });
  }
}
