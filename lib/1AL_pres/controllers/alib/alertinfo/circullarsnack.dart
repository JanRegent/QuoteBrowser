import 'package:flutter/material.dart';

void circularSnack(BuildContext context, int seconds, String msg) async {
  ScaffoldMessenger.of(context).showSnackBar(_circularSnack(seconds, msg));
}

SnackBar _circularSnack(int seconds, String msg) {
  return SnackBar(
      duration: Duration(seconds: seconds),
      content: Row(
        children: [
          Text(msg),
          const Text('  '),
          const CircularProgressIndicator()
        ],
      ));
}
