import 'package:flutter/material.dart';

import '../aedit/fieldpopup.dart';
import 'tagsyellowlist.dart';

PopupMenuButton coloredPopupMenuButton(String fieldValue) {
  return PopupMenuButton(
    itemBuilder: (BuildContext context) {
      return [
        copyPopupMenuItem(fieldValue),
        PopupMenuItem(
          value: '/tagsList',
          child: IconButton(
            icon: const Icon(Icons.tag, color: Colors.black),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TagsYelowPage('tags')),
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
        ),
        PopupMenuItem(
          value: '/yellowpartsList',
          child: IconButton(
            icon: const Icon(Icons.circle, color: Colors.yellow),
            onPressed: () async {
              await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TagsYelowPage('yellowparts')),
              );
              // ignore: use_build_context_synchronously
              Navigator.pop(context);
            },
          ),
        )
      ];
    },
  );
}
