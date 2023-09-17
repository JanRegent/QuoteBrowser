import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../BL/orm.dart';

import 'zquoteview.dart';
import 'battribs/_attribs.dart';
import 'aedit/attredit.dart';

import 'rowviewmenu.dart';

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

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }
  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {}

  void indexChanged(int rowIndex) async {
    currentSS.swiperIndex = rowIndex;
    if (currentSS.swiperIndex > currentSS.keys.length) {
      currentSS.swiperIndex = 0;
    }
    if (currentSS.swiperIndex < 0) {
      currentSS.swiperIndex = 0;
    }
    await currentRowSet();
    setState(() {});
  }

  void onIndexChanged(int rowIndex) async {
    indexChanged(rowIndex);
  }

  void swiperSetstate() {
    setState(() {});
  }

  Widget titleArrowsRow() {
    return Row(children: [
      Text(widget.title),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex -= 1;
          indexChanged(currentSS.swiperIndex);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
      ElevatedButton(
        onPressed: () {
          currentSS.swiperIndex += 1;
          indexChanged(currentSS.swiperIndex);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
        child: const Icon(Icons.arrow_forward_rounded, color: Colors.white),
      ),
    ]);
  }

  bool readOnlyView = false;
  Widget tabs() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: titleArrowsRow(),
          centerTitle: true,
          actions: [rowViewMenu({}, swiperSetstate)],
          bottom: TabBar(
            tabs: [
              Tab(
                  child: readOnlyView
                      ? const Icon(Icons.format_quote)
                      : const Icon(Icons.edit)),
              const Tab(child: Icon(Icons.view_agenda)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            readOnlyView ? const QuoteView() : AttrEdit(swiperSetstate),
            const QuoteAttribs()
          ],
        ),
      ),
    );
  }

  SwiperControl swiperControl = const SwiperControl();
  ConstrainedBox bodySwiper() {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          itemBuilder: (BuildContext context, int rowIndex) {
            return tabs(); // RowViewPage(widget.title, swiperSetstate);
          },
          itemCount: currentSS.keys.length,
          onIndexChanged: (rowIndex) => onIndexChanged(rowIndex),
          pagination: const SwiperPagination(
              builder: SwiperPagination.fraction,
              alignment: Alignment.bottomCenter),
          //control: const SwiperControl(),
          index: currentSS.swiperIndex,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    return bodySwiper();
    // return Scaffold(
    //     appBar: AppBar(
    //       title: Row(children: [
    //         IconButton(
    //             icon: const Icon(Icons.arrow_back),
    //             onPressed: () {
    //               SwiperController().previous();
    //             }),
    //         IconButton(
    //             icon: const Icon(Icons.arrow_forward),
    //             onPressed: () {
    //               SwiperController().next();
    //             })
    //       ]),
    //     ),
    //     body: body());
  }
}
