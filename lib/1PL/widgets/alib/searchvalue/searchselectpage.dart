import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../zresults/swiperbrowser/edit/battr/addquote/emptyview.dart';

class SearchSelectPage extends StatefulWidget {
  final List<String> values;
  final String title;

  const SearchSelectPage(this.values, this.title, {super.key});

  @override
  State<SearchSelectPage> createState() => _SearchSelectPageState();
}

class _SearchSelectPageState extends State<SearchSelectPage> {
  final TextEditingController textEditingController = TextEditingController();

  Widget bodyLv2(BuildContext context) {
    return SearchableList<String>.async(
      builder: (displayedList, itemIndex, item) {
        return ListTile(
          title: Text(displayedList[itemIndex]),
          onTap: () async {
            Navigator.pop(context, displayedList[itemIndex]);
          },
        );
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 1));
        return widget.values;
      },
      asyncListFilter: (query, list) {
        return widget.values
            .where((element) =>
                element.toString().toLowerCase().contains(query.toLowerCase()))
            .toList();
      },
      seperatorBuilder: (context, index) {
        return const Divider();
      },
      style: const TextStyle(fontSize: 25),
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
        labelText: "Search dateinsert",
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: bodyLv2(context),
    );
  }

  //-------------------------------------------------------sheetNames
}
