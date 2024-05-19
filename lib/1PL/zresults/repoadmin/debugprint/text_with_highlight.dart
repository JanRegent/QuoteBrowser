// ignore_for_file: must_be_immutable

library text_with_highlight;

import 'package:flutter/material.dart';

///https://pub.dev/packages/text_with_highlight
class TextWithHighlight extends StatelessWidget {
  final String text;
  final List<String> highlightedTexts;

  TextWithHighlight(
      {super.key, required this.text, required this.highlightedTexts});

  @override
  Widget build(BuildContext context) {
    return Text.rich(
      textDirection: TextDirection.ltr,
      TextSpan(
        children: _buildTitleSpans(text, highlightedTexts),
      ),
      textAlign: TextAlign.left,
    );
  }

  TextStyle highlightedTextStyle = const TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    backgroundColor: Colors.yellow,
  );

  TextStyle textStyle = const TextStyle(
    fontWeight: FontWeight.normal,
    fontSize: 20,
    color: Colors.black,
  );

  List<TextSpan> _buildTitleSpans(String text, List<String> highlightedText) {
    final spans = <TextSpan>[];
    if (highlightedText.isEmpty) {
      spans.add(_buildTitleSpan(text, textStyle));
      return spans;
    }
    for (var i = 0; i < highlightedText.length; i++) {
      final splitText = text.split(highlightedText[i]);

      if (splitText.length == 1) {
        spans.add(_buildTitleSpan(
          text,
          textStyle,
        ));
      } else {
        spans.add(_buildTitleSpan(
          splitText[0],
          textStyle,
        ));
        spans.add(_buildTitleSpan(highlightedText[i], highlightedTextStyle));
        text = splitText[1];
      }
    }

    if (text.isNotEmpty) {
      spans.add(_buildTitleSpan(text, textStyle));
    }

    // If there's no highlighted text, just add the text
    if (highlightedText.isEmpty) {
      spans.add(_buildTitleSpan(text, textStyle));
    }

    return spans;
  }

  TextSpan _buildTitleSpan(String text, TextStyle textStyleIn) {
    return TextSpan(
      text: text,
      style: TextStyle(
          //fontWeight: textStyleIn.fontWeight,
          fontSize: textStyleIn.fontSize,
          backgroundColor: textStyleIn.backgroundColor),
    );
  }
}
