import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import '../../../2BL_domain/orm.dart';

import '../../../2BL_domain/usecases/keys4swiper/emptyresults.dart';
import '_swiperbutts.dart';

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
    indexChanged(currentSS.swiperIndex.value);
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
            // return SwiperTabs(swiperSetstate, widget.title1, widget.title2,
            //     swiperSetstateIndexChanged);
            return SwiperButts(swiperSetstate, widget.title1, widget.title2,
                swiperSetstateIndexChanged);
          },
          itemCount: currentSS.keys.length,
          onIndexChanged: (rowIndex) => indexChanged(rowIndex),
          index: currentSS.swiperIndex.value,
          controller: controller,
        ));
  }

  @override
  Widget build(BuildContext context) {
    if (currentSS.keys.isNotEmpty) {
      return bodySwiper();
    } else {
      return emptyResultListview('Filter is empty', context);
    }
  }
}
