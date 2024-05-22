import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/currow.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import 'prewiew/previewpage.dart';
import 'quotedit/_quoteedit.dart';
import 'swipermenu.dart';

// ignore: must_be_immutable
class SwiperNavigButtsQuotedit extends StatefulWidget {
  VoidCallback setStateSwiper;
  String title1;
  String title2;
  VoidCallback swiperSetstateIndexChanged;

  SwiperNavigButtsQuotedit(this.setStateSwiper, this.title1, this.title2,
      this.swiperSetstateIndexChanged,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwiperNavigButtsQuoteditState createState() =>
      _SwiperNavigButtsQuoteditState();
}

class _SwiperNavigButtsQuoteditState extends State<SwiperNavigButtsQuotedit> {
  void swiperIndexIncrementInCloud() async {
    if (bl.currentSS.swiperIndexIncrement == false) return;

    // if (bl.currentSS.currentHomeTabIndex == 1) {
    //   bl.booksCount[bl.curRow.sheetName] = bl.currentSS.swiperIndex;
    //   dl.gservice23.setCellDL('booksList', 'swiperIndex',
    //       bl.currentSS.swiperIndex.toString(), bl.currentSS.bookListRow.rowkey);
    // }
    if (bl.currentSS.currentHomeTabIndex == 0) {
      dl.gservice23.setCellDL(
          'dailyList',
          'swiperIndex',
          bl.currentSS.swiperIndex.toString(),
          bl.currentSS.dailyListRow.rowkey);
    }
  }

  Row titleArrowsRowOff() {
    return Row(children: [
      al.infoButton(context, widget.title1, '\n${widget.title2}'),
      const Spacer(),
      rowViewMenu({}, widget.setStateSwiper),
      ElevatedButton(
          onPressed: () {
            if (bl.curRow.setCellColor == Colors.red) return;
            bl.currentSS.swiperIndex -= 1;
            indexChanged(bl.currentSS.swiperIndex.value);
            previewPageOn = false;
            widget.setStateSwiper();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: Colors.blue),
          ),
          child: const Icon(Icons.arrow_back, color: Colors.blue)),
      //
      TextButton(
          onPressed: () {
            if (bl.curRow.setCellColor == Colors.red) return;
            showGotoPopupMenu(context, widget.setStateSwiper);
          },
          child: Obx(() => Text(
              ' ${(bl.currentSS.swiperIndex.value + 1)}/${bl.currentSS.keys.length}',
              style: const TextStyle(color: Colors.black, fontSize: 20)))),
      ElevatedButton(
          //----------------------------------------forward --next
          onPressed: () {
            if (bl.curRow.setCellColor == Colors.red) return;
            bl.currentSS.swiperIndex.value += 1;
            indexChanged(bl.currentSS.swiperIndex.value);
            swiperIndexIncrementInCloud();
            previewPageOn = false;
            widget.setStateSwiper();
          },
          style: OutlinedButton.styleFrom(
            side: const BorderSide(width: 2.0, color: Colors.blue),
          ),
          child: const Icon(Icons.arrow_forward_rounded, color: Colors.blue)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleArrowsRowOff(),
        ),
        body: SafeArea(
            child: previewPageOn
                ? PreviewPage(widget.setStateSwiper)
                : QuoteEdit(widget.setStateSwiper, context)));
  }
}
