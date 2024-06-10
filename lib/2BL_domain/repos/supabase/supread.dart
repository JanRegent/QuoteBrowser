import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../3Data/dl.dart';
import '../../bluti.dart';
import 'supreadw5.dart';

class ReadSup {
  late SupabaseClient supabase;

  SupReadW5 readW5 = SupReadW5();

  void init() {
    debugPrint('readW5 init start');
    readW5.supabase = supabase;
  }

  Future<List<String>> columnsGet() async {
    var rows = await supabase
        .from('sheetrows')
        .select("*")
        .order('id', ascending: false)
        .limit(1);
    List<String> cols = [];
    for (var field in rows[0].keys) {
      cols.add(field);
    }
    return cols;
  }

  Future<List<String>> rowkeysDateinsert(String dateinsert) async {
    var rowkeysMap = await supabase
        .from('sheetrows')
        .select('rowkey')
        .eq('dateinsert', '$dateinsert.')
        .order('author');

    List<String> rowkeys = [];
    for (var i = 0; i < rowkeysMap.length; i++) {
      rowkeys.add(rowkeysMap[i]['rowkey']);
    }

    return rowkeys;
  }

  Future<String> rowkeysToday() async {
    var rowkeysTodays = await supabase
        .from('sheetrows')
        .select('rowkey')
        .eq('dateinsert', '${blUti.todayStr()}.');

    String report = '--------------------------------rowkeysToday';
    for (var i = 0; i < rowkeysTodays.length; i++) {
      report += '\n${rowkeysTodays[i]}';
    }
    return report;
  }

  Future<String> last10rows(String sheetName) async {
    var last10rows = await supabase
        .from('sheetrows')
        .select('rowkey')
        .eq('sheetname', sheetName)
        .order('id', ascending: true);
    String result = '\n\nlast10rows $sheetName\n';
    try {
      for (var i = last10rows.length - 10; i < last10rows.length; i++) {
        result += '${last10rows[i]}\n';
      }
    } catch (_) {}

    result += '\n ${dl.sheetUrls[sheetName]}';

    return result;
  }
}
