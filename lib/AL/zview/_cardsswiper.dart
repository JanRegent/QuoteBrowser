import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../BL/orm.dart';
import '_rowviewpage.dart';

// import '../../../2business_layer/appdata/approotdata.dart';

// import 'cardactions.dart';

// import 'd1quotedetailpage.dart';
// import 'd20menu.dart';

class CardSwiper extends StatefulWidget {
  final String title;
  final Map configRow;

  const CardSwiper(this.title, this.configRow, {super.key});

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

  //Map Bad state: read only
  Future<String> getData() async {
    await currentRowSet();
    return 'ok';
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
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
    setState(() {});

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
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          //https://pub.dev/packages/card_swiper
          //https://github.com/TheAnkurPanchani/card_swiper/

          itemBuilder: (BuildContext context, int rowIndex) {
            return RowViewPage(widget.title, swiperSetstate);
          },
          itemCount: swiperSheetRownoKeys.length,
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
        // appBar: AppBar(
        //   title: SheetviewMenu(const {}, const {}, swiperSetstate),
        // ),
        body: FutureBuilder<String>(
      future: getData(), // a previously-obtained Future<String> or null
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        List<Widget> children;
        if (snapshot.hasData) {
          return body();
        } else if (snapshot.hasError) {
          return const Text('sviper load err');
        } else {
          children = const <Widget>[
            SizedBox(
              width: 60,
              height: 60,
              child: CircularProgressIndicator(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text('Awaiting result...'),
            ),
          ];
        }
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: children,
          ),
        );
      },
    ));
  }
}
