import 'package:fluentui_system_icons/fluentui_system_icons.dart';

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
    return const Icon(Icons.table_bar);
  }

  Icon get listView {
    return const Icon(Icons.list);
  }
}

class AttrIcons {
  Icon get tagIcon {
    return const Icon(Icons.tag);
  }

  Icon get bookIcon {
    return const Icon(FluentIcons.book_24_regular);
  }

  Icon get parPageIcon {
    return const Icon(Icons.pages);
  }

  Icon get authorIcon {
    return const Icon(Icons.person);
  }

  Icon get categoryIcon {
    return const Icon(Icons.category);
  }

  Icon get sheetIcon {
    return const Icon(FluentIcons.table_20_regular);
  }

  Icon get listIcon {
    return const Icon(FluentIcons.list_24_regular);
  }
}
