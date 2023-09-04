import 'package:get/get.dart';

import '../../BL/bl.dart';

Map rowMapRowView = bl.orm.newRowMap();
List<Map> swiperSheetRownoKeys = [];

int currentRowIndex = 0;

RxString book = ''.obs;
RxString author = ''.obs;
RxString tags = ''.obs;
RxString parPage = ''.obs;

Future newRowSet() async {
  rowMapRowView =
      await bl.crud.readBySheetRowNo(swiperSheetRownoKeys[currentRowIndex]);

  book.value = rowMapRowView['book'];
  author.value = rowMapRowView['author'];
  tags.value = rowMapRowView['tags'];
  parPage.value = rowMapRowView['parPage'];

  print('-----------------------$currentRowIndex');
  print(swiperSheetRownoKeys[currentRowIndex]);
}
