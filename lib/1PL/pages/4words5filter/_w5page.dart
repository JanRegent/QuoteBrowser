import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:quotebrowser/1PL/widgets/alib/alicons.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../zresults/swiperbrowser/_swiper.dart';
import 'w5listviewpanel.dart';

class Words5Page extends StatefulWidget {
  const Words5Page({super.key});

  @override
  Words5PageState createState() => Words5PageState();
}

class Words5PageState extends State<Words5Page> {
  bool isSelectionMode = false;
  final int listLength = 3;

  List<TextEditingController> txCont = [
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
      txCont[wordIndex].clear;
      txCont[wordIndex].text = '';
      setState(() {});
    }
  }

  //------------------------------------------------------------/authors
  String? selectedValueAuthor = '';

  ListTile authorListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          selectedValueAuthor = '';
          setState(() {});
        },
        icon: const Icon(Icons.clear),
      ),
      title: authorsDropdownButton2(context),
      tileColor: const Color.fromARGB(255, 135, 206, 239),
    );
  }

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
      items: bl.authorBooksMap.authors
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
        selectedValueAuthor = value;
        books = bl.authorBooksMap.authorBooksGet(selectedValueAuthor!);
        books.insert(0, '');
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

  //------------------------------------------------------------/authors
  String? selectedValueBook = '';
  List<String> books = [''];
  ListTile bookListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          selectedValueBook = '';
          setState(() {});
        },
        icon: const Icon(Icons.clear),
      ),
      title: bookDropdownButton2(context),
      tileColor: const Color.fromARGB(255, 135, 206, 239),
    );
  }

  DropdownButton2 bookDropdownButton2(BuildContext context) {
    return DropdownButton2<String>(
      isExpanded: true,
      hint: Text(
        'Book?',
        style: TextStyle(
          fontSize: 14,
          color: Theme.of(context).hintColor,
        ),
      ),
      items: books
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
      value: selectedValueBook,
      onChanged: (String? value) {
        selectedValueBook = value;
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

  //-------------------------------------------------------------stars/favorite
  String? selectedValueStars = '';
  ListTile starsListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          setState(() {
            starrsValue = 0;
          });
        },
        icon: const Icon(Icons.clear),
      ),
      title: ratingStars(),
    );
  }

  double starrsValue = 0;

  Row ratingStars() {
    return Row(
      children: [
        RatingStars(
          value: starrsValue,
          onValueChanged: (v) {
            setState(() {
              starrsValue = v;
              //starsValueInsert();
            });
          },
          starBuilder: (index, color) => Icon(
            Icons.ac_unit_outlined,
            color: color,
          ),
          starCount: 5,
          starSize: 20,
          valueLabelColor: const Color(0xff9b9b9b),
          valueLabelTextStyle: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 12.0),
          valueLabelRadius: 10,
          maxValue: 5,
          starSpacing: 2,
          maxValueVisibility: true,
          valueLabelVisibility: false,
          animationDuration: const Duration(milliseconds: 100),
          valueLabelPadding:
              const EdgeInsets.symmetric(vertical: 1, horizontal: 8),
          valueLabelMargin: const EdgeInsets.only(right: 8),
          starOffColor: const Color(0xffe7e8ea),
          starColor: Colors.yellow,
        ),
      ],
    );
  }

  String? selectedValueFav = '';
  ListTile favListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          favValue = '';
          setState(() {});
        },
        icon: const Icon(Icons.clear),
      ),
      title: Row(
        children: [favButt()],
      ),
    );
  }

  String favValue = '';
  Widget favButt() {
    Icon favIcon = const Icon(Icons.favorite_outline);

    if (favValue == 'f') {
      favIcon = const Icon(Icons.favorite);
    } else {
      favIcon = const Icon(Icons.favorite_outline);
    }
    return IconButton(
        icon: favIcon,
        onPressed: () async {
          if (favValue.isEmpty) {
            favValue = 'f';
          } else {
            favValue = '';
          }
          setState(() {});
        });
  }

  //--------------------------------------------------------
  bool loading = false;
  List<String> words = ['allscope', '', '', '', '', ''];

  //------------------------------------------------------------w5
  TextField tagsTextfield(wordIndex) {
    return TextField(
      controller: txCont[wordIndex],
      decoration: InputDecoration(
        hintText: 'Enter word $wordIndex',
        prefixIcon: IconButton(
          onPressed: () => searchClean(wordIndex),
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  Map wFilterMapGet() {
    Map wfilterMap = {
      'filtertype': 'w5',
      'w1': txCont[1].text,
      'w2': txCont[2].text,
      'w3': txCont[3].text,
      'w4': txCont[4].text,
      'w5': txCont[5].text,
      'author': selectedValueAuthor
    };
    return wfilterMap;
  }

  Future w5querySwipper() async {
    String word = txCont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    bl.currentSS.keys =
        await bl.supRepo.readSup.readW5.w5queryTextSearchKeys(wFilterMapGet());

    String info = wFilterMapGet().toString();
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(info, '', const {})),
    );
  }

  Future w5queryGrid() async {
    String word = txCont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    List rows =
        await bl.supRepo.readSup.readW5.w5queryTextSearchRows(wFilterMapGet());
    bl.homeTitle.value = '';
    await showInGrid(rows);
  }

  Future showInGrid(List rows) async {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QResultBuilder(rows)),
    );
  }

  IconButton search52swip() {
    return IconButton(
        onPressed: () async => await w5querySwipper(),
        icon: const Icon(Icons.search));
  }

  IconButton filterSave() {
    return IconButton(
        onPressed: () async {
          bl.wfiltersRepo.insert(wFilterMapGet());
          setState(() {});
        },
        icon: const Icon(Icons.save));
  }

  IconButton search52grid() {
    return IconButton(
        onPressed: () async => await w5queryGrid(),
        icon: ALicons.viewIcons.gridView);
  }

  //-----------------------------------------------------------body
  ListView bodyListview() {
    return ListView(
      children: [
        const Divider(color: Colors.blue, height: 10, thickness: 5),
        tagsTextfield(1),
        tagsTextfield(2),
        tagsTextfield(3),
        tagsTextfield(4),
        tagsTextfield(5),
        authorListTile(context),
        bookListTile(context),
        starsListTile(context),
        favListTile(context),
        const Divider(color: Colors.blue, height: 10, thickness: 5),
        Row(children: [
          search52grid(),
          const Spacer(),
          filterSave(),
          const Spacer(),
          search52swip()
        ])
      ],
    );
  }

  final int paneProportion = 30;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: !loading
            ? Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                    flex: 30,
                    child: bodyListview(),
                  ),
                  Flexible(
                    flex: 70,
                    child: W5ListviewPanel(txCont),
                  ),
                ],
              )
            : const Row(
                children: [
                  CircularProgressIndicator(),
                  Text('waiting results from cloud')
                ],
              ));
  }
}
