import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../zgitignore.dart';

class SupReadW5 {
  late SupabaseClient supabase;

  Future init() async {
    await Supabase.initialize(
        url: supUrl,
        anonKey:
            anonKey //Enable Row Level Security (RLS) via serviceRoleKey   NO anonKey,
        );
  }

  void resultPrint(List<Map<String, dynamic>> result) {
    for (var row in result) {
      debugPrint(row['author'] + ' ' + row['rowkey'] + ' ' + row['sheetname']);
    }
  }

  List<String> resultKeys(List<Map<String, dynamic>> result) {
    List<String> keys = [];
    for (var row in result) {
      keys.add(row['rowkey']);
    }
    return keys;
  }

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
    List<Map<String, dynamic>> data = await w5querySwitch(wfilterMap);

    return resultKeys(data);
  }

  Future<List<Map<String, dynamic>>> w5querySwitch(Map wfilterMap) async {
    if (wfilterMap['filtertype'] != 'w5') return [];

    String w5s = wfilterMap['w1'] +
        wfilterMap['w2'] +
        wfilterMap['w3'] +
        wfilterMap['w4'] +
        wfilterMap['w5'];

    String now5s =
        wfilterMap['author'].toString() + wfilterMap['favorite'].toString();
    //------------------------------------------------------------------w5 only
    if (w5s.isNotEmpty && now5s.isEmpty && wfilterMap['stars'] == 0.0) {
      return await searchW5(wfilterMap, 'w5only');
    }
    //-----------------------------------------------------------------w5 author
    if (w5s.isNotEmpty && wfilterMap['author'].toString().isNotEmpty) {
      w5s = ftxExpresion(wfilterMap);
      return await authorSearch(w5s, wfilterMap['author']);
    }

    if (w5s.isNotEmpty &&
        wfilterMap['author'].toString().isNotEmpty &&
        wfilterMap['book'].toString().isNotEmpty) {
      w5s = ftxExpresion(wfilterMap);
      return await authorW5BookSearch(
          w5s, wfilterMap['author'], wfilterMap['author']);
    }

    if (w5s.isEmpty &&
        wfilterMap['author'].toString().isNotEmpty &&
        wfilterMap['book'].toString().isNotEmpty) {
      return await authorBookSearch(wfilterMap['author'], wfilterMap['book']);
    }
    // if (data.isEmpty) data = await starsSearch(wfilterMap);
    // if (data.isEmpty) data = await favoriteSearch(wfilterMap);

    // data = await authorPost(data, wfilterMap['author']);
    // data = await starsPost(data, wfilterMap['stars']);
    // data = await favoritePost(data, wfilterMap['favorite']);

    return [];
  }

  String ftxExpresion(Map wfilterMap) {
    String w5s = '';
    for (String key in wfilterMap.keys) {
      if (!key.startsWith('w')) continue;
      if (wfilterMap[key] != '') w5s += " & '${wfilterMap[key]}'  ";
    }
    w5s = w5s.trim().substring(1); //remove first &
    return w5s;
  }

  Future<List<Map<String, dynamic>>> searchW5(
      Map wfilterMap, String range) async {
    String w5s = wfilterMap['w1'] +
        wfilterMap['w2'] +
        wfilterMap['w3'] +
        wfilterMap['w4'] +
        wfilterMap['w5'];

    if (w5s.isEmpty) return [];
    w5s = ftxExpresion(wfilterMap);
    if (range == 'w5only') return await allWordsFTX(w5s);

    return [];
  }

  Future<List<Map<String, dynamic>>> allWordsFTX(wordsAnd) async {
    final result = await supabase
        .from('sheetrows')
        .select()
        .textSearch('quote', wordsAnd); //   "'syn' & 'Milost' "

    resultPrint(result);
    return result;
  }

  Future authorSearch(String wordsAnd, String author) async {
    if (author.isEmpty) return [];

    return await supabase
        .from('sheetrows')
        .select()
        .textSearch('quote', wordsAnd)
        .eq('author', author)
        .limit(100);
  }

  Future authorW5BookSearch(String wordsAnd, String author, String book) async {
    if (author.isEmpty) return [];
    if (book.isEmpty) return [];
    return await supabase
        .from('sheetrows')
        .select()
        .textSearch('quote', wordsAnd)
        .eq('author', author)
        .eq('book', book)
        .limit(100);
  }

  Future authorBookSearch(String author, String book) async {
    if (author.isEmpty) return [];
    if (book.isEmpty) return [];
    return await supabase
        .from('sheetrows')
        .select()
        .eq('author', author)
        .eq('book', book)
        .order('parpage')
        .limit(100);
  }

  Future authorPost(List data1, String author) async {
    if (author.isEmpty) return data1;
    List data = [];
    for (var i = 0; i < data1.length; i++) {
      try {
        if (!data1[i]['author'].toString().contains(author)) continue;
        data.add(data1[i]);
      } catch (_) {}
    }
    return data;
  }

  Future starsSearch(Map wfilterMap) async {
    if (wfilterMap['stars'] == '') return [];
    if (wfilterMap['stars'] == 0.0) return [];

    var data1 = await supabase
        .from('sheetrows')
        .select('*')
        .eq('stars', '*****'.substring(0, wfilterMap['stars'].toInt()))
        .limit(100);

    return data1;
  }

  Future starsPost(List data1, stars) async {
    if (stars < 0.1) return data1;
    List data = [];
    for (var i = 0; i < data1.length; i++) {
      try {
        if (data1[i]['stars'].toString() != stars) continue;
        data.add(data1[i]);
      } catch (_) {}
    }
    return data;
  }

  Future favoriteSearch(Map wfilterMap) async {
    if (wfilterMap['favorite'] == '') return [];
    var data1 = await supabase
        .from('sheetrows')
        .select('*')
        .eq('favorite', 'f')
        .limit(100);
    return data1;
  }

  Future favoritePost(List data1, String favorite) async {
    if (favorite.isEmpty) return data1;
    List data = [];
    for (var i = 0; i < data1.length; i++) {
      try {
        if (data1[i]['favorite'].toString() != 'f') continue;
        data.add(data1[i]);
      } catch (_) {}
    }
    return data;
  }
}

/// Describes a query result
class QueryResults0 {
  final List<Map<String, dynamic>>? rows;

  QueryResults0({this.rows});
}
