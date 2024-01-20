// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../2BL_domain/usecases/filters4swiper/searchcolumn.dart';
import '../../2BL_domain/usecases/filters4swiper/searchword.dart';
import '../zswipbrowser/_swiper.dart';
import '../widgets/alib/alib.dart';

import '../controllers/selectvalue.dart';

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
        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
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
          columnTextKey = await authorTextSelect(context);
        } catch (_) {
          return;
        }

        if (columnTextKey.isEmpty) return;
        // ignore: use_build_context_synchronously
        await searchColumnText(columnTextKey, context);
        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CardSwiper(columnTextKey, const {})),
        );
        break;

      default:
    }
  }
}
