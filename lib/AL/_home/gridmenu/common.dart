import 'package:flutter/material.dart';
import 'package:input_dialog/input_dialog.dart';

Future<String> inputWord(BuildContext context) async {
  final word = await InputDialog.show(
    context: context,
    title: 'Enter word', // The default.
    okText: 'OK', // The default.
    cancelText: 'Cancel', // The default.
  );
  return word!;
}
