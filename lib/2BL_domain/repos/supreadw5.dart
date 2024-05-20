import 'package:supabase_flutter/supabase_flutter.dart';

class SupReadW5 {
  late SupabaseClient supabase;

  Future w5queryLike(Map w5q, bool rowkeysOnly) async {
    if (w5q['qtype'] != 'w5') return [];

    String w1 = w5q['w1'].toString();
    if (w1.isEmpty) return [];
    String w2 = w5q['w2'].toString();
    String w3 = w5q['w3'].toString();
    String w4 = w5q['w4'].toString();
    String w5 = w5q['w5'].toString();

    var data = [];
    //----------------------------------------------w5
    if (w5.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .ilike('quote', '%$w1%')
          .ilike('quote', '%$w2%')
          .ilike('quote', '%$w3%')
          .ilike('quote', '%$w4%')
          .ilike('quote', '%$w5%');
    }
    //----------------------------------------------w4
    if (w4.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .ilike('quote', '%$w1%')
          .ilike('quote', '%$w2%')
          .ilike('quote', '%$w3%')
          .ilike('quote', '%$w4%');
    }
    //----------------------------------------------w3
    if (w3.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .ilike('quote', '%$w1%')
          .ilike('quote', '%$w2%')
          .ilike('quote', '%$w3%');
    }
    //----------------------------------------------w2
    if (w2.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .ilike('quote', '%$w1%')
          .ilike('quote', '%$w2%');
    }

    //----------------------------------------------w1
    if (w1.isNotEmpty) {
      data =
          await supabase.from('sheetrows').select('*').ilike('quote', '%$w1%');
    }

    if (!rowkeysOnly) return data;

    //-------------------------------------------------rowkeysOnly
    List<String> rowkeys = [];

    try {
      for (var i = 0; i < data.length; i++) {
        rowkeys.add(data[i]['rowkey']);
      }
    } catch (_) {}

    return rowkeys;
  }

  Future w5queryTextSearch(Map w5q, bool rowkeysOnly) async {
    if (w5q['qtype'] != 'w5') return [];

    String w1 = w5q['w1'].toString();
    if (w1.isEmpty) return [];
    String w2 = w5q['w2'].toString();
    String w3 = w5q['w3'].toString();
    String w4 = w5q['w4'].toString();
    String w5 = w5q['w5'].toString();

    var data = [];
    //----------------------------------------------w5
    if (w5.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3' & '$w4' & '$w5'");
    }
    //----------------------------------------------w4
    if (w4.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3' & '$w4'");
    }
    //----------------------------------------------w3
    if (w3.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3'");
    }
    //----------------------------------------------w2
    if (w2.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2'");
    }

    //----------------------------------------------w1
    if (w1.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1'");
    }

    if (!rowkeysOnly) return data;

    //-------------------------------------------------rowkeysOnly
    List<String> rowkeys = [];

    try {
      for (var i = 0; i < data.length; i++) {
        rowkeys.add(data[i]['rowkey']);
      }
    } catch (_) {}

    return rowkeys;
  }
}
