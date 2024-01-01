import 'package:flutter/material.dart';
import 'package:quotebrowser/DL/drift/database/tags.dart';

void tagsdriftRun() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database = AppDatabase();

  await database.into(database.tagsItems).insert(TagsItemsCompanion.insert(
        tag: 'todo: finish ',
        rownos: 'We can now',
      ));
  //List<TagsItem> allItems = await database.select(database.tagsItems).get();

  //print('items in database: $allItems');
}
