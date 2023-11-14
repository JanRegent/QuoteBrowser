import 'package:flutter/material.dart';
import 'package:searchable_listview/searchable_listview.dart';

class SearchMenu extends StatelessWidget {
  const SearchMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const Scaffold(
        body: SafeArea(
          child: ExampleApp(),
        ),
      ),
    );
  }
}

class ExampleApp extends StatefulWidget {
  const ExampleApp({Key? key}) : super(key: key);

  @override
  State<ExampleApp> createState() => _ExampleAppState();
}

class _ExampleAppState extends State<ExampleApp> {
  final List<Menurow> actors = [
    Menurow(tags: '', action: 'Leonardo', descr: 'DiCaprio'),
    Menurow(tags: '', action: 'Johnny', descr: 'Depp'),
    Menurow(tags: '', action: 'Robert', descr: 'De Niro'),
    Menurow(tags: '', action: 'Tom', descr: 'Hardy'),
    Menurow(tags: '', action: 'Denzel', descr: 'Washington'),
    Menurow(tags: '', action: 'Ben', descr: 'Affleck'),
  ];

  final Map<String, List<Menurow>> mapOfActors = {
    'First list': [
      Menurow(tags: '#', action: 'Leonardo1', descr: 'DiCaprio'),
      Menurow(tags: '#', action: 'Denzel', descr: 'Washington'),
      Menurow(tags: '#', action: 'Ben', descr: 'Affleck'),
    ],
    'Second list': [
      Menurow(tags: '#', action: 'Johnny2', descr: 'Depp'),
      Menurow(tags: '#', action: 'Robert', descr: 'De Niro'),
      Menurow(tags: '#', action: 'Tom', descr: 'Hardy'),
    ]
  };

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        children: [
          const Text('Searchable list with divider'),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: expansionSearchableList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget expansionSearchableList() {
    return SearchableList<Menurow>.expansion(
      expansionListData: mapOfActors,
      expansionTitleBuilder: (p0) {
        return Container(
          color: Colors.grey[300],
          width: MediaQuery.of(context).size.width * 0.8,
          height: 30,
          child: Center(
            child: Text(p0.toString()),
          ),
        );
      },
      filterExpansionData: (p0) {
        final filteredMap = {
          for (final entry in mapOfActors.entries)
            entry.key: (mapOfActors[entry.key] ?? [])
                .where((element) => element.action.contains(p0))
                .toList()
        };
        return filteredMap;
      },
      style: const TextStyle(fontSize: 25),
      expansionListBuilder: (int index) => ActorItem(actor: actors[index]),
      emptyWidget: const EmptyView(),
      inputDecoration: InputDecoration(
        labelText: "Search Actor",
        fillColor: Colors.white,
        focusedBorder: OutlineInputBorder(
          borderSide: const BorderSide(
            color: Colors.blue,
            width: 1.0,
          ),
          borderRadius: BorderRadius.circular(10.0),
        ),
      ),
    );
  }
}

class ActorItem extends StatelessWidget {
  final Menurow actor;

  const ActorItem({
    Key? key,
    required this.actor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            Icon(
              Icons.star,
              color: Colors.yellow[700],
            ),
            const SizedBox(
              width: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Action: ${actor.action}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Descr: ${actor.descr}',
                  style: const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Tags: ${actor.tags}',
                  style: const TextStyle(
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          Icons.error,
          color: Colors.red,
        ),
        Text('no actor is found with this name'),
      ],
    );
  }
}

class Menurow {
  String action;
  String descr;
  String tags;

  Menurow({
    required this.tags,
    required this.action,
    required this.descr,
  });
}
