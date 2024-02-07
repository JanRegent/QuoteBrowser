// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:holdable_button/holdable_button.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/orm.dart';
import '../../../widgets/alib/alib.dart';

import '../../../zresults/swiperbrowser/_swiper.dart';

class BySheetGroups extends StatefulWidget {
  const BySheetGroups({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _BySheetGroupsState createState() => _BySheetGroupsState();
}

class _BySheetGroupsState extends State<BySheetGroups> {
  HoldableButton holdableSheet(String sheetName, int six, sheetGroup) {
    return HoldableButton(
      width: 200,
      height: 40,
      buttonColor: Colors.green,
      loadingColor: Colors.black87,
      duration: 5,
      radius: 1,
      strokeWidth: 20,
      startPoint: 0.5,
      padding: const EdgeInsets.all(2),
      onConfirm: () async {
        print(1);
        String infoTitle = 'Sheet ${currentSS.dailyListRow.sheetName}';
        bl.homeTitle.value = infoTitle;
        print(2);
        currentSS.dailyListRow = bl.dailyList.rows[six];
        currentSS.swiperIndexIncrement = true;
        await bl.prepareKeys.sheetAllKeys();
        bl.homeTitle.value = '';
        // ignore: use_build_context_synchronously
        await Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CardSwiper(sheetName, const {})),
        );
      },
      child: InkWell(child: Text(sheetName), onTap: () async {}),
    );
  }

  PopupMenuButton sheetNamesPopupGen(String sheetGroup) {
    List<PopupMenuItem> items = [];
    for (var six = 0; six < bl.dailyList.rows.length; six++) {
      if (bl.dailyList.rows[six].sheetGroup != sheetGroup) continue;

      String sheetName = bl.dailyList.rows[six].sheetName;
      items.add(PopupMenuItem(
        child: ListTile(
            leading: Text(bl.dailyList.rows[six].swiperIndex.toString()),
            title: holdableSheet(sheetName, six, sheetGroup),
            trailing: al.linkIconOpenDoc(
                bl.dailyList.rows[six].sheetUrl, context, '')),
      ));
    }
    return PopupMenuButton(
      child: const Icon(Icons.list),
      itemBuilder: (context) {
        return items;
      },
    );
  }

  @override
  void initState() {
    super.initState();

    for (var sheetGroup in bl.dailyList.sheetGroups) {
      bl.lastCount[sheetGroup] = '';
      listTiles.add(ListTile(
          title: Row(
        children: [
          sheetNamesPopupGen(sheetGroup),
          Text(
            sheetGroup,
            style: const TextStyle(fontSize: 15),
          )
        ],
      )));
    }
  }

  List<ListTile> listTiles = [];

  Future searchSheetNamesWord5Swip(String groupName, String word1, String word2,
      String word3, String word4, String word5) async {
    bl.homeTitle.value = 'Get $word1\n$groupName';

    int rowsCount = await bl.prepareKeys.byWord
        .searchSheetNames('*', groupName, word1, word2, word3, word4, word5);
    bl.homeTitle.value = '';
    if (rowsCount == 0) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing found for $word1', '', 8);
      return;
    }

    currentSS.swiperIndexIncrement = false;
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper('word\n$word1', const {})),
    );
  }

  CustomScrollView sheetGroupsLv() {
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
    return Scaffold(body: sheetGroupsLv());
  }
}
