import 'package:flutter/material.dart';
import 'package:get/get.dart';

void emptyDialog(String warning, BuildContext context) async {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text("Warning"),
        content: Text(warning),
        actions: [
          TextButton(
            child: const Text("OK"),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

String noYes(String warning) {
  String result = 'no';
  Get.defaultDialog(
      title: "Welcome to Flutter Dev'S",
      middleText:
          "FlutterDevs is a protruding flutter app development company with "
          "an extensive in-house team of 30+ seasoned professionals who know "
          "exactly what you need to strengthen your business across various dimensions",
      backgroundColor: Colors.teal,
      titleStyle: const TextStyle(color: Colors.white),
      middleTextStyle: const TextStyle(color: Colors.white),
      radius: 30);
  // Get.dialog(await showDialog(
  //   context: navigatorKey.currentContext!,
  //   builder: (BuildContext context) {
  //     return AlertDialog(
  //       title: const Text("Warning"),
  //       content: Text(warning),
  //       actions: [
  //         IconButton(
  //           icon: const Icon(Icons.cancel),
  //           onPressed: () {
  //             result = 'no';
  //             Navigator.of(context).pop('no');
  //           },
  //         ),
  //         IconButton(
  //           icon: const Icon(Icons.check),
  //           onPressed: () {
  //             result = 'yes';
  //             Navigator.of(context).pop('yes');
  //           },
  //         ),
  //       ],
  //     );
  //   },
  // ));
  return result;
}

// void showMyDialog() {
//   showDialog(
//     context: navigatorKey.currentContext,
//     builder: (context) => Center(
//       child: Material(
//         color: Colors.transparent,
//         child: Text('Hello'),
//       ),
//     )
//   );
// }