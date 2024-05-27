import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';
import '../../../2BL_domain/repos/supabase/w5filtersrepo.dart';

class AuthorBooksUI {
  VoidCallback setStateW5;
  AuthorBooksUI(this.setStateW5);

  ListTile authorListTile(BuildContext context) {
    return ListTile(
        leading: IconButton(
          onPressed: () {
            wfilterMap['author'] = '';
            setStateW5();
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
        wfilterMap['book'] = '';
        books = bl.authorBooksMap.authorBooksGet(wfilterMap['author']!);
        books.insert(0, '');
        setStateW5();
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
            setStateW5();
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
        setStateW5();
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
}
