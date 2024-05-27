import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_stars/flutter_rating_stars.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';
import 'package:quotebrowser/1PL/widgets/alib/alicons.dart';

import '../../../2BL_domain/bl.dart';
import '../../widgets/alib/alib.dart';
import '../../zresults/repoadmin/resultbuilder/qresultbuilder.dart';
import '../../zresults/swiperbrowser/_swiper.dart';
import 'w5listviewpanel.dart';
import 'wfilterbl.dart';

class Words5Page extends StatefulWidget {
  const Words5Page({super.key});

  @override
  Words5PageState createState() => Words5PageState();
}

class Words5PageState extends State<Words5Page> {
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
      wfilterMap['w$wordIndex'] = '';
      w5Cont[wordIndex].text = '';
      setState(() {});
    }
  }

  //------------------------------------------------------------/authors

  ListTile authorListTile(BuildContext context) {
    return ListTile(
        leading: IconButton(
          onPressed: () {
            wfilterMap['author'] = '';
            setState(() {});
          },
          icon: const Icon(Icons.clear),
        ),
        title: authorsDropdownButton2(context));
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
      value: wfilterMap['author'],
      onChanged: (String? value) {
        wfilterMap['author'] = value;
        books = bl.authorBooksMap.authorBooksGet(wfilterMap['author']!);
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

  List<String> books = [''];
  ListTile bookListTile(BuildContext context) {
    return ListTile(
        leading: IconButton(
          onPressed: () {
            wfilterMap['book'] = '';
            setState(() {});
          },
          icon: const Icon(Icons.clear),
        ),
        title: bookDropdownButton2(context));
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
      value: wfilterMap['book'],
      onChanged: (String? value) {
        wfilterMap['book'] = value;
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
            wfilterMap['stars'] = 0.0;
          });
        },
        icon: const Icon(Icons.clear),
      ),
      title: ratingStars(),
    );
  }

  Row ratingStars() {
    return Row(
      children: [
        RatingStars(
          value: wfilterMap['stars'],
          onValueChanged: (value) {
            setState(() {
              wfilterMap['stars'] = value;
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

  ListTile favListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          wfilterMap['favorite'] = '';
          setState(() {});
        },
        icon: const Icon(Icons.clear),
      ),
      title: Row(
        children: [favButt()],
      ),
    );
  }

  Widget favButt() {
    Icon favIcon = const Icon(Icons.favorite_outline);

    if (wfilterMap['favorite'] == 'f') {
      favIcon = const Icon(Icons.favorite);
    } else {
      favIcon = const Icon(Icons.favorite_outline);
    }
    return IconButton(
        icon: favIcon,
        onPressed: () async {
          if (wfilterMap['favorite'].isEmpty) {
            wfilterMap['favorite'] = 'f';
          } else {
            wfilterMap['favorite'] = '';
          }
          setState(() {});
        });
  }

  //------------------------------------------------------------w5
  TextField tagsTextfield(wordIndex) {
    return TextField(
      controller: w5Cont[wordIndex],
      onChanged: (value) {
        wfilterMap['w$wordIndex'] = value;
      },
      decoration: InputDecoration(
        hintText: 'Enter word $wordIndex',
        prefixIcon: IconButton(
          onPressed: () => searchClean(wordIndex),
          icon: const Icon(Icons.clear),
        ),
      ),
    );
  }

  Future w5querySwipper() async {
    String word = w5Cont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    bl.currentSS.keys =
        await bl.supRepo.readSup.readW5.w5queryTextSearchKeys(wfilterMap);

    String info = wfilterMap.toString();
    bl.homeTitle.value = '';
    // ignore: use_build_context_synchronously
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => CardSwiper(info, '', const {})),
    );
  }

  Future w5queryGrid() async {
    String word = w5Cont[1].text;
    if (word.isEmpty) {
      al.messageInfo(context, 'Get by word', 'write somme word', 5);
      return;
    }
    bl.homeTitle.value = 'Search w5 ';

    List rows =
        await bl.supRepo.readSup.readW5.w5queryTextSearchRows(wfilterMap);
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
          print(wfilterMap);
          bl.wfiltersRepo.insert(wfilterMap);
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
  double leftRatio = 0.25;
  double rightRatio = 0.75;

  ListView bodyListview() {
    return ListView(
      children: [
        ListTile(
            leading: IconButton(
              icon: const Icon(Icons.clear_all_rounded),
              onPressed: () => wfilterMapClearAll(),
            ),
            trailing: TextButton(
                onPressed: () {
                  leftRatio = leftRatio + 0.5;
                  if (leftRatio >= 1) leftRatio = 0.25;
                  rightRatio = 1 - leftRatio;
                  setState(() {});
                },
                child: Text(leftRatio == 0.25 ? '>>' : '<<',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 30,
                        backgroundColor: Color.fromARGB(255, 186, 215, 239))))),
        tagsTextfield(1),
        tagsTextfield(2),
        tagsTextfield(3),
        tagsTextfield(4),
        tagsTextfield(5),
        Card(
          color: Colors.lightBlue,
          child: Column(children: [
            authorListTile(context),
            bookListTile(context),
          ]),
        ),
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

  bool hovered = false;
  ResizableController resizableController = ResizableController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResizableContainer(
      controller: resizableController,
      direction: Axis.horizontal,
      divider: ResizableDivider(
        color: hovered
            ? Theme.of(context).colorScheme.primary
            : Theme.of(context).colorScheme.inversePrimary,
        thickness: 2,
        size: 14,
      ),
      children: [
        ResizableChild(
          size: ResizableSize.ratio(leftRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: bodyListview(),
          ),
        ),
        ResizableChild(
          size: ResizableSize.ratio(rightRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: W5ListviewPanel(w5Cont),
          ),
        ),
      ],
    ));
  }
}
