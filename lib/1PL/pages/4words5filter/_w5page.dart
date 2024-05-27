import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:quotebrowser/1PL/widgets/alib/alicons.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/supabase/w5filtersrepo.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../zresults/swiperbrowser/_swiper.dart';
import 'authorsbooksui.dart';
import 'starsfavui.dart';
import 'w5listviewpanel.dart';

class Words5Page extends StatefulWidget {
  const Words5Page({super.key});

  @override
  Words5PageState createState() => Words5PageState();
}

class Words5PageState extends State<Words5Page> {
  late AuthorBooksUI authorBooksUI;
  late StarsFavoriteUI starsFavoriteUI;
  @override
  void initState() {
    super.initState();
    initializeSelection();
    authorBooksUI = AuthorBooksUI(setstateW5);
    starsFavoriteUI = StarsFavoriteUI(setstateW5);
  }

  void initializeSelection() {}

  @override
  void dispose() {
    super.dispose();
  }

  void searchClean(wordIndex) {
    {
      wfilterMap['w$wordIndex'] = '';
      w5Cont[wordIndex].text = '';
      setState(() {});
    }
  }

  void setstateW5() {
    setState(() {});
  }

  //------------------------------------------------------------w5
  TextField wordTextfield(wordIndex) {
    return TextField(
      controller: w5Cont[wordIndex],
      onChanged: (value) {
        wfilterMap['w$wordIndex'] = value;
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

  Future w5querySwipper() async {
    String word = w5Cont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    bl.currentSS.keys =
        await bl.supRepo.readSup.readW5.w5queryTextSearchKeys(wfilterMap);

    String info = wfilterMap.toString();
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(info, '', const {})),
    );
  }

  Future w5queryGrid() async {
    String word = w5Cont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    List rows =
        await bl.supRepo.readSup.readW5.w5queryTextSearchRows(wfilterMap);
    bl.homeTitle.value = '';
    await showInGrid(rows);
  }

  Future showInGrid(List rows) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QResultBuilder(rows)),
    );
  }

  IconButton search52swip() {
    return IconButton(
        onPressed: () async => await w5querySwipper(),
        icon: const Icon(Icons.search));
  }

  IconButton filterSave() {
    return IconButton(
        onPressed: () async {
          bl.wfiltersRepo.insert(wfilterMap);
          setState(() {});
        },
        icon: const Icon(Icons.save));
  }

  IconButton search52grid() {
    return IconButton(
        onPressed: () async => await w5queryGrid(),
        icon: ALicons.viewIcons.gridView);
  }

  //-----------------------------------------------------------body
  double leftRatio = 0.25;
  double rightRatio = 0.75;

  ListView bodyListview() {
    return ListView(
      children: [
        ListTile(
            leading: IconButton(
              icon: const Icon(Icons.clear_all_rounded),
              onPressed: () => wfilterMapClearAll(),
            ),
            trailing: TextButton(
                onPressed: () {
                  leftRatio = leftRatio + 0.5;
                  if (leftRatio >= 1) leftRatio = 0.25;
                  rightRatio = 1 - leftRatio;
                  setState(() {});
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
        starsFavoriteUI.starsListTile(context),
        starsFavoriteUI.favListTile(context),
        const Divider(color: Colors.blue, height: 10, thickness: 5),
        Row(children: [
          search52grid(),
          const Spacer(),
          filterSave(),
          const Spacer(),
          search52swip()
        ])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResizableContainer(
      direction: Axis.horizontal,
      divider: ResizableDivider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
        size: 14,
      ),
      children: [
        ResizableChild(
          size: ResizableSize.ratio(leftRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: bodyListview(),
          ),
        ),
        ResizableChild(
          size: ResizableSize.ratio(rightRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: W5ListviewPanel(w5Cont, setstateW5),
          ),
        ),
      ],
    ));
  }
}
