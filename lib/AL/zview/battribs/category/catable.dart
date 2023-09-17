import 'package:flutter/material.dart';

import 'package:searchable_listview/searchable_listview.dart';

import '../../../../BL/bl.dart';
import '../../../filterspages/emptyview.dart';
import '../../aedit/quoteedit.dart';

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
    if (catPaths.isEmpty) {
      bl.catsCRUD.readAll().then((value) => catPaths = value);
    }

    //catsMock.split('\n') : catPaths;
  }

  String selectedCats = '';
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          ListTile(
            leading: IconButton(
              icon: const Icon(Icons.cancel),
              onPressed: () {
                setState(() {
                  selectedCats = '';
                });
              },
            ),
            title: Text(selectedCats),
            trailing: IconButton(
              icon: const Icon(Icons.save),
              onPressed: () async {
                bl.orm.currentRow.categories.value = selectedCats;
                await setCellAttr(
                    'categories',
                    bl.orm.currentRow.categories.value,
                    bl.orm.currentRow.rowNo.value);
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: renderAsynchSearchableListview(),
            ),
          ),
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
        return ListTile(
          title: Text(displayedList[itemIndex]),
          onTap: () {
            setState(() {
              selectedCats += '${displayedList[itemIndex]}\n';
            });
          },
        );
      },
      asyncListCallback: () async {
        await Future.delayed(const Duration(seconds: 1));
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
