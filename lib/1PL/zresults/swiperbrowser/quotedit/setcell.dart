import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../widgets/alib/alertinfo/alertok.dart';

void setCellAL(String attribName, BuildContext context,
    VoidCallback swiperSetstate) async {
  if (bl.curRow.selectedText.value.isEmpty) return;
  bl.curRow.setCellColor = Colors.red;

  switch (attribName) {
    case 'author':
      bl.curRow.author.value = bl.curRow.selectedText.value;
      bl.curRow.setCellBL('author', bl.curRow.author.value);
      break;
    case 'book':
      bl.curRow.book.value = bl.curRow.selectedText.value;
      bl.curRow.setCellBL('book', bl.curRow.book.value);
      break;
    case 'parPage':
      bl.curRow.parpage.value;
      bl.curRow.parpage.value += ' ${bl.curRow.selectedText.value}';
      bl.curRow.setCellBL(attribName, bl.curRow.parpage.value);
      break;
    case 'vydal':
      bl.curRow.setCellBL(attribName, bl.curRow.selectedText.value);
      break;
    case 'tags':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.curRow.selectedText.value.length > 20) {
        warningDialog('Tag length > 20', context);
        break;
      }
      bl.curRow.tags.value += '#${bl.curRow.selectedText.value}';
      bl.tagsParts.pureTags();
      bl.curRow.setCellBL(attribName, bl.curRow.tags.value);
      break;
    case 'yellowParts':
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
      if (bl.curRow.selectedText.value.length <= 10) {
        warningDialog('yellowpart length <= 10', context);
        break;
      }

      bl.curRow.yellowparts.value += '__|__${bl.curRow.selectedText.value}';

      bl.tagsParts.pureYellowparts();
      bl.curRow.setCellBL(attribName, bl.curRow.yellowparts.value);
      break;
    case 'original':
      bl.curRow.setCellBL(attribName, bl.curRow.original.value);
      break;
    case '__othersFields__':
      break;

    default:
      break;
  }
  bl.curRow.selectedText.value = '';
  editControlerInit();
  swiperSetstate();
}

int regpatternMatchMapsIndex = 0;
String coloredText = '';
String editControlerInit() {
  String tags = bl.curRow.tags.value.replaceAll('#', '|');
  for (var i = 0; i < tags.length; i++) {
    coloredText = coloredText.replaceAll(tags[i], '*_/${tags[i]}*_/');
  }

  return coloredText;
}

RxString coloredQuote = ''.obs;

String coloringText() {
  coloredQuote.value = bl.curRow.quote.value;

  List<String> tags = bl.curRow.tags.value.split('#');
  for (var i = 0; i < tags.length; i++) {
    coloredQuote.value =
        coloredQuote.value.replaceAll(tags[i], '*{color:red}${tags[i]}*');
  }

  return coloredQuote.value;
}


//-----------------------------------------------------------quoteFireld

