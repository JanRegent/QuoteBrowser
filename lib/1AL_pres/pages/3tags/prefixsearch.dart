import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';
import '../../zswipbrowser/_swiper.dart';

Future<String> tag4swipper(String tagPrefixes) async {
  currentSS.keys = await dl.httpService.getrowsByTagPrefixes(tagPrefixes);

  if (currentSS.keys.isEmpty) {
    return '0';
  }
  currentSS.swiperIndex.value = 0;
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length.toString();
}

class PrefixSearchPage extends StatefulWidget {
  const PrefixSearchPage({super.key});

  @override
  State<PrefixSearchPage> createState() => _PrefixSearchPageState();
}

class _PrefixSearchPageState extends State<PrefixSearchPage> {
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
    al.messageInfo(context, 'geting tags with prefix', tagPrefix, 10);

    incList = await dl.httpService.getTagsByPrefix(tagPrefixController.text);
    setState(() {});
  }

  void getQuotesByTagPrefixes(String tagPrefixes) async {
    al.messageInfo(context, 'geting quotes with tag', tagPrefixes, 10);
    await tag4swipper(tagPrefixes);
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(tagPrefixes, const {})),
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
