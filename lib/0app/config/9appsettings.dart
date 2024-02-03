// ignore_for_file: file_names

import 'package:flutter/material.dart';

import '../../3Data/builddate.dart';
import '../../1PL/widgets/alib/alib.dart';

PopupMenuButton appSettingPopup(BuildContext context) {
  List<PopupMenuItem> items = [];
  items.add(PopupMenuItem(
    child: const Text('Build'),
    onTap: () {
      al.modalDialog(context, 'Build', buildDate);
    },
  ));
  return PopupMenuButton(
    child: const Icon(Icons.app_settings_alt_outlined),
    itemBuilder: (context) {
      return items;
    },
  );
}
