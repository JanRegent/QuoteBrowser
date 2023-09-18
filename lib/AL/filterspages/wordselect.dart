import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

//import 'package:searchable_listview/searchable_listview.dart';

import '../../BL/bl.dart';

import 'emptyview.dart';
import 'sheetnames.dart';

Future<String> wordSelect(BuildContext context) async {
  List<String> words = await bl.filtersCRUD.readWords();
  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => WordSelectPage(words)),
  );
}

class WordSelectPage extends StatefulWidget {
  final List<String> words;

  const WordSelectPage(this.words, {super.key});

  @override
  State<WordSelectPage> createState() => _WordSelectPageState();
}

class _WordSelectPageState extends State<WordSelectPage> {
  Row titleRow() {
    return const Row(children: [
      Text('  '),
      SheetNameSelect(),
    ]);
  }

  final TextEditingController textEditingController = TextEditingController();

  Widget bodyLv2(BuildContext context) {
    return SearchableList<String>.async(
      builder: (displayedList, itemIndex, item) {
        return ListTile(
          title: Text(displayedList[itemIndex]),
          onTap: () async {
            Navigator.pop(context, widget.words[itemIndex]);
          },
        );
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 1));
        return widget.words;
      },
      asyncListFilter: (query, list) {
        return widget.words
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
      appBar: AppBar(title: const Text('By word)')),
      body: bodyLv2(context),
    );
  }

  //-------------------------------------------------------sheetNames
}

class FilterParams {
  String filterScopesBasic;
  String value1;

  FilterParams(this.filterScopesBasic, this.value1);
}
