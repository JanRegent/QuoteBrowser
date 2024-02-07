// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:quotebrowser/2BL_domain/bluti.dart';
import '../../../2BL_domain/bl.dart';

class BySheetGroups extends StatefulWidget {
  const BySheetGroups({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BySheetGroupsState createState() => _BySheetGroupsState();
}

class _BySheetGroupsState extends State<BySheetGroups> {
  @override
  void initState() {
    super.initState();
  }

  String? selectedGroup;

  DropdownButton2 authorsDropdownButton2(BuildContext context) {
    List<String> groups = blUti.toListString(bl.dailyList.sheetGroups.toList());
    return DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        'sheets group?',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: groups
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: const TextStyle(
                    fontSize: 14,
                  ),
                ),
              ))
          .toList(),
      value: selectedGroup,
      onChanged: (String? value) {
        sheetsOfGroup(value);
        setState(() {
          selectedGroup = value;
        });
      },
    );
  }

  List<ListTile> listTiles = [];
  void sheetsOfGroup(groupName) {
    listTiles = [];
    List<String> sheetNames =
        bl.dailyList.sheetNamesStr(groupName).split('__|__');
    for (var sheetName in sheetNames) {
      listTiles.add(ListTile(
          title: Row(
        children: [
          InkWell(
            child: Text(
              sheetName,
              style: const TextStyle(fontSize: 15),
            ),
            onTap: () async {
              await bl.prepareKeys.getSheetShow(sheetName, context);
            },
          )
        ],
      )));
    }
  }

  CustomScrollView sheetNamesLv() {
    return CustomScrollView(
      slivers: [
        //----------------------------------------------------------Last

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Card(
                margin: const EdgeInsets.all(15),
                child: Container(
                  color: Colors.orange[100 * (index % 12 + 1)],
                  height: 60,
                  alignment: Alignment.center,
                  child: listTiles[index],
                ),
              );
            },
            childCount: listTiles.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: authorsDropdownButton2(context),
        ),
        body: sheetNamesLv());
  }
}
