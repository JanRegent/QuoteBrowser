import 'package:flutter/material.dart';
import 'package:multi_select_flutter/chip_display/multi_select_chip_display.dart';
import 'package:multi_select_flutter/util/multi_select_item.dart';
import 'package:quotebrowser/2BL_domain/tagsindex/tagsindexhelper.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/orm.dart';
import '../../../3Data/dl.dart';
import '../../controllers/alib/alib.dart';
import '../../zview/_swiper.dart';

Future<String> tag4swipper(String tagPrefix) async {
  currentSS.filterKey = 'tagPrefix_rownoKeys';

  currentSS.keys = await dl.httpService.getrowsByTagPrefix(tagPrefix);
  // ignore: use_build_context_synchronously
  await bl.filtersCRUD.updateFilter(currentSS.filterKey, currentSS.keys);

  if (currentSS.keys.isEmpty) {
    return '0';
  }
  currentSS.swiperIndex.value = 0;
  await currentRowSet(currentSS.keys[currentSS.swiperIndex.value]);
  return currentSS.keys.length.toString();
}

class IncrementalTagsPage extends StatefulWidget {
  const IncrementalTagsPage({super.key});

  @override
  State<IncrementalTagsPage> createState() => _IncrementalTagsPageState();
}

class _IncrementalTagsPageState extends State<IncrementalTagsPage> {
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

  List<String> incList = [];
  List<String> selectedList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: tagPrefixController,
              decoration: InputDecoration(
                hintText: 'Enter tag\'s first chars',
                suffixIcon: IconButton(
                  onPressed: () {
                    incList = [];
                    selectedList = [];
                    tagPrefixController.clear;
                    tagPrefixController.text = '';
                    setState(() {});
                  },
                  icon: const Icon(Icons.clear),
                ),
              ),
              onChanged: (prefix) async {
                incList = await tagIndexHelper
                    .getTagsStarts(tagPrefixController.text);
                setState(() {});
              },
            ),
            MultiSelectChipDisplay(
              items: incList.map((e) => MultiSelectItem(e, e)).toList(),
              onTap: (tagPrefix) async {
                al.messageInfo(
                    context, 'geting quotes with tag', tagPrefix, 10);
                await tag4swipper(tagPrefix);
                // ignore: use_build_context_synchronously
                await Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => CardSwiper(tagPrefix, const {})),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
