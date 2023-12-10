// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../BL/bl.dart';
import '../../../BL/orm.dart';
import '../../../DL/dl.dart';
import '../../zview/_swiper.dart';

Future getBookContentShow(
    String bookName, String sheetName, BuildContext context) async {
  bl.booksCount[bookName] = 'loading';

  try {
    bl.booksCount[bookName] = await book4swipper(bookName, sheetName);
  } catch (_) {
    bl.booksCount[bookName] = '0';
  }

  if (bl.booksCount[bookName] == 0) return;

  //ignore: use_build_context_synchronously
  await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CardSwiper(bookName, const {})),
  );
}

Future<String> book4swipper(String bookName, String sheetName) async {
  currentSS.filterKey = 'book__|__ $bookName';
  currentSS.swiperIndex.value = 0;
  try {
    currentSS.keys = (await bl.filtersCRUD.readFilter(currentSS.filterKey));
  } catch (_) {}
  // ignore: prefer_is_empty
  if (currentSS.keys.length == 0) {
    currentSS.keys = await dl.httpService.getBookContent(bookName);

    await bl.filtersCRUD.updateFilter('book__|__ $bookName', currentSS.keys);
  }
  if (currentSS.keys.isEmpty) {
    return '0';
  }
  currentSS.keys = await bl.sheetrowsCRUD.readKeysRowNoSorted(sheetName);
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length.toString();
}
