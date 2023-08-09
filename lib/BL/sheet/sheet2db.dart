import 'package:quotebrowser/BL/sheet/sheet.dart';

import '../../DL/dl.dart';

Future sheet2db() async {
  List<List<String>> rows = await dl.gsheetsHelper
      .getSheetAll('fb:Lao-c', '1YfST3IJ4V32M-uyfuthBxa2AL7NOVn_kWBq4isMLZ-w');

  Sheet sheet = Sheet().sheetFromRow(rows[0], rows[2]);
  print(await sheet.toStrings());
}
