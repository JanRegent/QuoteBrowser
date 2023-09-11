import 'package:get/get.dart';

import 'package:quotebrowser/BL/params/params.dart';

import '../../DL/dl.dart';
import '../bl.dart';
import '../bluti.dart';

RxList sheetNamesToday = [].obs;
RxList sheetNamesLength = [].obs;
RxInt loadingStoreCount = 0.obs;
RxString loadingTitle = ''.obs;
List<String> sheetNames = [];
String fileId = dataSheetId;

Future sheetNamesInit() async {
  sheetNames = [];
  sheetNames = await dl.httpService.getDataSheets(dataSheetId);
  for (var i = 0; i < sheetNames.length; i++) {
    sheetNamesToday.add(0);
    sheetNamesLength.add(0);
  }
}

void clearLoadingStats() {
  for (var i = 0; i < sheetNames.length; i++) {
    sheetNamesToday[i] = 0;
    sheetNamesLength[i] = 0;
  }
}

Future rows2db() async {
  if (1 == 1) return;

  int sheetsLenStart = await bl.crud.readLenght();

  if (sheetsLenStart != 0) {
    loadingTitle.value = '';

    return;
  }

  for (var index = 0; index < sheetNames.length; index++) {
    String sheetName = sheetNames[index];

    double progressPercD = (index / sheetNames.length) * 100;

    loadingTitle.value = '${progressPercD.toInt()}%  $sheetName';

    await sheet2db(sheetName, fileId);

    sheetNamesLength[index] = await bl.crud.readLenSheet(sheetName);
    loadingStoreCount.value =
        (loadingStoreCount.value + sheetNamesLength[index]) as int;
    sheetNamesToday[index] = await bl.crud.readLenToday(sheetName);

    if (bl.devMode) {
      if (index == 5) break;
    }
  }

  loadingTitle.value = 'Refresh done devmode:${bl.devMode}';
}

Future sheet2db(String sheetName, String fileId) async {
  List rows = await dl.httpService.getAllrows(sheetName, dataSheetId);

  List<String> cols = blUti.toListString(rows[0]);

  for (var rowIndex = 0; rowIndex < rows.length; rowIndex++) {
    List<String> datarow = blUti.toListString(rows[rowIndex]);

    await bl.crud.createRowMap(
        cols, datarow, sheetName, (rowIndex + 1).toString(), fileId);
  }
}
