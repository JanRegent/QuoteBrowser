import 'package:flutter/material.dart';
import 'package:quotebrowser/2BL_domain/orm.dart';
import 'package:rich_text_controller/rich_text_controller.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alertinfo/alertok.dart';

void setCellAL(String attribName, BuildContext context,
    VoidCallback swiperSetstate) async {
  if (bl.orm.currentRow.selectedText.value.isEmpty) return;
  bl.orm.currentRow.attribNameLast.value = '';

  bl.orm.currentRow.setCellColor = Colors.red;

  switch (attribName) {
    case 'author':
      bl.orm.currentRow.author.value = bl.orm.currentRow.selectedText.value;
      await bl.orm.currentRow
          .setCellBL('author', bl.orm.currentRow.author.value);
      bl.orm.currentRow.attribNameLast.value = attribName;
      break;
    case 'book':
      bl.orm.currentRow.book.value = bl.orm.currentRow.selectedText.value;
      await bl.orm.currentRow.setCellBL('book', bl.orm.currentRow.book.value);
      bl.orm.currentRow.attribNameLast.value = attribName;
      break;
    case 'parPage':
      bl.orm.currentRow.parPage.value;
      bl.orm.currentRow.parPage.value +=
          ' ${bl.orm.currentRow.selectedText.value}';
      await bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.parPage.value);
      bl.orm.currentRow.attribNameLast.value = attribName;
      break;
    case 'vydal':
      await bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.selectedText.value);
      break;
    case 'tags':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.orm.currentRow.selectedText.value.length > 20) {
        warningDialog('Tag length > 20', context);
        return;
      }
      bl.orm.currentRow.tags.value +=
          '#${bl.orm.currentRow.selectedText.value}';
      bl.tagsParts.pureTags();
      await bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.tags.value);
      bl.orm.currentRow.attribNameLast.value = attribName;
      break;
    case 'yellowParts':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.orm.currentRow.selectedText.value.length <= 10) {
        warningDialog('yellowPart length <= 10', context);
        return;
      }

      bl.orm.currentRow.yellowParts.value +=
          '__|__\n${bl.orm.currentRow.selectedText.value}';

      bl.tagsParts.pureYellowparts();
      await bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.yellowParts.value);
      bl.orm.currentRow.attribNameLast.value = attribName;
      break;
    case 'original':
      await bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.original.value);
      break;
    case '__othersFields__':
      break;

    default:
      break;
  }
  bl.orm.currentRow.selectedText.value = '';
  bl.orm.currentRow.setCellColor == Colors.white;
  editControlerInit();
  swiperSetstate();
}

int regpatternMatchMapsIndex = 0;
void editControlerInit() {
  String tagsRegex = bl.orm.currentRow.tags.value.replaceAll('#', '|');

  List<Map<RegExp, TextStyle>> patternMatchMaps = [
    {
      RegExp(tagsRegex):
          const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
    },
    {
      RegExp(yellowPartsRegex()):
          const TextStyle(backgroundColor: Colors.yellow),
    }
  ];

  quoteEditController = RichTextController(
    text: bl.orm.currentRow.quote.value,
    patternMatchMap: patternMatchMaps[regpatternMatchMapsIndex],
    onMatch: (List<String> matches) {},
  );
}

//-----------------------------------------------------------quoteFireld
String yellowPartsRegex() {
  String reg = '';
  List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__\n');
  for (var i = 0; i < parts.length; i++) {
    reg = reg + parts[i].trim();
    if (i > 0) reg = '$reg|';
  }
  return reg;
}
