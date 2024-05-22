import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../2BL_domain/bl.dart';

import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/swiperbrowser/_swiper.dart';

Future<String> tag4swipper(String tagPrefixes) async {
  bl.currentSS.keys = [];
  List data = await dl.gservice23.getrowsByTagPrefixes(tagPrefixes);
  for (var i = 1; i < data.length; i++) {
    List<String> rownos = data[i][2].toString().split('_');

    String sheetName = data[i][1];
    String rowkeyPrefix = bl.currentSS.dailyList.getRowkeyPrefix(sheetName);
    for (var ni = 0; ni < rownos.length; ni++) {
      bl.currentSS.keys.add(rowkeyPrefix + rownos[ni]);
    }
  }

  if (bl.currentSS.keys.isEmpty) {
    return '0';
  }
  bl.currentSS.swiperIndex.value = 0;
  await bl.curRow.getRow(bl.currentSS.keys[bl.currentSS.swiperIndex.value]);
  return bl.currentSS.keys.length.toString();
}

class TagPrefixSearch extends StatefulWidget {
  const TagPrefixSearch({super.key});

  @override
  State<TagPrefixSearch> createState() => _TagPrefixSearchState();
}

class _TagPrefixSearchState extends State<TagPrefixSearch> {
  final tagPrefixController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    tagPrefixController.dispose();
    super.dispose();
  }

  void searchClean() {
    {
      incList = [];
      selectedList = [];
      tagPrefixController.clear;
      tagPrefixController.text = '';
      setState(() {});
    }
  }

  TextField tagsTextfield() {
    return TextField(
      controller: tagPrefixController,
      decoration: InputDecoration(
          hintText: 'Enter tag\'s first chars',
          prefixIcon: IconButton(
            onPressed: () => searchClean(),
            icon: const Icon(Icons.clear),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => getTagsByPrefix(),
          )),
    );
  }

  void getTagsByPrefix() async {
    String tagPrefix = tagPrefixController.text;
    if (tagPrefix.isEmpty) {
      al.messageInfo(
          context, 'Get tags by prefix', 'write somme start chars', 5);
      return;
    }
    bl.homeTitle.value = 'Geting prefix*\n$tagPrefix';
    incList = await dl.gservice23.getTagsByPrefix(tagPrefixController.text);
    bl.homeTitle.value = '';
    setState(() {});
  }

  void getQuotesByTagPrefixes(String tagPrefixes) async {
    bl.homeTitle.value = 'Get quotes with tag\n$tagPrefixes';
    debugPrint(bl.homeTitle.value);
    await tag4swipper(tagPrefixes);
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(tagPrefixes, '', const {})),
    );
  }

  //-------------------------------------------------------------tagset
  List<String> tagsetPrefixes = [];
  List<Widget> prefixQuoteButtons = [];
  void prefixesAdd() {
    List<String> prefixes = [];
    if (incList.isEmpty) return;
    for (var i = 1; i < incList.length; i++) {
      prefixes.add(incList[i]);
    }
    prefixes.addAll(tagsetPrefixes);
    tagsetPrefixes = [];
    tagsetPrefixes.addAll(prefixes.sorted());

    prefixQuoteButtons = [];
    for (var i = 0; i < tagsetPrefixes.length; i++) {
      String prefix = tagsetPrefixes[i];
      prefixQuoteButtons.add(
        ListTile(
          title: Row(
            children: [
              TextButton(
                child: Text(prefix),
                onPressed: () => getQuotesByTagPrefixes(prefix),
              )
            ],
          ),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {},
          ),
        ),
      );
    }
  }

  ListView bodyListview() {
    List<Widget> items = [
      ListTile(
        leading: incList.isEmpty
            ? const Text(' ')
            : IconButton(
                onPressed: () {
                  prefixesAdd();
                  setState(() {});
                },
                icon: const Icon(Icons.add),
              ),
        title: tagsTextfield(),
        trailing: TextButton(
          child: const Text('All'),
          onPressed: () {
            if (incList.isEmpty) return;
            String all = incList.first.toString();
            for (var i = 1; i < incList.length; i++) {
              all += '__|__${incList[i]}';
            }
            getQuotesByTagPrefixes(all);
          },
        ),
      ),
      MultiSelectChipDisplay(
        items: incList.map((e) => MultiSelectItem(e, e)).toList(),
        onTap: (tagPrefix) => getQuotesByTagPrefixes(tagPrefix),
      )
    ];
    items.add(ListTile(
        leading: prefixQuoteButtons.isEmpty
            ? const Text(' ')
            : IconButton(
                icon: const Icon(Icons.save),
                onPressed: () {},
              ),
        title: Text(tagsetName),
        trailing: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            prefixQuoteButtons = [];
            setState(() {});
          },
        )));
    items.addAll(prefixQuoteButtons);
    return ListView(children: items);
  }

  String tagsetName = '??tagsetName';
  List<String> incList = [];
  List<String> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return bodyListview();
  }
}
