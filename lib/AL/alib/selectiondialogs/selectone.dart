import 'package:flutter/material.dart';

Future selectOne(List<String> values, BuildContext context) async {
  String selectedValue = '';
  showSingleChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
            title: const Text("Select one"),
            content: SingleChildScrollView(
              child: SizedBox(
                width: double.infinity,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: values
                      .map((e) => RadioListTile(
                            title: Text(e),
                            value: e,
                            groupValue: selectedValue,
                            selected: selectedValue == e,
                            onChanged: (value) {
                              if (value != selectedValue) {
                                selectedValue = value!;
                                Navigator.of(context).pop(selectedValue);
                              }
                            },
                          ))
                      .toList(),
                ),
              ),
            ));
      });

  return showSingleChoiceDialog(context);
}
