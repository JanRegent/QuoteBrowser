import 'package:flutter/material.dart';

void emptyDialog(String warning, BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Warning"),
        content: Text(warning),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

Future<String> noYes(String warning, BuildContext context) async {
  String result = 'no';
  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Warning"),
        content: Text(warning),
        actions: [
          IconButton(
            icon: const Icon(Icons.cancel),
            onPressed: () {
              result = 'no';
              Navigator.of(context).pop('no');
            },
          ),
          IconButton(
            icon: const Icon(Icons.check),
            onPressed: () {
              result = 'yes';
              Navigator.of(context).pop('yes');
            },
          ),
        ],
      );
    },
  );
  return result;
}
