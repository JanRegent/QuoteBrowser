import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../3Data/dl.dart';
import '../bluti.dart';
import 'supreadw5.dart';

class ReadSup {
  late SupabaseClient supabase;

  SupReadW5 readW5 = SupReadW5();

  void init() {
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

  void rowkeysToday() async {
    var rowkeysTodays = await supabase
        .from('sheetrows')
        .select('rowkey')
        .eq('dateinsert', '${blUti.todayStr()}.');

    debugPrint('--------------------------------rowkeysToday');
    for (var i = 0; i < rowkeysTodays.length; i++) {
      debugPrint(rowkeysTodays[i].toString());
    }
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
