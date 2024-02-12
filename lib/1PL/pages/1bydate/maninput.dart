// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/dailylist.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';

class ManInputPage extends StatefulWidget {
  const ManInputPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ManInputPageState createState() => _ManInputPageState();
}

class _ManInputPageState extends State<ManInputPage> {
  List filterKeys = <String>[].obs;

  TextEditingController quoteContr = TextEditingController(text: '123');

  TextEditingController parPageContr = TextEditingController(text: '');

  void parPagesParse(int index) {
    if (currRow.parPageParse.isEmpty) return;
    List<String> pars = currRow.parPageParse.split('^');
    if (!quoteContr.text.contains(pars[0].trim())) return;
    int start = quoteContr.text.indexOf(pars[0].trim());
    String qtemp = quoteContr.text.substring(start);
    try {
      parPageContr.text = qtemp.substring(0, qtemp.indexOf(pars[1].trim()));
    } catch (_) {
      parPageContr.text = '';
    }
  }

  IconButton saveButt(int index) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        dl.httpService.appendQuote(currRow.sheetName, quoteContr.text,
            parPageContr.text, currRow.author);
      },
    );
  }

  String? sheetName;
  DailyListRow currRow = DailyListRow();

  DropdownButton2 sheetNameSelect() {
    return DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        'sheetName?',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: bl.dailyList.sheetNames
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
      value: sheetName,
      onChanged: (String? value) {
        sheetName = value;
        currRow = bl.dailyList.getBySheetName(sheetName!)!;
        author.value = currRow.author;
        parPageExp.value = currRow.parPageParse;
        setState(() {});
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

  TextField quote() {
    return TextField(
      minLines: 15,
      maxLines: 15,
      controller: quoteContr,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 30),
        hintText: 'quote?',
        hintStyle: const TextStyle(
          height: 2.8,
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }

  TextField parPageText() {
    return TextField(
      minLines: 1,
      maxLines: 1,
      controller: parPageContr,
      decoration: InputDecoration(
        hintText: 'parPage?',
        hintStyle: const TextStyle(
          height: 2.8,
        ),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  RxString parPageExp = ''.obs;

  ListTile parPageTile() {
    return ListTile(
      leading: Obx(() => Text(parPageExp.value)),
      title: parPageText(),
    );
  }

  Row buttRow() {
    return Row(
      children: [
        IconButton(onPressed: () {}, icon: const Icon(Icons.clear)),
        IconButton(onPressed: () {}, icon: const Icon(Icons.save))
      ],
    );
  }

  RxString author = ''.obs;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Text('Manual input'),
          al.linkIconOpenDoc(
              '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU', context, ''),
        ],
      )),
      body: ListView(
        children: [
          sheetNameSelect(),
          quote(),
          Obx(() => Text(author.value)),
          parPageTile(),
          buttRow()
        ],
      ),
    );
    //Row(children: [todayNews(false), todayNews(true)])
  }
}
