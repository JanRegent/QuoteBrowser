// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../../DL/builddate.dart';
import '../../alib/alib.dart';
import 'common.dart';

class ApplicationMenu {
  Future doItem(
      MenuTile item, BuildContext context, Function setstateHome) async {
    switch (item.tileName) {
      case 'About':
        al.messageFloating(context, 'Build', buildDate);
        break;

      case 'Settings':
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Settings")));

        break;

      default:
    }
  }
}
