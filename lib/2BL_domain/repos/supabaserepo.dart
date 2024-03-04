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

  //-----------------------------------------------------------------create
  Future createTable() async {
    '''
    CREATE TABLE IF NOT EXISTS sheetrows(
            id serial  PRIMARY KEY, 
            rownoKey TEXT,
            sheetName TEXT,
            rowNo TEXT,
            quote TEXT,
            author TEXT,
            book TEXT,
            parPage TEXT,
            tags TEXT,
            yellowParts TEXT,
            stars TEXT,
            favorite TEXT,
            dateinsert TEXT,
            sourceUrl TEXT,
            fileUrl TEXT,
            docUrl TEXT,
            original TEXT,
            vydal TEXT,
            folderUrl TEXT,
            title TEXT
    )
    ''';
  }

  Future select() async {
    // Select data with filters
    final data = await supabase.from('sheetrows').select().eq('id', 4);
    return data;
  }

  //-------------------------------------------------------update
  Future insertSheet(String sheetName) async {
    List maprows = await dl.httpService.getAllrows2sup(sheetName);

    await supabase.from('sheetrows').insert(maprows);
  }

  Future upsertAll() async {
    debugPrint('-----------------------------------------------------upsert');
    for (var i = 0; i < bl.dailyList.rows.length; i++) {
      String sheetName = bl.dailyList.rows[i].sheetName;
      try {
        await bl.supRepo.deleteSheet(sheetName);
        await bl.supRepo.insertSheet(sheetName);
        debugPrint(sheetName);
      } catch (e) {
        debugPrint('$sheetName $e');
      }
    }
    for (var i = 0; i < bl.bookList.rows.length; i++) {
      String sheetName = bl.bookList.rows[i].sheetName;
      try {
        await bl.supRepo.deleteSheet(sheetName);
        await bl.supRepo.insertSheet(sheetName);
        debugPrint(sheetName);
      } catch (e) {
        debugPrint('$sheetName $e');
      }
    }
  }

  //-------------------------------------------------------delete
  Future deleteSheet(String sheetName) async {
    try {
      await supabase.from('sheetrows').delete().match({'sheetname': sheetName});
    } catch (error) {
      // error occured
      debugPrint(error.toString());
    }
  }
}
