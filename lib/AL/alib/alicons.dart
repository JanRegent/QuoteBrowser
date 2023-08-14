import 'package:flutter/cupertino.dart';

import 'package:flutter/material.dart';

class ALicons {
  static AttrIcons attrIcons = AttrIcons();
  static EditIcons editIcons = EditIcons();
  static ViewIcons viewIcons = ViewIcons();
}

class EditIcons {
  Icon get undo {
    return const Icon(Icons.undo);
  }
}

class ViewIcons {
  Icon get tableView {
    return const Icon(CupertinoIcons.table);
  }

  Icon get listView {
    return const Icon(CupertinoIcons.list_bullet);
  }
}

class AttrIcons {
  Icon get tag {
    return const Icon(CupertinoIcons.tag);
  }

  Icon get book {
    return const Icon(CupertinoIcons.book);
  }

  Icon get author {
    return const Icon(CupertinoIcons.person);
  }

  Icon get category {
    return const Icon(Icons.category);
  }
}
