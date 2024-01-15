import 'package:flutter/material.dart';
import 'package:flutter_expanded_tile/flutter_expanded_tile.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../controllers/alib/alib.dart';
import '../../zview/_swiper.dart';

Future<String> tag4swipper(String tagPrefixes) async {
  currentSS.filterKey = 'tagPrefix_rownoKeys';

  currentSS.keys = await dl.httpService.getrowsByTagPrefixes(tagPrefixes);
  // ignore: use_build_context_synchronously
  await bl.filtersCRUD.updateFilter(currentSS.filterKey, currentSS.keys);

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

  void getrowsByTagPrefixes(String tagPrefixes) async {
    al.messageInfo(context, 'geting quotes with tag', tagPrefixes, 10);
    await tag4swipper(tagPrefixes);
    // ignore: use_build_context_synchronously
    await Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper(tagPrefixes, const {})),
    );
  }

  ExpandedTileList tagsets() {
    return ExpandedTileList.builder(
      itemCount: 3,
      maxOpened: 2,
      reverse: true,
      itemBuilder: (context, index, controller) {
        return ExpandedTile(
          theme: const ExpandedTileThemeData(
            headerColor: Colors.green,
            headerRadius: 24.0,
            headerPadding: EdgeInsets.all(24.0),
            headerSplashColor: Colors.red,
            //
            contentBackgroundColor: Colors.blue,
            contentPadding: EdgeInsets.all(24.0),
            contentRadius: 12.0,
          ),
          controller:
              index == 2 ? controller.copyWith(isExpanded: true) : controller,
          title: Text("this is the title $index"),
          content: Container(
            color: Colors.red,
            child: Column(
              children: [
                const Center(
                  child: Text(
                      "This is the content!ksdjfl kjsdflk sjdflksjdf lskjfd lsdkfj  ls kfjlsfkjsdlfkjsfldkjsdflkjsfdlksjdflskdjf lksdjflskfjlsfkjslfkjsldfkjslfkjsldfkjsflksjflskjflskfjlsfkjslfkjsflksjflskfjlsfkjslfkjslfkjslfkjslfkjsldfkjsdf"),
                ),
                MaterialButton(
                  onPressed: () {
                    controller.collapse();
                  },
                  child: const Text("close it!"),
                )
              ],
            ),
          ),
          onTap: () {
            debugPrint("tapped!!");
          },
          onLongTap: () {
            debugPrint("looooooooooong tapped!!");
          },
        );
      },
    );
  }

  String lastPrefixesStr = 'ego,lask,blaho';
  ListView bodyListview() {
    Row lastPrefixes() {
      List<TextButton> lastbutts = [];
      List<String> prefs = lastPrefixesStr.split(',');
      for (var prefix in prefs) {
        lastbutts.add(TextButton(
            onPressed: () {
              tagPrefixController.text = prefix;
            },
            child: Text(prefix)));
      }
      return Row(children: lastbutts);
    }

    List<Widget> items = [
      ListTile(
        leading: IconButton(
          onPressed: () {},
          icon: const Icon(Icons.save),
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
            getrowsByTagPrefixes(all);
          },
        ),
      ),
      MultiSelectChipDisplay(
        items: incList.map((e) => MultiSelectItem(e, e)).toList(),
        onTap: (tagPrefix) => getrowsByTagPrefixes(tagPrefix),
      )
    ];
    items.add(lastPrefixes());
    items.add(tagsets());
    return ListView(children: items);
  }

  List<String> incList = [];
  List<String> selectedList = [];

  @override
  Widget build(BuildContext context) {
    return bodyListview();
  }
}
