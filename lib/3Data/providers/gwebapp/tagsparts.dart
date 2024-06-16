import 'package:quotebrowser/2BL_domain/bluti.dart';

import '../../../2BL_domain/bl.dart';

class TagsParts {
  void pureTags() {
    List<String> tagsList = bl.curRow.tags.value.split('#');
    Set tagsSet = tagsList.toSet();
    List<String> tags = [];
    for (String tag in tagsSet) {
      try {
        if (tag.toString().isEmpty) continue;
        if (tag.endsWith(',')) {
          tag = tag.substring(0, tag.length - 1).trim as String;
        }
        if (tag.endsWith('.')) {
          tag = tag.substring(0, tag.length - 1).trim as String;
        }
        if (tag.endsWith(';')) {
          tag = tag.substring(0, tag.length - 1).trim as String;
        }
        if (tag.endsWith('"')) {
          tag = tag.substring(0, tag.length - 1).trim as String;
        }
        if (tag.endsWith("'")) {
          tag = tag.substring(0, tag.length - 1).trim as String;
        }
      } catch (_) {
        continue;
      }
      tags.add(tag);
    }
    bl.curRow.tags.value = tags.join('#');
  }

  void pureYellowparts() {
    //------------------------------------------------------uniq
    List<String> ypList = bl.curRow.yellowparts.value.split('__|__');
    Set set = ypList.toSet();
    List<String> parts = blUti.toListString(set.toList());
    //------------------------------------------------------indexOf

    String quote = bl.curRow.quote.value.toLowerCase();
    Map<int, String> partsMap = {};
    for (var part in parts) {
      if (part.trim().isEmpty) continue;
      int index = quote.indexOf(part.trim().toLowerCase());
      if (index == -1) continue;

      partsMap[index] = part.trim();
    }
    //------------------------------------------------------sort by index
    List<String> sortedParts = [];
    var sortedMap = Map.fromEntries(
        partsMap.entries.toList()..sort((e1, e2) => e1.key.compareTo(e2.key)));
    for (var part in sortedMap.values) {
      sortedParts.add(part);
    }
    bl.curRow.yellowparts.value = sortedParts.join('__|__');
  }
}
