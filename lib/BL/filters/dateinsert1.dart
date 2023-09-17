import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

//import 'package:searchable_listview/searchable_listview.dart';

import '../bl.dart';
import '../bluti.dart';

import '../orm.dart';
import '../../DL/dl.dart';

//import '../emptyview.dart';
import '../../AL/filters/emptyview.dart';
import '../../AL/filters/sheetnames.dart';

Future dateinsersDo(BuildContext context) async {
  List<String> dateinserts = [];
  // await readDateinserts();

  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dateinsert1(dateinserts)),
  );
}

Future dateinsersLast(BuildContext context) async {
  List<String> dateinserts = blUti.lastNdays(10);

  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => Dateinsert1(dateinserts)),
  );
}

Future filterByDateInsert(String dateinsert) async {
  currentfilterKey = dateinsert;
  currentRowIndex = 0;

  debugPrint(dateinsert);
  List<String>? sheetRownoKeys = await bl.filtersCRUD.readFilter(dateinsert);
  //if (sheetRownoKeys == null || sheetRownoKeys.isEmpty) {
  // ignore: use_build_context_synchronously
  //circularSnack(context, 25, 'Querying cloud [gdrive]');

  await dl.httpService.searchSS(dateinsert);
  debugPrint(sheetRownoKeys.toString());
  //}

  await currentRowSet();

  // ignore: use_build_context_synchronously
}

class Dateinsert1 extends StatefulWidget {
  final List<String> dateinserts;

  const Dateinsert1(this.dateinserts, {super.key});

  @override
  State<Dateinsert1> createState() => _Dateinsert1State();
}

class _Dateinsert1State extends State<Dateinsert1> {
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
            await filterByDateInsert('${widget.dateinserts[itemIndex]}.');
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
