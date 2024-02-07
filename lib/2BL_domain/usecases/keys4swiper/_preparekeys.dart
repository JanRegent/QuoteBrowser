import 'package:flutter/material.dart';

import '../../../1PL/pages/1bydate/dailylist.dart';
import '../../../1PL/zresults/swiperbrowser/_swiper.dart';
import '../../../3Data/dl.dart';
import '../../bl.dart';
import '../../orm.dart';
import 'byword.dart';

class PrepareKeys {
  ByWord byWord = ByWord();

  Future sheetAllKeys() async {
    DailyListRow dailyListRow = currentSS.dailyListRow;
    String sheetGroup = dailyListRow.sheetGroup;
    bl.lastCount[sheetGroup] = 'loading';
    String sheetName = dailyListRow.sheetName;
    await dl.httpService.getSheetSave(sheetName);
    List<String> keys = await bl.sheetrowsCRUD.readKeysRowNoSorted(sheetName);
    if (keys.isEmpty) return;
    currentSS.keys = [];
    currentSS.keys.addAll(keys);
    bl.lastCount[sheetGroup] = '';
    currentSS.swiperIndex.value = int.tryParse(dailyListRow.swiperIndex)!;
  }

  Future getSheetShow(String sheetName, BuildContext context) async {
    bl.homeTitle.value = 'Get sheet \n$sheetName';

    await dl.httpService.getSheetSave(sheetName);
    currentSS.keys = await dl.httpService.getSheetSave(sheetName);
    bl.homeTitle.value = '';
    if (currentSS.keys.isEmpty) return;
    currentSS.swiperIndex.value = 1;

    //ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(sheetName, const {})),
    );
  }
}
