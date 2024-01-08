import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import '../../constants/route_names.dart';
import '../../constants/app_const.dart';
import '../../entities/contact.dart';
import 'contact_list_controller.dart';

class ContentView extends ConsumerWidget {
  const ContentView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactList = ref.watch(contactListControllerProvider);
    return Flexible(
      child: contactList.when(
          data: (data) => ContactListView(
                contactList: data,
              ),
          error: (e, __) => Text(e.toString()),
          loading: () => const Center(child: CircularProgressIndicator())),
    );
  }
}

class ContactListView extends ConsumerWidget {
  const ContactListView({Key? key, required this.contactList})
      : super(key: key);
  final List<Contact> contactList;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.separated(
      itemCount: contactList.length,
      itemBuilder: (context, position) {
        return Hero(
          tag: 'ListViewHero',
          child: ListTile(
            title: Text(
              '${contactList[position].name} ${contactList[position].surename}',
              style: AppConst.textStyleTitle,
            ),
            subtitle: Text(
              contactList[position].email,
              style: AppConst.textStyleGeneral,
            ),
            onTap: () {
              // ignore: deprecated_member_use
              ref.read(selectedContactProvider.state).state =
                  contactList[position];
              Navigator.pushNamed(context, RouteNames.detailPage,
                  arguments: contactList[position]);
            },
          ),
        );
      },
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(
          color: AppConst.kGray,
        );
      },
    );
  }
}
