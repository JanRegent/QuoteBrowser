import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../zresults/swiperbrowser/_swiper.dart';

class Words5Page extends StatefulWidget {
  const Words5Page({super.key});

  @override
  Words5PageState createState() => Words5PageState();
}

class Words5PageState extends State<Words5Page> {
  bool isSelectionMode = false;
  final int listLength = 3;

  List<TextEditingController> txCont = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController()
  ];

  @override
  void initState() {
    super.initState();
    initializeSelection();
  }

  void initializeSelection() {}

  @override
  void dispose() {
    super.dispose();
  }

  void searchClean(wordIndex) {
    {
      txCont[wordIndex].clear;
      txCont[wordIndex].text = '';
      setState(() {});
    }
  }

  String? selectedValueAuthor;

  DropdownButton2 authorsDropdownButton2(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        'Author?',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: bl.authors
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
      value: selectedValueAuthor,
      onChanged: (String? value) {
        setState(() {
          selectedValueAuthor = value;
        });
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 140,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
    );
  }

  bool loading = false;
  List<String> words = ['allscope', '', '', '', '', ''];

  TextField tagsTextfield(wordIndex) {
    return TextField(
      controller: txCont[wordIndex],
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
    String word = txCont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    Map filterMap = {
      'qtype': 'w5',
      'w1': txCont[1].text,
      'w2': txCont[2].text,
      'w3': txCont[3].text,
      'w4': txCont[4].text,
      'w5': txCont[5].text
    };
    bl.currentSS.keys =
        await bl.supRepo.readSup.readW5.w5queryTextSearch(filterMap, true);
    String info = filterMap.toString();
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(info, '', const {})),
    );
  }

  Future w5queryGrid() async {
    String word = txCont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    Map filterMap = {
      'qtype': 'w5',
      'w1': txCont[1].text,
      'w2': txCont[2].text,
      'w3': txCont[3].text,
      'w4': txCont[4].text,
      'w5': txCont[5].text
    };
    List rows =
        await bl.supRepo.readSup.readW5.w5queryTextSearch(filterMap, false);
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

  IconButton search52grid() {
    return IconButton(
        onPressed: () async => await w5queryGrid(),
        icon: const Icon(Icons.grid_4x4));
  }

  ListView bodyListview() {
    return ListView(
      children: [
        authorsDropdownButton2(context),
        tagsTextfield(1),
        tagsTextfield(2),
        tagsTextfield(3),
        tagsTextfield(4),
        tagsTextfield(5),
        Row(children: [search52swip(), search52grid()])
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !loading
            ? bodyListview()
            : const Row(
                children: [
                  CircularProgressIndicator(),
                  Text('waiting results from cloud')
                ],
              ));
  }
}
