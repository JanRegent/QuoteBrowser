import 'package:flutter/material.dart';

import '../../../1PL/zresults/swiperbrowser/_swiper.dart';
import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';
import '../../repos/dailylist.dart';
import 'byword.dart';

class PrepareKeys {
  ByWord byWord = ByWord();

  Future sheetAllKeys() async {
    DailyListRow dailyListRow = currentSS.dailyListRow;
    String sheetGroup = dailyListRow.sheetGroup;
    bl.lastCount[sheetGroup] = 'loading';
    String sheetName = dailyListRow.sheetName;
    List<String> keys = await dl.httpService.getAllrows(sheetName);
    if (keys.isEmpty) return;
    currentSS.keys = [];
    currentSS.keys.addAll(keys);
    bl.lastCount[sheetGroup] = '';
    currentSS.swiperIndex.value = int.tryParse(dailyListRow.swiperIndex)!;
  }

  Future getSheetShow(String sheetName, BuildContext context) async {
    bl.homeTitle.value = 'Get sheet \n$sheetName';

    currentSS.keys = await dl.httpService.getAllrows(sheetName);

    bl.homeTitle.value = '';
    if (currentSS.keys.isEmpty) return;
    currentSS.swiperIndex.value = 1;

    //ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(sheetName, '', const {})),
    );
  }
}
