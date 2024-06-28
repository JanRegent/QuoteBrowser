import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/repos/supabase/w5filtersrepo.dart';
import '../../../widgets/alib/alicons.dart';
import '../../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../../zresults/swiperbrowser/_swiper.dart';
import 'authorsbooksui.dart';
import 'starsfavui.dart';

late AuthorBooksUI authorBooksUI;
late StarsFavoriteUI starsFavoriteUI;
//------------------------------------------------------------w5

double leftRatio = 0.25;
double rightRatio = 0.75;

Column lpanelListview(BuildContext context, VoidCallback setStateW5) {
  Future w5querySwipper() async {
    bl.homeTitle.value = 'Search w5 ';

    bl.currentSS.keys = await bl.supRepo.readSup.readW5
        .w5queryGetRowkeys(bl.wfiltersRepo.wfilterMap);

    String info = bl.wfiltersRepo.wfilterMap.toString();
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(info, '', const {})),
    );
  }

  Future showInGrid(List rows) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QResultBuilder(rows)),
    );
  }

  Future w5queryGrid() async {
    bl.homeTitle.value = 'Search w5 ';

    List rows = await bl.supRepo.readSup.readW5
        .w5querySwitch(bl.wfiltersRepo.wfilterMap);
    bl.homeTitle.value = '';
    await showInGrid(rows);
  }

  IconButton search52swip() {
    return IconButton(
        onPressed: () async => await w5querySwipper(),
        icon: const Icon(Icons.search));
  }

  IconButton filterSave() {
    return IconButton(
        onPressed: () async {
          bl.wfiltersRepo.insert(bl.wfiltersRepo.wfilterMap);
          setStateW5();
        },
        icon: const Icon(Icons.save));
  }

  IconButton search52grid() {
    return IconButton(
        onPressed: () async => await w5queryGrid(),
        icon: ALicons.viewIcons.gridView);
  }

  TextField wordTextfield(wordIndex) {
    w5Cont[wordIndex].text = bl.wfiltersRepo.wfilterMap['w$wordIndex'];

    void searchClean(wordIndex) {
      {
        bl.wfiltersRepo.wfilterMap['w$wordIndex'] = '';
        w5Cont[wordIndex].text = '';
        setStateW5();
      }
    }

    return TextField(
      controller: w5Cont[wordIndex],
      onChanged: (value) {
        bl.wfiltersRepo.wfilterMap['w$wordIndex'] = value;
      },
      decoration: InputDecoration(
        hintText: 'Enter word $wordIndex',
        prefixIcon: IconButton(
          onPressed: () => searchClean(wordIndex),
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  return Column(children: <Widget>[
    Expanded(
        child: ListView(
      children: [
        ListTile(
            leading: IconButton(
              icon: const Icon(Icons.clear_all_rounded),
              onPressed: () => bl.wfiltersRepo.wfilterMapClearAll(),
            ),
            trailing: TextButton(
                onPressed: () {
                  leftRatio = leftRatio + 0.5;
                  if (leftRatio >= 1) leftRatio = 0.25;
                  rightRatio = 1 - leftRatio;
                  setStateW5();
                },
                child: Text(leftRatio == 0.25 ? '>>' : '<<',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        backgroundColor: Color.fromARGB(255, 186, 215, 239))))),
        wordTextfield(1),
        wordTextfield(2),
        wordTextfield(3),
        wordTextfield(4),
        wordTextfield(5),
        Card(
          color: Colors.lightBlue,
          child: Column(children: [
            authorBooksUI.authorListTile(context),
            authorBooksUI.bookListTile(context),
          ]),
        ),
        Card(
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Colors.yellow, width: 2.0),
                borderRadius: BorderRadius.circular(9.0)),
            child: Column(children: [
              starsFavoriteUI.starsListTile(context),
              starsFavoriteUI.favListTile(context)
            ])),
        const Divider(color: Colors.blue, height: 10, thickness: 5),
        Row(children: [
          search52grid(),
          const Spacer(),
          filterSave(),
          const Spacer(),
          search52swip()
        ])
      ],
    ))
  ]);
}
