import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../3Data/dl.dart';
import '../bl.dart';
import 'supgitignore.dart';

class SupabaseRepo {
  // It's handy to then extract the Supabase client in a variable for later uses
  late SupabaseClient supabase;

  Future init() async {
    await Supabase.initialize(
      url: supUrl,
      anonKey: anonKey,
    );
    supabase = Supabase.instance.client;
  }

  void createTable(String mess) async {
    await supabase.rpc('log2sheetrows', params: {'mess': mess});
    //debugPrint(mess);
  }

  //-----------------------------------------------------------------create

  Future select() async {
    // Select data with filters
    final data = await supabase.from('sheetrows').select().eq('id', 4);
    return data;
  }

  //-------------------------------------------------------update

  Future sheets2supabase() async {
    await bl.supRepo.deletesheetrows();
    await bl.supRepo.sheetrowsInsertAll();
    await bl.supRepo.insertTagindex();
  }

  Future sheetrowInsert(Map sheetrow) async {
    log2sheetrows(sheetrow.toString());
    await supabase.from('sheetrows').insert(sheetrow);
    log2sheetrows('sheetrowInsert end');
  }

  Future insertSheet(String sheetName) async {
    List maprows = await dl.httpService.getAllrows2sup(sheetName);

    await supabase.from('sheetrows').insert(maprows);
  }

  Future insertTagindex() async {
    bl.supRepo.log2sheetrows('-----tagindex start');
    List maprows = await dl.httpService.tagindex2sup();
    bl.supRepo.log2sheetrows('rowsat input: ${maprows.length}');
    await supabase.from('tagindex').insert(maprows);
    bl.supRepo.log2sheetrows('-----tagindex end');
  }

  void log2sheetrows(String mess) async {
    await supabase.rpc('log2sheetrows', params: {'mess': mess});
    //debugPrint(mess);
  }

  Future sheetrowsInsertAll() async {
    log2sheetrows('-----sup.sheetrowsInsertAll start');

    for (var i = 0; i < bl.dailyList.rows.length; i++) {
      String sheetName = bl.dailyList.rows[i].sheetName;
      try {
        await bl.supRepo.deleteSheet(sheetName);
        await bl.supRepo.insertSheet(sheetName);
        log2sheetrows(sheetName);
      } catch (e) {
        debugPrint('$sheetName $e');
      }
    }
    for (var i = 0; i < bl.bookList.rows.length; i++) {
      String sheetName = bl.bookList.rows[i].sheetName;
      try {
        await bl.supRepo.deleteSheet(sheetName);
        await bl.supRepo.insertSheet(sheetName);
        log2sheetrows(sheetName);
      } catch (e) {
        debugPrint('$sheetName $e');
      }
    }
    log2sheetrows('-----sheets2sup end');
  }

  //-------------------------------------------------------delete

  Future deletesheetrows() async {
    await supabase.rpc('deletesheetrows', params: {});
    log2sheetrows('-----deletesheetrows end');
  }

  Future deleteSheet(String sheetName) async {
    try {
      await supabase.from('sheetrows').delete().match({'sheetname': sheetName});
    } catch (error) {
      // error occured
      debugPrint(error.toString());
    }
  }
}
