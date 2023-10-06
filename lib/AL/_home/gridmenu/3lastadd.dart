// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../BL/filters/searchss.dart';
import '../../../BL/orm.dart';

import '../../alib/selectiondialogs/selectone.dart';

import '../../zview/_swiper.dart';
import '../../zview/aedit/addquote/addquoterow.dart';
import 'common.dart';

class LastRowsAddQuote {
  Future doItem(
      MenuTile item, BuildContext context, Function setstateHome) async {
    switch (item.tileName) {
      case 'Last 10 rows':
        currentSS.filterIcon = const Icon(Icons.last_page);

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
        currentSS.filterIcon = const Icon(Icons.add);
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
