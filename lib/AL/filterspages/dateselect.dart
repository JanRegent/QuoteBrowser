import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

//import 'package:searchable_listview/searchable_listview.dart';

import '../../BL/bluti.dart';
import 'emptyview.dart';
import 'sheetnames.dart';

Future<String> dateSelect(BuildContext context) async {
  List<String> dateinserts = blUti.lastNdays(10);

  // ignore: use_build_context_synchronously
  return await Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => DateSelectPage(dateinserts)),
  );
}

class DateSelectPage extends StatefulWidget {
  final List<String> dateinserts;

  const DateSelectPage(this.dateinserts, {super.key});

  @override
  State<DateSelectPage> createState() => _DateSelectPageState();
}

class _DateSelectPageState extends State<DateSelectPage> {
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
            Navigator.pop(context, '${widget.dateinserts[itemIndex]}.');
          },
        );
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 1));
        return widget.dateinserts;
      },
      asyncListFilter: (query, list) {
        return widget.dateinserts
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
      appBar: AppBar(title: const Text('By Autojr and books)')),
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
