// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../2BL_domain/orm.dart';

import '../zview/_swiper.dart';
import '../zview/edit/battr/addquote/addquoterow.dart';
import 'searchshow.dart';

class LastRowsAddQuote {
  Future doItem(
      MenuTile item, BuildContext context, Function setstateHome) async {
    switch (item.tileName) {
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
