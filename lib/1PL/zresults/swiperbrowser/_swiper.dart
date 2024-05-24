import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/currow.dart';

import '../../widgets/alib/alib.dart';
import '_swipernavigabuttsquotedit.dart';

class CardSwiper extends StatefulWidget {
  final String title1;
  final String title2;
  final Map configRow;

  const CardSwiper(this.title1, this.title2, this.configRow, {super.key});

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
    indexChanged(bl.currentSS.swiperIndex.value);
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void swiperSetstate() {
    setState(() {});
  }

  void swiperSetstateIndexChanged() {
    setState(() {});
    indexChanged(0);
  }

  ConstrainedBox bodySwiper() {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          itemBuilder: (BuildContext context, int rowIndex) {
            return SwiperNavigButtsQuotedit(swiperSetstate, widget.title1,
                widget.title2, swiperSetstateIndexChanged);
          },
          itemCount: bl.currentSS.keys.length,
          onIndexChanged: (rowIndex) => indexChanged(rowIndex),
          index: bl.currentSS.swiperIndex.value,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (bl.currentSS.keys.isNotEmpty) {
      return bodySwiper();
    } else {
      return emptyResultListview('Filter is empty', context);
    }
  }
}

({String searchText, String sheetGroup, String sheetName}) emptyResult =
    (searchText: '', sheetGroup: '', sheetName: '');

ListView emptyResultListview(String title, BuildContext context) {
  return ListView(
    children: [
      Row(children: [al.iconBack(context)]),
      Text(title),
      ListTile(
        leading: const Text('searchText'),
        title: Text(emptyResult.searchText),
      ),
      ListTile(
        leading: const Text('sheetsGroup'),
        title: Text(emptyResult.sheetGroup),
      ),
      ListTile(
        leading: const Text('sheetName'),
        title: Text(emptyResult.sheetName),
      )
    ],
  );
}
