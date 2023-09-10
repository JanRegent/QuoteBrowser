import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../BL/orm.dart';

import 'zquoteview.dart';
import 'aattribs.dart';
import 'bedit/attredit.dart';

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

  void onIndexChanged(int rowIndex) async {
    currentRowIndex = rowIndex;
    await currentRowSet();
    setState(() {});
  }

  void swiperSetstate() {
    setState(() {});
  }

  bool readOnlyView = false;
  Widget tabs() {
    return DefaultTabController(
      length: 3,
      initialIndex: 1, //refresh 1st page
      child: Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [rowViewMenu({}, swiperSetstate)],
          bottom: TabBar(
            tabs: [
              const Tab(child: Icon(Icons.view_agenda)),
              Tab(
                  child: readOnlyView
                      ? const Icon(Icons.format_quote)
                      : const Icon(Icons.edit)),
              const Tab(text: '##'),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            const QuoteAttribs(),
            readOnlyView ? const QuoteView() : AttrEdit(swiperSetstate),
            const Text('##'),
          ],
        ),
      ),
    );
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
            return tabs(); // RowViewPage(widget.title, swiperSetstate);
          },
          itemCount: sheetkeyData.length,
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
    return Scaffold(body: body());
  }
}
