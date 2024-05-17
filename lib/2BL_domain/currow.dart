import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../1PL/pages/2books/bookslist.dart';
import '../3Data/dl.dart';
import 'bl.dart';
import 'repos/dailylist.dart';
import 'repos/sheetrowshelper.dart';

TextEditingController quoteEditController = TextEditingController();

void indexChanged(int rowIndex) async {
  bl.curRow.selectedText.value = '';

  bl.currentSS.swiperIndex.value = rowIndex;
  if (bl.currentSS.swiperIndex > bl.currentSS.keys.length - 1) {
    bl.currentSS.swiperIndex.value = 0;
  }
  if (bl.currentSS.swiperIndex < 0) {
    bl.currentSS.swiperIndex.value = bl.currentSS.keys.length - 1;
  }

  if (bl.currentSS.keys.isEmpty) return;
  await bl.curRow.getRow(bl.currentSS.keys[bl.currentSS.swiperIndex.value]);

  bl.currentSS.swiperIndexChanged = true;
}

List<String> colsMain = ['quote', 'author', 'book', 'parPage', 'tags'];

RxString loadingTitle = ''.obs;

class CurrentSS {
  List<String> keys = [];
  List<String> sheetNames = [];

  RxInt swiperIndex = 0.obs;
  bool swiperIndexChanged = false;
  bool swiperIndexIncrement = false;

  int currentHomeTabIndex = 0;
  DailyList dailyList = DailyList();
  DailyListRow dailyListRow = DailyListRow();
  BooksList bookList = BooksList();
  BookListRow bookListRow = BookListRow();
}

class CurRow {
  Color setCellColor = Colors.white;
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
  RxString rowkey = ''.obs;
  RxString sheetName = ''.obs;
  String fileId = '';
  String dateinsert = '';
  //----------------------optional user fields
  RxString publisher = ''.obs;
  RxString folder = ''.obs;
  RxString yellowParts = ''.obs;

  List<String> optionalColumNames = [];
  RxList<RxString> optionalvalues = RxList<RxString>();

  //--------------------------------------------------------get

  Future getRow(String rowkey) async {
    SheetRows sheetRow =
        SheetRows().fromMap(await bl.supRepo.rowkeySelect(rowkey));
    //--------------------------ids
    bl.curRow.rowkey.value = sheetRow.rowkey;

    bl.curRow.sheetName.value = sheetRow.sheetName;

    bl.curRow.quote.value = sheetRow.quote;
    quoteEditController.text = bl.curRow.quote.value;
    bl.curRow.yellowParts.value = sheetRow.yellowParts;

    bl.curRow.author.value = sheetRow.author;

    bl.curRow.book.value = sheetRow.book;

    bl.curRow.parPage.value = sheetRow.parPage;
    bl.curRow.tags.value = sheetRow.tags;
    bl.curRow.stars.value = sheetRow.stars;
    bl.curRow.fav.value = sheetRow.favorite;

    bl.curRow.dateinsert = sheetRow.dateinsert;

    bl.curRow.sourceUrl.value = sheetRow.sourceUrl;

    bl.curRow.original.value = sheetRow.original;

    bl.curRow.publisher.value = sheetRow.vydal;
    bl.curRow.fileUrl.value = sheetRow.fileUrl;

    bl.curRow.folder.value = sheetRow.folderUrl;
    bl.tagsParts.pureTags();

    void optionalValuesSet() {
      //--------------------------optional user fields

      bl.curRow.optionalvalues = RxList<RxString>();
      bl.curRow.optionalColumNames = [];

      bl.curRow.optionalvalues.refresh();
    }

    optionalValuesSet();
  }

  //-------------------------------------------------------set
  RxString selectedText = ''.obs;

  void setCellBL(String columnName, String cellContent) async {
    if (columnName.isEmpty) return;
    bl.curRow.setCellColor = Colors.red;
    try {
      dl.gservice23.setCellDL(bl.curRow.sheetName.value, columnName,
          cellContent, bl.curRow.rowkey.value);

      bl.curRow.selectedText.value = '';
    } catch (e) {
      debugPrint('setCellBL($columnName) \n$e');
    }
    bl.curRow.setCellColor = Colors.white;
  }
}
