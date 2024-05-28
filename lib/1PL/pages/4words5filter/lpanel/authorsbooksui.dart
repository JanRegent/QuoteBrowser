import 'package:flutter/material.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../controllers/selectvalue.dart';
import '../../../widgets/alib/alicons.dart';

class AuthorBooksUI {
  VoidCallback setStateW5;
  AuthorBooksUI(this.setStateW5);

  ListTile authorListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          bl.wfiltersRepo.wfilterMap['author'] = '';
          setStateW5();
        },
        icon: const Icon(Icons.clear),
      ),
      title: Text(bl.wfiltersRepo.wfilterMap['author']),
      trailing: IconButton(
          icon: ALicons.attrIcons.authorIcon,
          onPressed: () async {
            String authorSelected = await authorSelect();
            if (authorSelected.isEmpty) return;
            bl.wfiltersRepo.wfilterMap['author'] = authorSelected;
            setStateW5();
          }),
    );
  }

  //------------------------------------------------------------/book

  List<String> books = [''];
  ListTile bookListTile(BuildContext context) {
    return ListTile(
      leading: IconButton(
        onPressed: () {
          bl.wfiltersRepo.wfilterMap['book'] = '';
          setStateW5();
        },
        icon: const Icon(Icons.clear),
      ),
      title: Text(bl.wfiltersRepo.wfilterMap['book']),
      trailing: IconButton(
          icon: ALicons.attrIcons.bookIcon,
          onPressed: () async {
            String bookSelected =
                await bookSelect(context, bl.wfiltersRepo.wfilterMap['author']);
            if (bookSelected.isEmpty) return;
            bl.wfiltersRepo.wfilterMap['book'] = bookSelected;
            setStateW5();
          }),
    );
  }
}
