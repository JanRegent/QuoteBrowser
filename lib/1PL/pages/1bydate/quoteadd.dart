// ignore_for_file: file_names

import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/dailylist.dart';
import '../../../3Data/dl.dart';
import '../../widgets/alib/alib.dart';

class QuoteAddPage extends StatefulWidget {
  const QuoteAddPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuoteAddPageState createState() => _QuoteAddPageState();
}

class _QuoteAddPageState extends State<QuoteAddPage> {
  List filterKeys = <String>[].obs;

  TextEditingController quoteContr = TextEditingController(text: '');

  TextEditingController parpageContr = TextEditingController(text: '');

  String? sheetName;
  DailyListRow currRow = DailyListRow();

  final TextEditingController sheetSearchContr = TextEditingController();

  @override
  void dispose() {
    sheetSearchContr.dispose();
    super.dispose();
  }

  // ignore: prefer_const_constructors
  Color colorBlue = Color(0xffe64a6f);

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
      items: bl.currentSS.dailyList.sheetNames
          .map((String item) => DropdownMenuItem<String>(
                value: item,
                child: Text(
                  item,
                  style: [
                    'ramp',
                    'ramf',
                    'papp',
                    'nisp',
                    'robf',
                    'toll',
                    'lask'
                  ].contains(item.substring(0, 4))
                      ? TextStyle(fontSize: 18, color: colorBlue)
                      : const TextStyle(fontSize: 18),
                ),
              ))
          .toList(),
      value: sheetName,
      onChanged: (String? value) {
        sheetName = value;
        currRow = bl.currentSS.dailyList.getBySheetName(sheetName!)!;
        parpageExp.value = currRow.parpageParse.trim();
        setState(() {});
      },
      buttonStyleData: const ButtonStyleData(
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 40,
        width: 400,
      ),
      menuItemStyleData: const MenuItemStyleData(
        height: 40,
      ),
      //----------------------------------------search
      dropdownSearchData: DropdownSearchData(
        searchController: sheetSearchContr,
        searchInnerWidgetHeight: 50,
        searchInnerWidget: Container(
          height: 50,
          padding: const EdgeInsets.only(
            top: 8,
            bottom: 4,
            right: 8,
            left: 8,
          ),
          child: TextFormField(
            expands: true,
            maxLines: null,
            controller: sheetSearchContr,
            decoration: InputDecoration(
              icon: IconButton(
                  onPressed: () {
                    sheetSearchContr.text = '';
                  },
                  icon: const Icon(Icons.clear)),
              isDense: true,
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 8,
              ),
              hintText: 'Search for an item...',
              hintStyle: const TextStyle(fontSize: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),
        searchMatchFn: (item, searchValue) {
          return item.value.toString().toLowerCase().contains(searchValue);
        },
      ),
    );
  }

  Row sheetAuthorRow() {
    return Row(
      children: [
        al.linkIconOpenUrl(
            '${currRow.sheetUrl.trim()}&range=A${saving.value}', context, ''),
        sheetNameSelect()
      ],
    );
  }

  //-----------------------------------------------------------------quote
  TextField quote() {
    return TextField(
      minLines: 10,
      maxLines: 10,
      controller: quoteContr,
      onChanged: (text) {
        text = text.replaceAll(currRow.remove1, '').trim();
        text = text.replaceAll(currRow.remove2, '').trim();
        quoteContr.text = text;

        parpagesParse();
      },
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(vertical: 30),
        hintText: 'quote?',
        hintStyle: const TextStyle(
          height: 2.8,
        ),
        fillColor: Colors.grey[200],
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(0.0),
          borderSide: const BorderSide(),
        ),
      ),
    );
  }

  //--------------------------------------------------------------parse
  TextField parpageText() {
    return TextField(
      minLines: 3,
      maxLines: 3,
      controller: parpageContr,
      decoration: InputDecoration(
        hintText: 'parpage?',
        hintStyle: const TextStyle(
          height: 2.8,
        ),
        fillColor: Colors.grey[200],
        filled: true,
      ),
    );
  }

  RxString parpageExp = ''.obs;

  ListTile parpageTile() {
    return ListTile(
      leading: Obx(() => Text(parpageExp.value)),
      title: parpageText(),
    );
  }

  void parpagesParse() {
    if (currRow.parpageParse.isEmpty) return;
    List<String> pars = currRow.parpageParse.split('^');
    if (!quoteContr.text.contains(pars[0].trim())) return;
    int start = quoteContr.text.indexOf(pars[0].trim());
    String qtemp = quoteContr.text.substring(start);
    try {
      parpageContr.text = qtemp.substring(0, qtemp.indexOf(pars[1].trim()));
    } catch (_) {
      parpageContr.text = '';
    }
  }

  //-----------------------------------------------------------------save butt

  String rownoLast = '';

  IconButton saveButt() {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () async {
        if (currRow.sheetName.isEmpty) {
          saving.value = 'sheetName!';
          return;
        }
        saving.value = 'saving to gdrive';
        saving.value = await dl.gservice23.appendQuote(currRow.sheetName,
            quoteContr.text, parpageContr.text, currRow.author);

        if (saving.value.length < 5) clearCtrls();
      },
    );
  }

  void clearCtrls() {
    quoteContr.text = '';
    parpageContr.text = '';
  }

  RxString saving = ''.obs;
  ListTile buttRow() {
    return ListTile(
      title: Row(
        children: [saveButt(), Obx(() => Text(saving.value))],
      ),
      trailing: IconButton(
          onPressed: () {
            clearCtrls();
          },
          icon: const Icon(Icons.clear)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Row(
        children: [
          const Text('Quote add'),
          al.linkIconOpenDoc(
              '1ty2xYUsBC_J5rXMay488NNalTQ3UZXtszGTuKIFevOU', context, ''),
        ],
      )),
      body: ListView(
        children: [sheetAuthorRow(), quote(), parpageTile(), buttRow()],
      ),
    );
    //Row(children: [todayNews(false), todayNews(true)])
  }
}
