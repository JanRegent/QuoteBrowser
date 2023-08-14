import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../../BL/sheet/sheet.dart';
import 'katkapdata.dart';

// ignore: must_be_immutable
class CategoryChapterBPListview extends StatefulWidget {
  Sheet sheet;
  CategoryChapterBPListview(this.sheet, {super.key});

  @override
  State<CategoryChapterBPListview> createState() =>
      _CategoryChapterBPListviewState();
}

class _CategoryChapterBPListviewState extends State<CategoryChapterBPListview> {
  @override
  initState() {
    super.initState();
    getKeywords();
  }

  @override
  Widget build(BuildContext context) {
    Widget searchableList() {
      List<String> keysRow = ['a', 'b', 'c'];
      return SearchableList<String>(
        initialList: keywords,
        builder: (index) {
          return ListTile(
            title: TextButton(
                onPressed: () => Navigator.pop(context, keysRow),
                child: Row(children: [Text(keysRow[index])])),
          ); // SheetEditPage(sheet);
        },
        filter: (value) => keywords
            .where(
              (element) => element.toLowerCase().contains(value),
            )
            .toList(),
        emptyWidget: const EmptyView(),
        inputDecoration: InputDecoration(
          labelText: "Search word",
          fillColor: Colors.white,
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
              color: Colors.blue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
      );
    }

    return GestureDetector(
        child: Scaffold(
            appBar: AppBar(title: const Text('?? select')),
            body: searchableList()));
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no sheet is found with this word'),
      ],
    );
  }
}
