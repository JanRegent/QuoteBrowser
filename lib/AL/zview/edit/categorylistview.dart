import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../../BL/sheet/sheet.dart';

List<String> keywords = [
  'ego.triky',
  'ego.sluzebne',
  'ego.spravce',
];

// ignore: must_be_immutable
class CategoryListview extends StatefulWidget {
  Sheet sheet;
  CategoryListview(this.sheet, {super.key});

  @override
  State<CategoryListview> createState() => _CategoryListviewState();
}

class _CategoryListviewState extends State<CategoryListview> {
  @override
  Widget build(BuildContext context) {
    Widget searchableList() {
      List<String> keysRow = ['a', 'b', 'c'];
      return SearchableList<String>(
        initialList: keywords,
        builder: (index) {
          List<String> rowWords = keysRow[index].split('.');
          return ListTile(
            leading: TextButton(
                onPressed: () => Navigator.pop(context, keysRow),
                child: Text(rowWords[0])),
            title: TextButton(
                onPressed: () => Navigator.pop(context, keysRow),
                child: Text(rowWords[1])),
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
