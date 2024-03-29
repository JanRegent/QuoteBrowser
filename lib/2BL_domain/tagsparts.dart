import 'package:quotebrowser/2BL_domain/bluti.dart';

import 'bl.dart';

class TagsParts {
  void pureTags() {
    List<String> tagsList = bl.orm.currentRow.tags.value.split('#');
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
    bl.orm.currentRow.tags.value = tags.join('#');
  }

  void pureYellowparts() {
    List<String> ypList = bl.orm.currentRow.yellowParts.value.split('__|__');
    Set set = ypList.toSet();
    List<String> parts = blUti.toListString(set.toList());

    bl.orm.currentRow.yellowParts.value = parts.join('__|__');
  }
}
