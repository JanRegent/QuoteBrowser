import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '_sheetviewpage.dart';
import 'sheetviewmenu.dart';

// import '../../../2business_layer/appdata/approotdata.dart';

// import 'cardactions.dart';

// import 'd1quotedetailpage.dart';
// import 'd20menu.dart';

class CardSwiper extends StatefulWidget {
  final List<int> ids;
  final String title;
  final Map configRow;

  const CardSwiper(this.ids, this.title, this.configRow, {super.key});

  @override
  State<StatefulWidget> createState() {
    return _CardSwiperState();
  }
}

class _CardSwiperState extends State<CardSwiper> {
  SwiperController controller = SwiperController();

  @override
  void initState() {
    super.initState();
  }

  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {
    // try {
    //   if (widget.configRow['sheetName'] == null) {
    //     widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    //   }
    // } catch (_) {
    //   widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    //   return;
    // }
    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == null) {
    //   widget.configRow['__bookmarkLastRowVisitSave__'] = '';
    // }
    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
    //   return;
    // }
    // try {
    //   String? startRowStr = appData
    //       .getString('${widget.configRow['sheetName']}__bookmarkLastRowVisit');
    //   currentRowIndex = int.tryParse(startRowStr!)!;
    // } catch (_) {
    //   currentRowIndex = 0;
    // }
  }

  void onIndexChanged(int rowIndex) {
    currentRowIndex = rowIndex;
    // if (widget.configRow['__bookmarkLastRowVisitSave__'] == '') {
    //   return;
    // }
    // try {
    //   String sheetName = widget.configRow['sheetName'];
    //   appData.setString(
    //       '${sheetName}__bookmarkLastRowVisit', currentRowIndex.toString());
    // } catch (__) {}
  }

  void swiperSetstate() {
    setState(() {
      //startRow changed
    });
  }

  ConstrainedBox body() {
    //widget.configRow['localIds.length'] = widget.sheets.length;
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          //https://pub.dev/packages/card_swiper
          //https://github.com/TheAnkurPanchani/card_swiper/

          itemBuilder: (BuildContext context, int rowIndex) {
            return SheetViewPage(widget.ids[currentRowIndex], widget.title);
          },
          itemCount: widget.ids.length,
          onIndexChanged: (rowIndex) => onIndexChanged(rowIndex),
          pagination:
              const SwiperPagination(builder: SwiperPagination.fraction),
          control: const SwiperControl(),
          index: currentRowIndex,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: SheetviewMenu(const {}, const {}, swiperSetstate),
        ),
        body: body());
  }
}
