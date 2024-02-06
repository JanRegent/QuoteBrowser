import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../1PL/pages/2books/bookslist.dart';
import '../1PL/pages/1daily/dailylist.dart';
import '../1PL/zresults/swiperbrowser/viewhigh/highwiew.dart';
import '../3Data/dl.dart';
import 'bl.dart';

void indexChanged(int rowIndex) async {
  bl.orm.currentRow.selectedText.value = '';
  bl.orm.currentRow.attribNameLast.value = '';

  currentSS.swiperIndex.value = rowIndex;
  if (currentSS.swiperIndex > currentSS.keys.length - 1) {
    currentSS.swiperIndex.value = 0;
  }
  if (currentSS.swiperIndex < 0) {
    currentSS.swiperIndex.value = currentSS.keys.length - 1;
  }

  if (currentSS.keys.isEmpty) return;
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);

  currentSS.swiperIndexChanged = true;
}

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];
CurrentSS currentSS = CurrentSS();
RxString loadingTitle = ''.obs;

class CurrentSS {
  List<String> keys = [];
  List<String> sheetNames = [];
  bool addQuoteMode = false;
  RxInt swiperIndex = 0.obs;
  bool swiperIndexChanged = false;
  bool swiperIndexIncrement = false;

  int currentHomeTabIndex = 0;
  DailyListRow dailyListRow = DailyListRow();
  BookListRow bookListRow = BookListRow();
}

class Orm {
  CurrentRow currentRow = CurrentRow();

  Future<List<String>> map2row(Map rowMap) async {
    String sheetName = rowMap['sheetName'];
    List<String>? cols = await bl.sheetcolsCRUD.readColsBySheetName(sheetName);

    List<String> row = [];

    for (var i = 0; i < cols!.length; i++) {
      try {
        row.add(rowMap[cols[i]]);
      } catch (e) {
        debugPrint(e.toString());
        row.add('');
      }
    }

    return row;
  }

  List<String> mandatoryFields = ['quote', 'author', 'book', 'tags'];
}

void currentRowNew() {
  bl.orm.currentRow = CurrentRow()
    ..fileId = ''
    ..quote.value = ''
    ..tags.value = '';
}

class CurrentRow {
  bool setCellDLOn = false;
  RxString quote = ''.obs;
  RxString original = ''.obs;
  //-----------------------attribs
  RxString author = ''.obs;
  RxString book = ''.obs;
  RxString parPage = ''.obs;
  RxString tags = ''.obs;
  RxString stars = ''.obs;
  RxString fav = ''.obs;
  RxString categories = ''.obs;
  //--------------------------others
  RxString sourceUrl = ''.obs;
  RxString fileUrl = ''.obs;
  //--------------------------ids
  RxString sheetName = ''.obs;
  RxString rowNo = ''.obs;
  String fileId = '';
  String dateinsert = '';
  //--------------------------optional user fields
  RxString publisher = ''.obs;
  RxString folder = ''.obs;
  RxString yellowParts = ''.obs;

  List<String> cols = [];
  //Map optionalFields = {};
  //List<RxString> optionalvalues = [];
  List<String> optionalColumNames = [];
  RxList<RxString> optionalvalues = RxList<RxString>();

  //-------------------------------------------------------
  RxString selectedText = ''.obs;
  RxString attribNameLast = '?'.obs;

  Future setCellBL(String columnName, String cellContent) async {
    if (columnName.isEmpty) return;
    if (bl.orm.currentRow.sheetName.value.isEmpty) return;
    try {
      List newRow = await dl.httpService.setCellDL(
          bl.orm.currentRow.sheetName.value,
          columnName,
          cellContent,
          bl.orm.currentRow.rowNo.value);

      bl.orm.currentRow.selectedText.value = '';
      return newRow[0]; //rownoKey
    } catch (e) {
      debugPrint('setCellBL($columnName) \n$e');
      return ''; //rownoKey
    }
  }
}

void pureTags() {
  List<String> tagsList = bl.orm.currentRow.tags.value.split('#');
  Set tagsSet = tagsList.toSet();
  List<String> tags = [];
  for (var tag in tagsSet) {
    try {
      if (tag.toString().isEmpty) continue;
    } catch (_) {
      continue;
    }
    tags.add(tag);
  }
  bl.orm.currentRow.tags.value = tags.join('#');
}

final TextEditingController quoteEditController = TextEditingController();

