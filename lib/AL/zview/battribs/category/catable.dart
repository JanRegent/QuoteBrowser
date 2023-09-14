import 'package:flutter/material.dart';
import 'package:quotebrowser/AL/zview/battribs/category/catsmock.dart';
import 'package:searchable_listview/searchable_listview.dart';

import '../../../filters/emptyview.dart';

class CatablePage extends StatefulWidget {
  const CatablePage({Key? key}) : super(key: key);

  @override
  State<CatablePage> createState() => _CatablePageState();
}

List<String> catPaths = [];

class _CatablePageState extends State<CatablePage> {
  @override
  void initState() {
    super.initState();
    catPaths = catPaths.isEmpty ? catsMock.split('\n') : catPaths;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: renderAsynchSearchableListview(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              onPressed: addActor,
              child: const Text('Add actor'),
            ),
          )
        ],
      ),
    );
  }

  void addActor() {
    catPaths.add('aaa');
    setState(() {});
  }

  Widget renderAsynchSearchableListview() {
    return SearchableList<String>.async(
      builder: (displayedList, itemIndex, item) {
        return Text(displayedList[itemIndex]);
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 5));
        return catPaths;
      },
      asyncListFilter: (query, list) {
        return catPaths
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
        labelText: "Search Category",
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
}
