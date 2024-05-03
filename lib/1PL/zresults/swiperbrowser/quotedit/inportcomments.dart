import 'package:flutter/material.dart';
import 'package:flutter_linkify/flutter_linkify.dart';
import 'package:get/get.dart';
import 'package:quotebrowser/3Data/dl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../2BL_domain/bl.dart';
import '../../../../2BL_domain/orm.dart';
import '../../../widgets/alib/alib.dart';

Future importComments(BuildContext context) async {
  String rownoKey =
      '${bl.orm.currentRow.sheetName.value}__|__${bl.orm.currentRow.rowNo}';
  al.showTopSnackBar(context, 'Importing comments at \n\n$rownoKey', 15);

  await dl.gservice23.comments2tagsYellowparts(rownoKey);
  //iporttSupUpsert
  await currentRowSet(rownoKey);
  // ignore: use_build_context_synchronously
  al.showTopSnackBar(context, 'Import done at \n\n$rownoKey', 3);
}

Future<void> onOpen(String url) async {
  LinkableElement link = LinkableElement('Link in text', url);
  if (!await launchUrl(Uri.parse(link.url))) {
    //ebugPrint('_onOpen--Could not launch ${link.url}');
  }
}

ListView toReadListview(BuildContext context, VoidCallback setStateSwiper) {
  return ListView(
    children: [
      const Text('__toRead__'),
      TextButton(
          child: Row(
            children: [Obx(() => Text(bl.orm.currentRow.fileUrl.value))],
          ),
          onPressed: () => onOpen(bl.orm.currentRow.fileUrl.value)),
      TextButton(
          onPressed: () {
            importComments(context);
            setStateSwiper();
          },
          child: const Text('import'))
    ],
  );
}
