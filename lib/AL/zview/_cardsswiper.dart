import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';

import '../../BL/bl.dart';
import '../../BL/orm.dart';

import 'aedit/fieldpopup.dart';
import 'zcoloredview.dart';
import 'battribs/_attribs.dart';
import 'aedit/attredit.dart';

import 'rowpopupmenu.dart';

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
    redoClear();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void setStateSwiper() {
    setState(() {});
  }
  //---------------------------------------------------------- int startRow

  void currentRowIndexFromBookmarksGet() {}

  void indexChanged(int rowIndex) async {
    if (bl.orm.currentRow.setCellDLOn) {
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Wait second\nSaving chnge to cloud')));
    }
    currentSS.swiperIndex = rowIndex;
    if (currentSS.swiperIndex > currentSS.keys.length - 1) {
      currentSS.swiperIndex = 0;
    }
    if (currentSS.swiperIndex < 0) {
      currentSS.swiperIndex = currentSS.keys.length - 1;
    }
    redoClear();
    await currentRowSet(currentSS.keys[currentSS.swiperIndex]);
    setState(() {});
  }

  void onIndexChanged(int rowIndex) async {
    indexChanged(rowIndex);
  }

  void swiperSetstate() {
    setState(() {});
  }

  Row titleArrowsRowOff() {
    return Row(children: [
      currentSS.filterIcon,
      Text(widget.title),
      const Text('  '),
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
      IconButton(
          onPressed: () {
            showGotoPopupMenu(context, swiperSetstate);
          },
          icon: const Icon(Icons.run_circle_outlined)),
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
          title: titleArrowsRowOff(),
          centerTitle: true,
          actions: [rowViewMenu({}, swiperSetstate)],
          bottom: TabBar(
            tabs: [
              Tab(
                  child: !readOnlyView
                      ? IconButton(
                          onPressed: () {
                            setState(() {
                              readOnlyView = !readOnlyView;
                            });
                          },
                          icon: const Icon(Icons.edit))
                      : IconButton(
                          onPressed: () {
                            setState(() {
                              readOnlyView = !readOnlyView;
                            });
                          },
                          icon: const Icon(Icons.format_quote))),
              const Tab(child: Icon(Icons.view_agenda)),
            ],
          ),
        ),
        body: TabBarView(
          physics: const NeverScrollableScrollPhysics(),
          children: [
            readOnlyView ? const ColoredView() : AttrEdit(swiperSetstate),
            QuoteAttribs(setStateSwiper)
          ],
        ),
      ),
    );
  }

  //SwiperControl swiperControl = const SwiperControl();
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
  }
}
