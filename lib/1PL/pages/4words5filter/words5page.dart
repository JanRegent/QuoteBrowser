import 'package:flutter/material.dart';
import 'package:flutter_resizable_container/flutter_resizable_container.dart';

import '../../../2BL_domain/repos/supabase/w5filtersrepo.dart';
import 'lpanel/_lpanel.dart';
import 'lpanel/authorsbooksui.dart';
import 'lpanel/starsfavui.dart';
import 'rpanel/rpanelwfilterlv.dart';

class Words5Page extends StatefulWidget {
  const Words5Page({super.key});

  @override
  Words5PageState createState() => Words5PageState();
}

class Words5PageState extends State<Words5Page> {
  @override
  void initState() {
    super.initState();

    authorBooksUI = AuthorBooksUI(setstateW5);
    starsFavoriteUI = StarsFavoriteUI(setstateW5);
  }

  @override
  void dispose() {
    super.dispose();
  }

  void setstateW5() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ResizableContainer(
      direction: Axis.horizontal,
      divider: ResizableDivider(
        color: Theme.of(context).colorScheme.primary,
        thickness: 2,
        size: 14,
      ),
      children: [
        ResizableChild(
          size: ResizableSize.ratio(leftRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.primaryContainer,
            child: lpanelListview(context, setstateW5),
          ),
        ),
        ResizableChild(
          size: ResizableSize.ratio(rightRatio),
          child: ColoredBox(
            color: Theme.of(context).colorScheme.tertiaryContainer,
            child: RpanelWfilterLv(w5Cont, setstateW5),
          ),
        ),
      ],
    ));
  }
}
