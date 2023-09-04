import '../../BL/bl.dart';

Map rowMapRowView = bl.orm.newRowMap();
List<Map> swiperSheetRownoKeys = [];

int currentRowIndex = 0;

Future newRowSet() async {
  rowMapRowView =
      await bl.crud.readBySheetRowNo(swiperSheetRownoKeys[currentRowIndex]);

  print('-----------------------$currentRowIndex');
  print(swiperSheetRownoKeys[currentRowIndex]);
}
