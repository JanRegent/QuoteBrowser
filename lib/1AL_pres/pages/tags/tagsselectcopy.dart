import 'package:filter_list/filter_list.dart';
import 'package:flutter/material.dart';

class TagsSelectPage extends StatefulWidget {
  const TagsSelectPage({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _TagsSelectPageState createState() => _TagsSelectPageState();
}

class _TagsSelectPageState extends State<TagsSelectPage> {
  List<TagIndex>? selectedTagsList = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(bottom: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            TextButton(
              onPressed: () async {
                final list = await Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FilterPage(
                      allTextList: taqUniqList,
                      selectedUserList: selectedTagsList,
                    ),
                  ),
                );
                if (list != null) {
                  setState(() {
                    selectedTagsList = List.from(list);
                  });
                }
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "1. Select tags",
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
              onPressed: () {},
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.blue),
              ),
              child: const Text(
                "2. View",
                style: TextStyle(color: Colors.white),
              ),
              // color: Colors.blue,
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          if (selectedTagsList == null || selectedTagsList!.isEmpty)
            const Expanded(
              child: Center(
                child: Text('No tags selected'),
              ),
            )
          else
            Expanded(
              child: ListView.separated(
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(selectedTagsList![index].tag!),
                  );
                },
                separatorBuilder: (context, index) => const Divider(),
                itemCount: selectedTagsList!.length,
              ),
            ),
        ],
      ),
    );
  }
}

class FilterPage extends StatelessWidget {
  const FilterPage({Key? key, this.allTextList, this.selectedUserList})
      : super(key: key);
  final List<TagIndex>? allTextList;
  final List<TagIndex>? selectedUserList;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Filter tags Page"),
      ),
      body: SafeArea(
        child: FilterListWidget<TagIndex>(
          themeData: FilterListThemeData(context),
          hideSelectedTextCount: true,
          listData: taqUniqList,
          selectedListData: selectedUserList,
          onApplyButtonClick: (list) {
            Navigator.pop(context, list);
          },
          choiceChipLabel: (item) {
            /// Used to print text on chip
            return item!.tag;
          },
          // choiceChipBuilder: (context, item, isSelected) {
          //   return Container(
          //     padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          //     margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //     decoration: BoxDecoration(
          //         border: Border.all(
          //       color: isSelected! ? Colors.blue[300]! : Colors.grey[300]!,
          //     )),
          //     child: Text(item.name),
          //   );
          // },
          validateSelectedItem: (list, val) {
            ///  identify if item is selected or not
            return list!.contains(val);
          },
          onItemSearch: (user, query) {
            /// When search query change in search bar then this method will be called
            ///
            /// Check if items contains query
            return user.tag!.toLowerCase().contains(query.toLowerCase());
          },
        ),
      ),
    );
  }
}

class TagIndex {
  final String? tag;
  final String? sheetName;
  TagIndex({this.tag, this.sheetName});
}

/// Creating a global list for example purpose.
/// Generally it should be within data class or where ever you want
List<TagIndex> taqUniqList = [
  TagIndex(tag: "Abigail", sheetName: "user.png"),
  TagIndex(tag: "Audrey", sheetName: "user.png"),
  // TagIndex(tag: "Ava", sheetName: "user.png"),
  // TagIndex(tag: "Bella", sheetName: "user.png"),
  // TagIndex(tag: "Bernadette", sheetName: "user.png"),
  // TagIndex(tag: "Carol", sheetName: "user.png"),
  // TagIndex(tag: "Claire", sheetName: "user.png"),
  // TagIndex(tag: "Deirdre", sheetName: "user.png"),
  // TagIndex(tag: "Donna", sheetName: "user.png"),
  // TagIndex(tag: "Dorothy", sheetName: "user.png"),
  // TagIndex(tag: "Faith", sheetName: "user.png"),
  // TagIndex(tag: "Gabrielle", sheetName: "user.png"),
  // TagIndex(tag: "Grace", sheetName: "user.png"),
  // TagIndex(tag: "Hannah", sheetName: "user.png"),
  // TagIndex(tag: "Heather", sheetName: "user.png"),
  // TagIndex(tag: "Irene", sheetName: "user.png"),
  // TagIndex(tag: "Jan", sheetName: "user.png"),
  // TagIndex(tag: "Jane", sheetName: "user.png"),
  // TagIndex(tag: "Julia", sheetName: "user.png"),
  // TagIndex(tag: "Kylie", sheetName: "user.png"),
  // TagIndex(tag: "Lauren", sheetName: "user.png"),
  // TagIndex(tag: "Leah", sheetName: "user.png"),
  // TagIndex(tag: "Lisa", sheetName: "user.png"),
  // TagIndex(tag: "Melanie", sheetName: "user.png"),
  // TagIndex(tag: "Natalie", sheetName: "user.png"),
  // TagIndex(tag: "Olivia", sheetName: "user.png"),
  // TagIndex(tag: "Penelope", sheetName: "user.png"),
  // TagIndex(tag: "Rachel", sheetName: "user.png"),
  // TagIndex(tag: "Ruth", sheetName: "user.png"),
  // TagIndex(tag: "Sally", sheetName: "user.png"),
  // TagIndex(tag: "Samantha", sheetName: "user.png"),
  // TagIndex(tag: "Sarah", sheetName: "user.png"),
  // TagIndex(tag: "Theresa", sheetName: "user.png"),
  // TagIndex(tag: "Una", sheetName: "user.png"),
  // TagIndex(tag: "Vanessa", sheetName: "user.png"),
  // TagIndex(tag: "Victoria", sheetName: "user.png"),
  // TagIndex(tag: "Wanda", sheetName: "user.png"),
  // TagIndex(tag: "Wendy", sheetName: "user.png"),
  // TagIndex(tag: "Yvonne", sheetName: "user.png"),
  // TagIndex(tag: "Zoe", sheetName: "user.png"),
];
/// Another example of [FilterListWidget] to filter list of strings
/*
 FilterListWidget<String>(
    listData: [
      "One",
      "Two",
      "Three",
      "Four",
      "five",
      "Six",
      "Seven",
      "Eight",
      "Nine",
      "Ten"
    ],
    selectedListData: ["One", "Three", "Four", "Eight", "Nine"],
    onApplyButtonClick: (list) {
      Navigator.pop(context, list);
    },
    choiceChipLabel: (item) {
      /// Used to print text on chip
      return item;
    },
    validateSelectedItem: (list, val) {
      ///  identify if item is selected or not
      return list!.contains(val);
    },
    onItemSearch: (text, query) {
      return text.toLowerCase().contains(query.toLowerCase());
    },
  )
*/