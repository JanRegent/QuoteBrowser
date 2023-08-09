import 'package:isar/isar.dart';
import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/dl.dart';

Future sheet2db() async {
  await openIsar();
  final isar = Isar.get(schemas: [SheetSchema]);
  String sheetName = 'fb:Lao-c';
  String fileId = '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w';
  List<List<String>> rows =
      await dl.gsheetsHelper.getSheetAll(sheetName, fileId);

  Sheet sheet = Sheet().sheetFromRow(rows[0], rows[2]);
  sheet.id = isar.sheets.autoIncrement();
  sheet.aSheetName = sheetName;
  sheet.zfileId = fileId;

  print(await sheet.toStrings());
}
