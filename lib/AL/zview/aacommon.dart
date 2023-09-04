import 'package:flutter/foundation.dart';
import 'package:get/get.dart';

import '../../BL/bl.dart';

List<Map> swiperSheetRownoKeys = [];

int currentRowIndex = 0;
CurrentRow currentRow = CurrentRow();

class CurrentRow {
  RxString quote = ''.obs;
  String original = '';
  //-----------------------attribs
  RxString author = ''.obs;
  RxString book = ''.obs;
  RxString parPage = ''.obs;
  RxString tags = ''.obs;
  //--------------------------ids
  RxString sheetName = ''.obs;
  RxString rowNo = ''.obs;
  String fileId = '';
  String dateinsert = '';
  //--------------------------optional user fields
  Map optionalFields = {};
}

Future currentRowSet() async {
  Map rowMapRowView =
      await bl.crud.readBySheetRowNo(swiperSheetRownoKeys[currentRowIndex]);
  rowMapRowView = bl.orm.checkMap(rowMapRowView);

  currentRow.quote.value = rowMapRowView['quote'] ?? '';
  currentRow.author.value = rowMapRowView['author'] ?? '';
  currentRow.book.value = rowMapRowView['book'] ?? '';
  currentRow.parPage.value = rowMapRowView['parPage'] ?? '';
  currentRow.tags.value = rowMapRowView['tags'] ?? '';

  currentRow.original = '';

  //--------------------------ids
  currentRow.sheetName.value = rowMapRowView['sheetName'] ?? '';
  currentRow.rowNo.value = rowMapRowView['rowNo'] ?? '';
  currentRow.fileId = rowMapRowView['fileId'] ?? '';
  currentRow.dateinsert = rowMapRowView['dateinsert'] ?? '';
  //--------------------------optional user fields
  currentRow.optionalFields = {};

  debugPrint('-----------------------$currentRowIndex');
  print(swiperSheetRownoKeys[currentRowIndex]);
}

Future currentRowUpdate() async {
  Map tempRow = {};

  tempRow['book'] = currentRow.book.value;
  tempRow['author'] = currentRow.author.value;
  tempRow['tags'] = currentRow.tags.value;
  tempRow['parPage'] = currentRow.parPage.value;

  await bl.crud.updateOrInsert(tempRow);
}
