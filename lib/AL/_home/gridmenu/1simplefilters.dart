// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';

import '../../../BL/orm.dart';
import '../../alib/alib.dart';
import '../../filterspages/_selectview.dart';
import 'common.dart';

class SimpleFiltersAL {
  Function setstateHome;
  SimpleFiltersAL(this.setstateHome);

  Future doItem(MenuTile item, BuildContext context) async {
    switch (item.tileName) {
      case 'Today':
        currentSS.filterIcon = const Icon(Icons.date_range);
        await searchText('${blUti.todayStr()}.', context, setstateHome);
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
}

//----------------------------------------------------------popups
PopupMenuButton toReadPopupMenu(MenuTile item, BuildContext context) {
  return PopupMenuButton(
    itemBuilder: (_) {
      return [
        PopupMenuItem(
          child: const Text("Delete old To read list"),
          onTap: () async {
            await bl.filtersCRUD.deleteFilter('__toRead__');
            // ignore: use_build_context_synchronously
            al.messageBottom(context, 'Click on To read for refresh..');
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
