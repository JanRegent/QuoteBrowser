import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zswipbrowser/_swiper.dart';

class BywordPage extends StatefulWidget {
  const BywordPage({super.key});

  @override
  BywordPageState createState() => BywordPageState();
}

class BywordPageState extends State<BywordPage> {
  bool isSelectionMode = false;
  final int listLength = 3;

  final tagPrefixController = TextEditingController();

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

  void searchClean() {
    {
      tagPrefixController.clear;
      tagPrefixController.text = '';
      setState(() {});
    }
  }

  bool loading = false;

  TextField tagsTextfield() {
    return TextField(
      controller: tagPrefixController,
      decoration: InputDecoration(
          hintText: 'Enter word',
          prefixIcon: IconButton(
            onPressed: () => searchClean(),
            icon: const Icon(Icons.clear),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => gwtByWord(),
          )),
    );
  }

  void gwtByWord() async {
    String word = tagPrefixController.text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Get rows with word\n$word';

    String sheetGroup = 'advaitaDaily';
    setState(() {
      loading = true;
    });
    int rowsCount = await bl.prepareKeys.byWord.getSheetGroup(sheetGroup, word);
    setState(() {
      loading = false;
      bl.homeTitle.value = '';
    });
    if (rowsCount == 0) {
      tagPrefixController.text += ' !!! ';
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardSwiper('$word\nin\n$sheetGroup', const {})),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !loading
            ? tagsTextfield()
            : const Row(
                children: [
                  CircularProgressIndicator(),
                  Text('waiting results from cloud')
                ],
              ));
  }
}
