// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../2BL_domain/usecases/keys4swiper/searchcolumn.dart';
import '../../2BL_domain/usecases/keys4swiper/searchword.dart';
import '../zswipbrowser/_swiper.dart';
import '../widgets/alib/alib.dart';

import '../controllers/selectvalue.dart';

class ColumnTextFiltersAL {
  Future doItem(MenuTile item) async {
    al.messageLoading('Searching in cloud', item.tileName, 25);
    switch (item.tileName) {
      case 'New Author&text':
        //currentSS.filterIcon = const Icon(Icons.person);
        String author = '';
        try {
          author = await authorSelect();
        } catch (_) {
          return;
        }
        if (author.isEmpty) {
          return;
        }
        String searchWord = '';
        try {
          // ignore: use_build_context_synchronously
          searchWord = await inputWord();
        } catch (_) {
          return;
        }
        if (searchWord.isEmpty) {
          return;
        }
        // ignore: use_build_context_synchronously
        await searchColumnQuote('author', author, searchWord);
        // ignore: use_build_context_synchronously
        await Navigator.push(
          al.homeContext,
          MaterialPageRoute(
              builder: (context) =>
                  CardSwiper('$author & $searchWord', const {})),
        );
        break;

      case 'Stored Author&text':
        String columnTextKey = '';
        //currentSS.filterIcon = const Icon(Icons.person);
        try {
          // ignore: use_build_context_synchronously
          columnTextKey = await authorTextSelect();
        } catch (_) {
          return;
        }

        if (columnTextKey.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchColumnText(columnTextKey);
        // ignore: use_build_context_synchronously
        await Navigator.push(
          al.homeContext,
          MaterialPageRoute(
              builder: (context) => CardSwiper(columnTextKey, const {})),
        );
        break;

      default:
    }
  }
}
