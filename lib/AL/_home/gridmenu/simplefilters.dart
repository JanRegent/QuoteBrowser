import 'package:flutter/material.dart';

import '../../../BL/bluti.dart';
import '../../../BL/filters/searchss.dart';
import '../../../BL/orm.dart';
import '../../zview/_cardsswiper.dart';
import 'menudata.dart';

class SimpleFiltersAL {
  Future doItem(MenuTile item, BuildContext context) async {
    switch (item.tileName) {
      case 'Today':
        currentSS.filterIcon = const Icon(Icons.date_range);
        await searchText('${blUti.todayStr()}.', context);
        break;
      default:
    }
  }

  //----------------------------------------------------------search/view

  Future searchText(String searchText, BuildContext context) async {
    loadingTitle.value = searchText;
    //widget.setstateHome();

    filterSearchText(searchText, context).then((value) async {
      loadingTitle.value = '';
      //widget.setstateHome();

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
