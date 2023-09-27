import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';

import '../../../BL/filters/searchss.dart';
import '../../../BL/orm.dart';
import '../../zview/_cardsswiper.dart';

Future<String> inputWord(BuildContext context) async {
  final word = await InputDialog.show(
    context: context,
    title: 'Enter word', // The default.
    okText: 'OK', // The default.
    cancelText: 'Cancel', // The default.
  );
  return word!;
}

//----------------------------------------------------------search/view

Future searchText(
    String searchText, BuildContext context, Function setstateHome) async {
  loadingTitle.value = searchText;
  setstateHome();

  filterSearchText(searchText, context).then((value) async {
    loadingTitle.value = '';
    setstateHome();

    if (value == 0) return;

    await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(searchText, const {})),
    );
  }, onError: (e) {
    debugPrint(e);
  });
}
