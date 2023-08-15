import 'package:flutter/material.dart';

///https://medium.com/codechai/flutter-speed-upbuild-the-alertdialogs-single-choice-dialog-multiple-choice-dialog-textfield-7011ec4bac67
///
List<String> countries = [];
showMultiChoiceDialog(BuildContext context) => showDialog(
      context: context,
      builder: (context) {
        //final multipleNotifier = Provider.of<MultipleNotifier>(context);
        return AlertDialog(
          title: const Text("Select one country or many countries"),
          content: SingleChildScrollView(
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: countries
                    .map((e) => CheckboxListTile(
                          title: Text(e),
                          onChanged: (value) {
                            // value
                            //     ? multipleNotifier.addItem(e)
                            //     : multipleNotifier.removeItem(e);
                          },
                          value: true, //multipleNotifier.isHaveItem(e),
                        ))
                    .toList(),
              ),
            ),
          ),
          actions: [
            ElevatedButton(
              child: const Text("Yes"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );

class MultipleNotifier extends ChangeNotifier {
  // ignore: prefer_final_fields
  List<String> _selectedItems = [];
  MultipleNotifier(this._selectedItems);
  List<String> get selectedItems => _selectedItems;
  bool isHaveItem(String value) => _selectedItems.contains(value);
  addItem(String value) {
    if (!isHaveItem(value)) {
      _selectedItems.add(value);
      notifyListeners();
    }
  }

  removeItem(String value) {
    if (isHaveItem(value)) {
      _selectedItems.remove(value);
      notifyListeners();
    }
  }
}
