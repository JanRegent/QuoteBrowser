import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../../BL/bl.dart';
import '../../../BL/bluti.dart';

import '../../zview/_cardsswiper.dart';
import '../emptyview.dart';
import '../sheetnames.dart';

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

void filterByDateInsert(String dateinsert, BuildContext context) async {
  swiperRowMaps = await bl.crud.searchByFieldMaps('dateinsert', '$dateinsert.');
  // List<int> keysInt =
  //     await bl.crud.searchByFieldKeysInt('dateinsert', '$dateinsert.');
  // if (swiperMaps.isEmpty) return;
  // print(keysInt);
  // ignore: use_build_context_synchronously
  Navigator.push(
    context,
    MaterialPageRoute(builder: (context) => CardSwiper(dateinsert, const {})),
  );
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
    return SearchableList<String>(
      initialList: widget.dateinserts,
      builder: (index) => Card(
          child: InkWell(
        child: Text(widget.dateinserts[index]),
        onTap: () {
          filterByDateInsert(widget.dateinserts[index], context);
        },
      )),
      filter: (value) => widget.dateinserts
          .where(
            (element) => element.toLowerCase().contains(value),
          )
          .toList(),
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
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
