import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alertinfo/alertok.dart';

void setCellAL(String attribName, BuildContext context,
    VoidCallback swiperSetstate) async {
  if (bl.orm.currentRow.selectedText.value.isEmpty) return;

  bl.orm.currentRow.setCellColor = Colors.red;

  switch (attribName) {
    case 'author':
      bl.orm.currentRow.author.value = bl.orm.currentRow.selectedText.value;
      bl.orm.currentRow.setCellBL('author', bl.orm.currentRow.author.value);
      break;
    case 'book':
      bl.orm.currentRow.book.value = bl.orm.currentRow.selectedText.value;
      bl.orm.currentRow.setCellBL('book', bl.orm.currentRow.book.value);
      break;
    case 'parPage':
      bl.orm.currentRow.parPage.value;
      bl.orm.currentRow.parPage.value +=
          ' ${bl.orm.currentRow.selectedText.value}';
      bl.orm.currentRow.setCellBL(attribName, bl.orm.currentRow.parPage.value);
      break;
    case 'vydal':
      bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.selectedText.value);
      break;
    case 'tags':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.orm.currentRow.selectedText.value.length > 20) {
        warningDialog('Tag length > 20', context);
        break;
      }
      bl.orm.currentRow.tags.value +=
          '#${bl.orm.currentRow.selectedText.value}';
      bl.tagsParts.pureTags();
      bl.orm.currentRow.setCellBL(attribName, bl.orm.currentRow.tags.value);
      break;
    case 'yellowParts':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.orm.currentRow.selectedText.value.length <= 10) {
        warningDialog('yellowPart length <= 10', context);
        break;
      }

      bl.orm.currentRow.yellowParts.value +=
          '__|__\n${bl.orm.currentRow.selectedText.value}';

      bl.tagsParts.pureYellowparts();
      bl.orm.currentRow
          .setCellBL(attribName, bl.orm.currentRow.yellowParts.value);
      break;
    case 'original':
      bl.orm.currentRow.setCellBL(attribName, bl.orm.currentRow.original.value);
      break;
    case '__othersFields__':
      break;

    default:
      break;
  }
  bl.orm.currentRow.selectedText.value = '';
  editControlerInit();
  swiperSetstate();
}

int regpatternMatchMapsIndex = 0;
String coloredText = '';
String editControlerInit() {
  // List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__\n');
  // for (var i = 0; i < parts.length; i++) {
  //   Map<String, TextStyle> map = {
  //     parts[i]: const TextStyle(backgroundColor: Colors.yellow)
  //   };
  //   matches.add(map);
  // }

  String tags = bl.orm.currentRow.tags.value.replaceAll('#', '|');
  for (var i = 0; i < tags.length; i++) {
    coloredText = coloredText.replaceAll(tags[i], '*_/${tags[i]}*_/');
  }

  return coloredText;
}

RxString coloredQuote = ''.obs;

String coloringText() {
  coloredQuote.value = bl.orm.currentRow.quote.value;

  // List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__\n');
  // for (var i = 0; i < parts.length; i++) {
  //   coloredQuote.value =
  //       coloredQuote.value.replaceAll(parts[i], '_${parts[i]}_');
  // }

  List<String> tags = bl.orm.currentRow.tags.value.split('#');
  for (var i = 0; i < tags.length; i++) {
    coloredQuote.value =
        coloredQuote.value.replaceAll(tags[i], '*{color:red}${tags[i]}*');
  }

  return coloredQuote.value;
}


//-----------------------------------------------------------quoteFireld

