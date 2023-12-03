// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../BL/filtersbl/searchss.dart';
import '../../../BL/orm.dart';

import '../../alib/selectiondialogs/selectone.dart';

import '../../zview/_swiper.dart';
import '../../zview/beditattr/addquote/addquoterow.dart';
import 'searchshow.dart';

class LastRowsAddQuote {
  Future doItem(
      MenuTile item, BuildContext context, Function setstateHome) async {
    switch (item.tileName) {
      case 'Last 10 rows':

        // ignore: use_build_context_synchronously
        String sheetName = await selectOne(currentSS.sheetNames, context);
        if (sheetName.isEmpty) return;

        // ignore: use_build_context_synchronously
        await getLastRows(sheetName, context);

        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  CardSwiper('Lat 10 of $sheetName', const {})),
        );
        break;

      case 'Add quote':
        // ignore: use_build_context_synchronously

        // ignore: use_build_context_synchronously
        await appendrowCurrentRowSet(context);
        currentSS.addQuoteMode = true;
        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => const CardSwiper('Add quotes', {})),
        );
        currentSS.addQuoteMode = false;

        break;

      default:
    }
  }
}
