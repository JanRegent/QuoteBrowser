// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import '../../zswipbrowser/_swiper.dart';

Future getBookContentShow(
    String bookName, String sheetName, BuildContext context) async {
  bl.booksCount[bookName] = 'loading';

  try {
    bl.booksCount[bookName] = await book4swipper(sheetName, context);
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

Future<String> book4swipper(String sheetName, BuildContext context) async {
  // ignore: use_build_context_synchronously
  al.messageInfo(context, 'Loading', sheetName, 3);
  currentSS.keys = await dl.httpService.getSheetSave(sheetName);

  if (currentSS.keys.isEmpty) {
    return '0';
  }
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length.toString();
}
