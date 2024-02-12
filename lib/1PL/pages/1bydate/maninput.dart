// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../2BL_domain/bl.dart';
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
  final List<TextEditingController> quotesContr = [];
  RxList parPages = [''].obs;

  void parPagesParse(int index) {
    if (bl.dailyList.rows[index].parPageParse.isEmpty) return;
    List<String> pars = bl.dailyList.rows[index].parPageParse.split('^');
    if (!quotesContr[index].text.contains(pars[0].trim())) return;
    int start = quotesContr[index].text.indexOf(pars[0].trim());
    String qtemp = quotesContr[index].text.substring(start);
    try {
      String parPage = qtemp.substring(0, qtemp.indexOf(pars[1].trim()));
      parPages[index] = parPage;
    } catch (_) {}
  }

  IconButton saveButt(int index) {
    return IconButton(
      icon: const Icon(Icons.save),
      onPressed: () {
        dl.httpService.appendQuote(
            bl.dailyList.rows[index].sheetName,
            quotesContr[index].text,
            parPages[index],
            bl.dailyList.rows[index].author);
      },
    );
  }

  ListView filtersLv() {
    return ListView.builder(
        shrinkWrap: true,
        physics: const ScrollPhysics(),
        itemCount: bl.dailyList.rows.length,
        itemBuilder: (BuildContext context, int index) {
          quotesContr.add(TextEditingController());
          parPages.add('');
          return ListTile(
              leading: Text(bl.dailyList.rows[index].sheetName),
              title: TextField(
                textAlign: TextAlign.start,
                controller: quotesContr[index],
                autofocus: false,
                onSubmitted: (value) {
                  parPagesParse(index);
                },
                keyboardType: TextInputType.text,
              ),
              subtitle: Row(
                children: [saveButt(index), Obx(() => Text(parPages[index]))],
              ),
              trailing: Text(bl.dailyList.rows[index].parPageParse));
        });
  }

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
        body: filtersLv()

        //Row(children: [todayNews(false), todayNews(true)])

        );
  }
}
