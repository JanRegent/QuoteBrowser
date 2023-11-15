import 'package:flutter/material.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';

//import 'package:sheetviewer/uti/viewers/json_viewer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../BL/bluti.dart';

AL al = AL();

class AL {
  Future<void> openhUrl(Uri url, BuildContext context) async {
    await canLaunchUrl(url)
        ? await launchUrl(url)
        // ignore: use_build_context_synchronously
        : messageBottom(context, 'could_not_launch_this_url\n $url');
  }

  Widget linkIconOpenDoc(String fileid, BuildContext context, String label) {
    if (fileid.startsWith('http')) fileid = blUti.url2fileid(fileid);
    // ignore: unnecessary_null_comparison
    if (fileid.trim() == null) return const Text(' ');
    if (fileid.trim().isEmpty) return const Text(' ');
    return ElevatedButton.icon(
      icon: const Icon(Icons.link),
      label: Text(label),
      // color: Colors.black,
      //tooltip: 'Open sheet in browser',
      onPressed: () async {
        if (fileid.trim().isEmpty) return;
        String url = 'https://docs.google.com/spreadsheets/d/$fileid';
        await openhUrl(Uri.parse(url), context);
      },
    );
  }

  Future openDoc(String fileid, BuildContext context, String label) async {
    try {
      if (fileid.startsWith('http')) fileid = blUti.url2fileid(fileid);
      // ignore: unnecessary_null_comparison
      if (fileid.trim() == null) return;
      if (fileid.trim().isEmpty) return;

      if (fileid.trim().isEmpty) return;
      String url = 'https://docs.google.com/spreadsheets/d/$fileid';
      await openhUrl(Uri.parse(url), context);
    } catch (_) {}
  }

  Widget linkIconOpenUrlNoDoc(String url, BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (url.trim() == null) return const Text(' ');
    if (url.trim().isEmpty) return const Text(' ');
    return ElevatedButton.icon(
      icon: const Icon(Icons.link),
      label: const Text(''),
      onPressed: () async {
        await openhUrl(Uri.parse(url), context);
      },
    );
  }

  ElevatedButton iconBack(BuildContext context) {
    return ElevatedButton(
      child: const Icon(Icons.arrow_back),
      onPressed: () {
        Navigator.pop(context);
      },
      onLongPress: () async {
        iconBackDialog(context);
      },
    );
  }

  ElevatedButton helpIcon(BuildContext context) {
    return ElevatedButton(
      child: const Icon(Icons.help),
      onPressed: () async {},
      onLongPress: () async {},
    );
  }

  iconBackDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: const Text("Cancel"),
      onPressed: () {
        Navigator.pop(context, "Cancel");
      },
    );
    Widget filesetsMenuButton = TextButton(
      child: const Text("Filesets menu"),
      onPressed: () async {
        Navigator.pop(context, "menu");
      },
    );
    Widget thisFilesetButton = TextButton(
      child: const Text("Home of "),
      onPressed: () async {
        Navigator.pop(context, "home");
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: const Text("Skip to.."),
        content: Column(
          children: [
            cancelButton,
            const Text(' '),
            const Text(' '),
            filesetsMenuButton,
            const Text(' '),
            thisFilesetButton,
          ],
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    ).then((exit) async {
      switch (exit) {
        case 'Cancel':
          return;
        case 'menu':
          // await Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => FilesetsMenuPage()),
          // );
          break;
        case 'home':
          // await Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => FilesetPage()),
          // );
          break;
        default:
          return;
      }
    });
  }

  //-----------------------------------------------------------------info/alerts

  Future<BuildContext> infoLoading2(BuildContext context, String descr) async {
    // ignore: unused_local_variable
    BuildContext dialogContext = context;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        dialogContext = context;
        return const Dialog(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(),
              Text("Loading"),
            ],
          ),
        );
      },
    );
    return dialogContext;
  }

  // Future infoLoading(BuildContext context, String descr) async {
  //   await showDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return SimpleDialog(
  //         title: Text(descr),
  //         children: [
  //           Container(
  //               color: Colors.lightBlue,
  //               child: Center(
  //                 child: LoadingAnimationWidget.staggeredDotsWave(
  //                   color: Colors.white,
  //                   size: 200,
  //                 ),
  //               ))
  //         ],
  //       );
  //     },
  //   );
  //   // QuickAlert.show(
  //   //   context: context,
  //   //   type: QuickAlertType.loading,
  //   //   title: 'Loading',
  //   //   text: 'Fetching data',
  //   // );
  // }

  // Future infoLoadingQ(BuildContext context) async {
  //   QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.loading,
  //     title: 'Loading',
  //     text: 'Fetching data',
  //   );
  // }

  // Future infoSnack(BuildContext context, String mess) async {
  //   await QuickAlert.show(
  //     context: context,
  //     type: QuickAlertType.error,
  //     text: 'Please input something',
  //   );
  // }

  void messageBottom(context, String text) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    final snackBar = SnackBar(
      content: Text(text),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void messageInfo(
      BuildContext context, String title, String mess, int seconds) async {
    final snackBar = SnackBar(
      elevation: 0,
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: SizedBox(
          height: 400,
          width: 400,
          child: Column(
            children: [
              // const CircularProgressIndicator(
              //   color: Colors.red,
              // ),
              AwesomeSnackbarContent(
                title: title,
                titleFontSize: 20,
                message: mess,
                messageFontSize: 25,
                contentType: ContentType.success,
              ),
              Text(
                mess,
                style: const TextStyle(fontSize: 15, color: Colors.black),
              ),
            ],
          )),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  void messageLoading(
      BuildContext context, String title, String mess, int seconds) async {
    final snackBar = SnackBar(
      elevation: 0,
      duration: Duration(seconds: seconds),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      content: SizedBox(
          height: 500,
          child: Column(
            children: [
              // const CircularProgressIndicator(
              //   color: Colors.red,
              // ),
              AwesomeSnackbarContent(
                title: title,
                titleFontSize: 20,
                message: mess,
                messageFontSize: 25,
                contentType: ContentType.help,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: const SizedBox(
                  height: 10,
                  width: 300,
                  child: CircularProgressIndicator(
                    backgroundColor: Colors.lime,
                    color: Colors.red,
                  ),
                ),
              )
            ],
          )),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }
}
