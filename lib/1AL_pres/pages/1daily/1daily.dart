// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:holdable_button/holdable_button.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/bluti.dart';
import '../../../2BL_domain/orm.dart';
import '../../widgets/alib/alib.dart';

import '../../controllers/selectvalue.dart';
import '../../zswipbrowser/_swiper.dart';

class LastMenu extends StatefulWidget {
  const LastMenu({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _LastMenuState createState() => _LastMenuState();
}

class _LastMenuState extends State<LastMenu> {
  ElevatedButton lastdays(String sheetGroup) {
    return ElevatedButton(
      child: const Icon(Icons.date_range),
      onPressed: () async {
        String searchDate = await dateSelect(context);
        if (searchDate.isEmpty) return;
        // ignore: use_build_context_synchronously
        int rowsCount =
            await bl.prepareKeys.byWord.getSheetGroup(sheetGroup, searchDate);
        if (rowsCount == 0) return;

        // ignore: use_build_context_synchronously
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => CardSwiper(sheetGroup, const {})),
        );
      },
    );
  }

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
      onConfirm: () {
        setState(() {});
      },
      child: InkWell(
          child: Text(sheetName),
          onTap: () async {
            currentSS.dailyListRow = bl.dailyList.rows[six];
            currentSS.swiperIndexIncrement = true;
            String infoTitle = 'All sheet ${currentSS.dailyListRow.sheetName}';
            bl.homeTitle.value = infoTitle;
            await bl.prepareKeys.sheetAllKeys();
            bl.homeTitle.value = '';
            // ignore: use_build_context_synchronously
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CardSwiper(sheetName, const {})),
            );
          }),
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
    listTiles.add(buttTile());

    for (var sheetGroup in bl.dailyList.sheetGroups) {
      bl.lastCount[sheetGroup] = '';
      listTiles.add(ListTile(
          leading: Obx(() => bl.lastCount[sheetGroup] != 'loading'
              ? Text(bl.lastCount[sheetGroup])
              : const CircularProgressIndicator()),
          title: Row(
            children: [
              sheetNamesPopupGen(sheetGroup),
              Text(
                sheetGroup,
                style: const TextStyle(fontSize: 15),
              )
            ],
          ),
          onTap: () async {
            currentSS.swiperIndexIncrement = false;
            String word = '${blUti.todayStr()}.';
            bl.lastCount[sheetGroup] = 'loading';
            String infoTitle = '$word\nin $sheetGroup';
            bl.homeTitle.value = infoTitle;

            await bl.prepareKeys.byWord
                .searchSheetNames(sheetGroup, word, '', '', '', '');
            bl.lastCount[sheetGroup] = '';
            bl.homeTitle.value = '';
            if (bl.lastCount[sheetGroup] == 0) return;

            // ignore: use_build_context_synchronously
            await Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => CardSwiper(infoTitle, const {})),
            );
          },
          trailing: lastdays(sheetGroup)));
    }
  }

  List<ListTile> listTiles = [];

  ListTile buttTile() {
    return ListTile(
      title: Row(
        children: [
          ElevatedButton.icon(
            icon: const Icon(Icons.refresh),
            label: const Text('All'),
            onPressed: () async {
              // await bl.prepareKeys.byWord
              //     .sheetGroupSheetName('${blUti.todayStr()}.', '');
            },
            onLongPress: () async {
              await bl.sheetrowsCRUD.deleteAllDb();
              // await bl.prepareKeys.byWord
              //     .sheetGroupSheetName('${blUti.todayStr()}.', '');
            },
          ),
          const Text(''),
          al.linkIconOpenDoc(
              '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU', context, ''),
        ],
      ),
      shape: RoundedRectangleBorder(
        side: const BorderSide(width: 2, color: Colors.black),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  Future getByWord5() async {
    String word1 = '${blUti.todayStr()}.';
    bl.homeTitle.value = 'Get rows with word\n$word1';

    int rowsCount =
        await bl.prepareKeys.byWord.searchSheetNames('', word1, '', '', '', '');
    bl.homeTitle.value = '';

    if (rowsCount == 0) {
      // ignore: use_build_context_synchronously
      al.messageInfo(context, 'Nothing found for $word1', '', 8);
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper('word\n$word1', const {})),
    );
  }

  Column todayNews() {
    return Column(
      children: [
        TextButton(
            onPressed: () async {
              await getByWord5();
            },
            child: const Text('Today news'))
      ],
    );
  }

  CustomScrollView sheetGroupsLv() {
    return CustomScrollView(
      slivers: [
        //----------------------------------------------------------Last

        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              if (index == 0) {
                return listTiles[index];
              } else {
                return Card(
                  margin: const EdgeInsets.all(15),
                  child: Container(
                    color: Colors.orange[100 * (index % 12 + 1)],
                    height: 60,
                    alignment: Alignment.center,
                    child: listTiles[index],
                  ),
                );
              }
            },
            childCount: listTiles.length,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: <Widget>[
              Tab(
                child: Text('Today'),
              ),
              Tab(
                child: Text('Sheet groups'),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: <Widget>[todayNews(), sheetGroupsLv()],
        ),
      ),
    );
  }
}
