import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../3Data/dl.dart';
import 'bl.dart';
import 'repos/sheetrowshelper.dart';

void indexChanged(int rowIndex) async {
  bl.orm.currentRow.selectedText.value = '';

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
    bl.orm.currentRow.rowkey.value = sheetRow.rowkey;

    bl.orm.currentRow.sheetName.value = sheetRow.sheetName;

    bl.orm.currentRow.quote.value = sheetRow.quote;
    quoteEditController.text = bl.orm.currentRow.quote.value;
    bl.orm.currentRow.yellowParts.value = sheetRow.yellowParts;

    bl.orm.currentRow.author.value = sheetRow.author;

    bl.orm.currentRow.book.value = sheetRow.book;

    bl.orm.currentRow.parPage.value = sheetRow.parPage;
    bl.orm.currentRow.tags.value = sheetRow.tags;
    bl.orm.currentRow.stars.value = sheetRow.stars;
    bl.orm.currentRow.fav.value = sheetRow.favorite;

    bl.orm.currentRow.dateinsert = sheetRow.dateinsert;

    bl.orm.currentRow.sourceUrl.value = sheetRow.sourceUrl;

    bl.orm.currentRow.original.value = sheetRow.original;

    bl.orm.currentRow.publisher.value = sheetRow.vydal;
    bl.orm.currentRow.fileUrl.value = sheetRow.fileUrl;

    bl.orm.currentRow.folder.value = sheetRow.folderUrl;
    bl.tagsParts.pureTags();

    void optionalValuesSet() {
      //--------------------------optional user fields

      bl.orm.currentRow.optionalvalues = RxList<RxString>();
      bl.orm.currentRow.optionalColumNames = [];

      bl.orm.currentRow.optionalvalues.refresh();
    }

    optionalValuesSet();
  }

  //-------------------------------------------------------set
  RxString selectedText = ''.obs;

  void setCellBL(String columnName, String cellContent) async {
    if (columnName.isEmpty) return;
    bl.orm.currentRow.setCellColor = Colors.red;
    try {
      dl.gservice23.setCellDL(bl.orm.currentRow.sheetName.value, columnName,
          cellContent, bl.orm.currentRow.rowkey.value);

      bl.orm.currentRow.selectedText.value = '';
    } catch (e) {
      debugPrint('setCellBL($columnName) \n$e');
    }
    bl.orm.currentRow.setCellColor = Colors.white;
  }
}

TextEditingController quoteEditController = TextEditingController();
