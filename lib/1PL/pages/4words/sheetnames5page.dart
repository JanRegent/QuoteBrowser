import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/swiperbrowser/_swiper.dart';

class Sheetnames5Page extends StatefulWidget {
  const Sheetnames5Page({super.key});

  @override
  Sheetnames5PageState createState() => Sheetnames5PageState();
}

class Sheetnames5PageState extends State<Sheetnames5Page> {
  bool isSelectionMode = false;
  final int listLength = 3;

  List<TextEditingController> textEditingController = [
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
      textEditingController[wordIndex].clear;
      textEditingController[wordIndex].text = '';
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
      controller: textEditingController[wordIndex],
      decoration: InputDecoration(
        hintText: 'Enter word $wordIndex',
        prefixIcon: IconButton(
          onPressed: () => searchClean(wordIndex),
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  Future getByWord5() async {
    String word = textEditingController[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Get rows with word\n$word, searchSheetNames';

    int rowsCount = await bl.prepareKeys.byWord.searchSheetNames(
        '',
        textEditingController[1].text,
        textEditingController[2].text,
        textEditingController[3].text,
        textEditingController[4].text,
        textEditingController[5].text);
    bl.homeTitle.value = '';

    if (rowsCount == 0) {
      textEditingController[0].text += ' !!! ';
      return;
    }

    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) =>
              CardSwiper('word\n$word, author$selectedValueAuthor', const {})),
    );
  }

  IconButton search5() {
    return IconButton(
        onPressed: () async => await getByWord5(),
        icon: const Icon(Icons.search));
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
        search5()
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
