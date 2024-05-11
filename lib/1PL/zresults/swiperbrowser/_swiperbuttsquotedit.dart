import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import 'previewpage.dart';
import 'quotedit/_quoteedit.dart';
import 'swipermenu.dart';

// ignore: must_be_immutable
class SwiperButtsQuotedit extends StatefulWidget {
  VoidCallback setStateSwiper;
  String title1;
  String title2;
  VoidCallback swiperSetstateIndexChanged;

  SwiperButtsQuotedit(this.setStateSwiper, this.title1, this.title2,
      this.swiperSetstateIndexChanged,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwiperButtsQuoteditState createState() => _SwiperButtsQuoteditState();
}

class _SwiperButtsQuoteditState extends State<SwiperButtsQuotedit> {
  void swiperIndexIncrementInCloud() async {
    if (currentSS.swiperIndexIncrement == false) return;

    // if (currentSS.currentHomeTabIndex == 1) {
    //   bl.booksCount[bl.orm.currentRow.sheetName] = currentSS.swiperIndex;
    //   dl.gservice23.setCellDL('booksList', 'swiperIndex',
    //       currentSS.swiperIndex.toString(), currentSS.bookListRow.rowkey);
    // }
    if (currentSS.currentHomeTabIndex == 0) {
      dl.gservice23.setCellDL('dailyList', 'swiperIndex',
          currentSS.swiperIndex.toString(), currentSS.dailyListRow.rowkey);
    }
  }

  Row titleArrowsRowOff() {
    return Row(children: [
      al.infoButton(context, widget.title1, '\n${widget.title2}'),

      ElevatedButton(
          onPressed: () {
            if (bl.orm.currentRow.setCellColor == Colors.red) return;
            currentSS.swiperIndex -= 1;
            indexChanged(currentSS.swiperIndex.value);
            widget.setStateSwiper();
          },
          child: const Icon(Icons.arrow_back, color: Colors.red)),
      //
      TextButton(
          onLongPress: () {
            previewPageOn = !previewPageOn;
            widget.setStateSwiper();
          },
          onPressed: () {
            if (bl.orm.currentRow.setCellColor == Colors.red) return;
            showGotoPopupMenu(context, widget.setStateSwiper);
          },
          child: Obx(() => Text(
              ' ${(currentSS.swiperIndex.value + 1)}/${currentSS.keys.length}',
              style: const TextStyle(color: Colors.black, fontSize: 20)))),
      ElevatedButton(
          //----------------------------------------forward --next
          onPressed: () {
            if (bl.orm.currentRow.setCellColor == Colors.red) return;
            currentSS.swiperIndex.value += 1;
            indexChanged(currentSS.swiperIndex.value);
            widget.setStateSwiper();
            swiperIndexIncrementInCloud();
          },
          child: const Icon(Icons.arrow_forward_rounded, color: Colors.red)),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: titleArrowsRowOff(),
          actions: [rowViewMenu({}, widget.setStateSwiper)],
        ),
        body: SafeArea(
            child: previewPageOn
                ? const PreviewPage()
                : QuoteEdit(widget.setStateSwiper, context)));
  }
}
