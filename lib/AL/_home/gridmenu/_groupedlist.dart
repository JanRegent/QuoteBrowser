import 'package:flutter/material.dart';
import 'package:grouped_list/grouped_list.dart';

List _elements = [
  {'name': 'advaitaDaily', 'group': '1 sheetGroup'},
  {'name': 'krestanstviDaily', 'group': '1 sheetGroup'},
  {'name': 'John', 'group': '2 Last'},
  {'name': 'Beth', 'group': '2 Last'},
  {'name': 'Will', 'group': '3 Simple filters'},
  {'name': 'Miranda', 'group': '3 Simple filters'},
  {'name': 'Mike', 'group': '4 Authors|Books & words'},
  {'name': 'Danny', 'group': '4 Authors|Books & words'},
  {'name': 'Danny', 'group': '5 Add quote'},
];

class GroupedListMenu extends StatelessWidget {
  const GroupedListMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: GroupedListView<dynamic, String>(
          elements: _elements,
          groupBy: (element) => element['group'],
          groupComparator: (value1, value2) => value2.compareTo(value1),
          itemComparator: (item1, item2) =>
              item1['name'].compareTo(item2['name']),
          order: GroupedListOrder.DESC,
          floatingHeader: true,
          useStickyGroupSeparators: true,
          groupSeparatorBuilder: (String value) => Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
          ),
          itemBuilder: (c, element) {
            return Card(
              elevation: 8.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 10.0, vertical: 6.0),
              child: SizedBox(
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 20.0, vertical: 10.0),
                  leading: const Icon(Icons.account_circle),
                  title: Text(element['name']),
                  trailing: const Icon(Icons.arrow_forward),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