Future currentRowSet(String sheetRownoKey) async {
  List<String> rowArr = await bl.sheetrowsCRUD.getRowArr(sheetRownoKey);
  String sheetName = sheetRownoKey.split('__|__')[0];
  bl.orm.currentRow.cols =
      (await bl.sheetcolsCRUD.readColsBySheetName(sheetName))!;
  String valueGet(String columnName) {
    int fieldIndex = bl.orm.currentRow.cols.indexOf(columnName);
    if (fieldIndex == -1) return '';
    try {
      String value = rowArr[fieldIndex];
      return value;
    } catch (_) {
      return '';
    }
  }

  bl.orm.currentRow.quote.value = valueGet('quote');
  quoteEditController.text = bl.orm.currentRow.quote.value;
  bl.orm.currentRow.yellowParts.value = valueGet('yellowParts');

  bl.orm.currentRow.author.value = valueGet('author');

  bl.orm.currentRow.book.value = valueGet('book');

  bl.orm.currentRow.parPage.value = valueGet('parPage');
  bl.orm.currentRow.tags.value = valueGet('tags');
  bl.orm.currentRow.stars.value = valueGet('stars');
  bl.orm.currentRow.fav.value = valueGet('favorite');
  bl.orm.currentRow.categories.value = valueGet('categories');

  bl.orm.currentRow.dateinsert = valueGet('dateinsert');

  bl.orm.currentRow.sourceUrl.value = valueGet('sourceUrl');
  if (bl.orm.currentRow.sourceUrl.value.length > 10) {
    if (!bl.orm.currentRow.sourceUrl.value.startsWith('http')) {
      bl.orm.currentRow.sourceUrl.value =
          'https://${bl.orm.currentRow.sourceUrl.value}';
    }
  }

  bl.orm.currentRow.fileUrl.value = valueGet('fileUrl');
  if (bl.orm.currentRow.fileUrl.value.isNotEmpty) {
    if (!bl.orm.currentRow.fileUrl.value.startsWith('fb')) {
      if (!bl.orm.currentRow.fileUrl.value.startsWith('http')) {
        bl.orm.currentRow.fileUrl.value =
            'https://docs.google.com/document/d/${bl.orm.currentRow.fileUrl.value}/view';
      }
    }
  }
  if (bl.orm.currentRow.fileUrl.value.isEmpty) {
    bl.orm.currentRow.fileUrl.value = valueGet('docUrl');
  }

  bl.orm.currentRow.original.value = valueGet('original');

  bl.orm.currentRow.publisher.value = valueGet('vydal');

  bl.orm.currentRow.folder.value = valueGet('folder');
  if (bl.orm.currentRow.folder.value.isNotEmpty) {
    if (!bl.orm.currentRow.folder.value.startsWith('http')) {
      bl.orm.currentRow.folder.value =
          'https://drive.google.com/drive/u/0/folders/${bl.orm.currentRow.folder.value}';
    }
  }

  pureTags();
  initHighlight();

  //--------------------------ids

  bl.orm.currentRow.sheetName.value = sheetName;
  bl.orm.currentRow.rowNo.value = sheetRownoKey.split('__|__')[1];
  bl.orm.currentRow.fileId = valueGet('fileId');
  bl.orm.currentRow.dateinsert = valueGet('dateinsert');
  //--------------------------optional user fields

  bl.orm.currentRow.optionalvalues = RxList<RxString>();
  bl.orm.currentRow.optionalColumNames = [];

  for (var columnName in bl.orm.currentRow.cols) {
    if (columnName == 'ID') continue;
    if (columnName == 'RowNo') continue;
    if (columnName == 'quote') continue;
    if (columnName == 'author') continue;
    if (columnName == 'book') continue;
    if (columnName == 'parPage') continue;
    if (columnName == 'tags') continue;
    if (columnName == 'stars') continue;
    if (columnName == 'favorite') continue;
    if (columnName == 'categories') continue;
    if (columnName == 'original') continue;
    if (columnName == 'sourceUrl') continue;
    if (columnName == 'dateinsert') continue;
    if (columnName == 'vydal') continue;
    if (columnName == 'folder') continue;

    bl.orm.currentRow.optionalColumNames.add(columnName);
    bl.orm.currentRow.optionalvalues.add(valueGet(columnName).obs);
    bl.orm.currentRow.optionalvalues.refresh();
  }
  bl.orm.currentRow.optionalvalues.refresh();
  if (bl.orm.currentRow.book.value.isEmpty) quoteContainsBookTrySet();
}

Future quoteContainsBookTrySet() async {
  if (bl.userViewMode == true) return;
  bl.saveHeadColor = Colors.yellow;
  List<String> quoteContainsList = bl.booksCRUD.quoteContainsList();
  String quote = bl.orm.currentRow.quote.value.toLowerCase();
  for (String key in quoteContainsList) {
    String qcontains = key.trim().toLowerCase();
    if (qcontains.length == 1) continue;
    if (quote.toLowerCase().contains(qcontains)) {
      var bookAuthor = bl.booksCRUD.readBookAuthor(key);

      bl.orm.currentRow.book.value = bookAuthor.$1;
      bl.orm.currentRow.author.value = bookAuthor.$2;

      return;
    }
  }
}
