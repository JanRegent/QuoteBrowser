import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zswipbrowser/_swiper.dart';

class QuoteColumnPage extends StatefulWidget {
  const QuoteColumnPage({super.key});

  @override
  QuoteColumnPageState createState() => QuoteColumnPageState();
}

class QuoteColumnPageState extends State<QuoteColumnPage> {
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
            onPressed: () => gwtByColumnQuote(),
          )),
    );
  }

  void gwtByColumnQuote() async {
    String word = tagPrefixController.text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value =
        'Get rows with word\n$word, author $selectedValueAuthor';

    int rowsCount =
        await bl.prepareKeys.byWord.searchSheetsColumns2(word, 'quote', '', '');
    bl.homeTitle.value = '';

    if (rowsCount == 0) {
      tagPrefixController.text += ' !!! ';
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

  ListView bodyListview() {
    return ListView(
      children: [authorsDropdownButton2(context), tagsTextfield()],
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
