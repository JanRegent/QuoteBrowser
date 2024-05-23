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

  Future<List<String>> w5queryTextSearchKeys(Map wfilterMap) async {
    List data = await w5queryTextSearchRows(wfilterMap);
    List<String> rowkeys = [];

    try {
      for (var i = 0; i < data.length; i++) {
        rowkeys.add(data[i]['rowkey']);
      }
    } catch (_) {}

    return rowkeys;
  }

  Future w5queryTextSearchRows(Map wfilterMap) async {
    if (wfilterMap['filtertype'] != 'w5') return [];

    String w1 = wfilterMap['w1'].toString();
    if (w1.isEmpty) return [];
    String w2 = wfilterMap['w2'].toString();
    String w3 = wfilterMap['w3'].toString();
    String w4 = wfilterMap['w4'].toString();
    String w5 = wfilterMap['w5'].toString();

    var data = [];
    //----------------------------------------------w5
    if (w5.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3' & '$w4' & '$w5'")
          .limit(100);
    }
    //----------------------------------------------w4
    if (w4.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3' & '$w4'")
          .limit(100);
    }
    //----------------------------------------------w3
    if (w3.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2' & '$w3'")
          .limit(100);
    }
    //----------------------------------------------w2
    if (w2.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1' & '$w2'")
          .limit(100);
    }

    //----------------------------------------------w1
    if (w1.isNotEmpty) {
      data = await supabase
          .from('sheetrows')
          .select('*')
          .textSearch('quote', "'$w1'")
          .limit(100);
    }
    String author = wfilterMap['author'];
    if (author == '') return data;
    List dataAuth = [];
    for (var i = 0; i < data.length; i++) {
      try {
        if (!data[i]['author'].toString().contains(author)) continue;
        dataAuth.add(data[i]);
      } catch (_) {}
    }

    return dataAuth;
  }
}
