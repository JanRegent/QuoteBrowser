import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../1PL/pages/2books/bookslist.dart';
import '../3Data/dl.dart';
import 'bl.dart';
import 'repos/dailylist.dart';

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
  RxString parpage = ''.obs;
  RxString tags = ''.obs;
  RxString stars = ''.obs;
  RxString fav = ''.obs;
  RxString categories = ''.obs;
  //--------------------------others
  RxString sourceUrl = ''.obs;
  RxString fileurl = ''.obs;
  //--------------------------ids
  RxString rowkey = ''.obs;
  RxString sheetName = ''.obs;
  String fileId = '';
  String dateinsert = '';
  //----------------------optional user fields
  RxString publisher = ''.obs;
  RxString folder = ''.obs;
  RxString yellowparts = ''.obs;

  List<String> optionalColumNames = [];
  RxList<RxString> optionalvalues = RxList<RxString>();

  //--------------------------------------------------------get

  Future getRow(String rowkey) async {
    var row = await bl.supRepo.rowkeySelect(rowkey);
    //--------------------------ids
    bl.curRow.rowkey.value = row['rowkey'] ?? '';

    bl.curRow.sheetName.value = row['sheetname'] ?? '';
    bl.curRow.quote.value = row['quote'] ?? '';
    quoteEditController.text = bl.curRow.quote.value;
    bl.curRow.yellowparts.value = row['yellowparts'] ?? '';
    bl.curRow.author.value = row['author'] ?? '';

    bl.curRow.book.value = row['book'] ?? '';

    bl.curRow.parpage.value = row['parpage'] ?? '';
    bl.curRow.tags.value = row['tags'] ?? '';
    bl.curRow.stars.value = row['stars'] ?? '';
    bl.curRow.fav.value = row['favorite'] ?? '';

    bl.curRow.dateinsert = row['dateinsert'] ?? '';

    bl.curRow.sourceUrl.value = row['sourceurl'] ?? '';

    bl.curRow.original.value = row['original'] ?? '';

    bl.curRow.publisher.value = row['vydal'] ?? '';
    bl.curRow.fileurl.value = row['fileurl'] ?? '';
    if (bl.curRow.fileurl.value.isEmpty) {
      bl.curRow.fileurl.value = row['docurl'] ?? '';
    }

    bl.curRow.folder.value = row['folderurl'] ?? '';
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
