import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import 'edit/battr/_quoteedit.dart';
import 'edit/cattribs/headfields.dart';
import 'edit/cattribs/othersfields.dart';
import 'swipermenu.dart';
import 'viewhigh/highwiew.dart';

// ignore: must_be_immutable
class SwiperButts extends StatefulWidget {
  VoidCallback setStateSwiper;
  String title1;
  String title2;
  VoidCallback swiperSetstateIndexChanged;

  SwiperButts(this.setStateSwiper, this.title1, this.title2,
      this.swiperSetstateIndexChanged,
      {Key? key})
      : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SwiperButtsState createState() => _SwiperButtsState();
}

class _SwiperButtsState extends State<SwiperButts> {
  void swiperIndexIncrementInCloud() async {
    if (currentSS.swiperIndexIncrement == false) return;

    if (currentSS.currentHomeTabIndex == 1) {
      bl.booksCount[bl.orm.currentRow.sheetName] = currentSS.swiperIndex;
      dl.httpService.setCellDL('booksList', 'swiperIndex',
          currentSS.swiperIndex.toString(), currentSS.bookListRow.rowNo);
    }
    if (currentSS.currentHomeTabIndex == 0) {
      dl.httpService.setCellDL(
          'dailyList',
          'swiperIndex',
          currentSS.swiperIndex.toString(),
          currentSS.dailyListRow.rowNo.toString());
    }
  }

  Row titleArrowsRowOff() {
    return Row(children: [
      al.infoButton(context, widget.title1, '\n${widget.title2}'),
      const Spacer(),
      ElevatedButton(
        onPressed: () {
          if (bl.orm.currentRow.setCellDLOn) return;
          currentSS.swiperIndex -= 1;
          indexChanged(currentSS.swiperIndex.value);
          widget.setStateSwiper();
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(20),
          backgroundColor: Colors.blue, // <-- Button color
          foregroundColor: Colors.red, // <-- Splash color
        ),
        child: const Icon(Icons.arrow_back_rounded, color: Colors.white),
      ),
      //
      TextButton(
          onPressed: () {
            if (bl.orm.currentRow.setCellDLOn) return;
            showGotoPopupMenu(context, widget.setStateSwiper);
          },
          child: Obx(() => Text(
              ' ${(currentSS.swiperIndex.value + 1)}/${currentSS.keys.length}',
              style: const TextStyle(color: Colors.black, fontSize: 20)))),
      ElevatedButton(
        //----------------------------------------forward --next
        onPressed: () {
          if (bl.orm.currentRow.setCellDLOn) return;
          currentSS.swiperIndex += 1;
          indexChanged(currentSS.swiperIndex.value);
          widget.setStateSwiper();
          swiperIndexIncrementInCloud();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: titleArrowsRowOff(),
        actions: [rowViewMenu({}, widget.setStateSwiper)],
      ),
      body: SafeArea(
        child: DefaultTabController(
          length: 4,
          child: Column(
            children: <Widget>[
              ButtonsTabBar(
                backgroundColor: Colors.red,
                unselectedBackgroundColor: Colors.grey[300],
                unselectedLabelStyle: const TextStyle(color: Colors.black),
                labelStyle: const TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold),
                tabs: const [
                  Tab(
                    icon: Icon(Icons.format_quote),
                    text: "quote",
                  ),
                  Tab(
                    icon: Icon(Icons.edit_attributes_sharp),
                    text: "edit",
                  ),
                  Tab(icon: Icon(Icons.view_list), text: 'head'),
                  Tab(
                    icon: Icon(Icons.view_list_outlined),
                    text: 'others',
                  ),
                ],
              ),
              Expanded(
                child: TabBarView(
                  children: <Widget>[
                    const HighViewPage(),
                    QuoteEdit(widget.setStateSwiper, context),
                    const HeadFields(),
                    const OthersFields(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
