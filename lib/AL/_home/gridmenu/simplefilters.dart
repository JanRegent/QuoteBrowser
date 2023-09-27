import 'package:flutter/material.dart';
import 'package:quotebrowser/BL/filters/simplefilter.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';
import '../../../BL/filters/searchss.dart';
import '../../../BL/orm.dart';
import '../../alib/alib.dart';
import '../../filterspages/_selectview.dart';
import '../../zview/_cardsswiper.dart';
import 'common.dart';
import 'menudata.dart';

class SimpleFiltersAL {
  Function setstateHome;
  SimpleFiltersAL(this.setstateHome);

  Future doItem(MenuTile item, BuildContext context) async {
    switch (item.tileName) {
      case 'Today':
        currentSS.filterIcon = const Icon(Icons.date_range);
        await searchText('${blUti.todayStr()}.', context);
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
        await searchText(searchDate, context);
        break;

      case 'To read':
        currentSS.filterIcon = const Icon(Icons.date_range);
        // ignore: use_build_context_synchronously
        await searchText('__toRead__', context);
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
        await searchText(word, context);
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
        await searchText(searchWord, context);
        break;

      default:
    }
  }

  //----------------------------------------------------------search/view

  Future searchText(String searchText, BuildContext context) async {
    loadingTitle.value = searchText;
    setstateHome();

    filterSearchText(searchText, context).then((value) async {
      loadingTitle.value = '';
      setstateHome();

      if (value == 0) return;

      await Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => CardSwiper(searchText, const {})),
      );
    }, onError: (e) {
      debugPrint(e);
    });
  }
}

//----------------------------------------------------------drawer
PopupMenuButton toReadPopupMenu(MenuTile item, BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (_) {
      return [
        PopupMenuItem(
          child: const Text("Delete old To read list"),
          onTap: () async {
            await bl.filtersCRUD.deleteFilter('__toRead__');
            // ignore: use_build_context_synchronously
            al.message(context, 'Click on To read for refresh..');
          },
        ),
        PopupMenuItem(
          child: PopupMenuButton(
            child: const Text("Nested Items"),
            itemBuilder: (_) {
              return [
                const PopupMenuItem(
                  child: Text("Delete old To read list"),
                ),
                const PopupMenuItem(child: Text("Item3"))
              ];
            },
          ),
        ),
      ];
    },
  );
}
