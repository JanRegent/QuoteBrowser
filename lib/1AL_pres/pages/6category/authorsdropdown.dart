import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../../2BL_domain/bl.dart';

String? selectedValueAuthor;

DropdownButton2 authorsDropdownButton2(BuildContext context) {
  return DropdownButton2<String>(
    isExpanded: true,
    hint: Text(
      'Author',
      style: TextStyle(
        fontSize: 14,
        color: Theme.of(context).hintColor,
      ),
    ),
    items: bl.authors
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
