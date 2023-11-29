import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../BL/orm.dart';

import '../alib/alib.dart';
import '_swipertabs.dart';
import 'bedit/quotepopup.dart';

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
  late int initialIndex;
  @override
  void initState() {
    super.initState();
    initialIndex = 0;
    redoClear();
  }

  @override
  dispose() {
    controller.dispose();
    super.dispose();
  }

  void swiperSetstate() {
    setState(() {});
  }

  void onIndexChanged(int rowIndex) async {
    indexChanged(rowIndex);
  }

  ConstrainedBox bodySwiper() {
    return ConstrainedBox(
        constraints: BoxConstraints.loose(Size(
            MediaQuery.of(context).size.width,
            MediaQuery.of(context).size.height)),
        child: Swiper(
          itemBuilder: (BuildContext context, int rowIndex) {
            return SwiperTabs(swiperSetstate, widget.title);
          },
          itemCount: currentSS.keys.length,
          onIndexChanged: (rowIndex) => onIndexChanged(rowIndex),
          index: currentSS.swiperIndex.value,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (currentSS.keys.isNotEmpty) {
      return bodySwiper();
    } else {
      return Row(
        children: [al.iconBack(context), const Text('Filter is mepty')],
      );
    }
  }
}
