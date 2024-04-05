import 'package:flutter/material.dart';

class StyleableTextFieldController extends TextEditingController {
  StyleableTextFieldController({
    required this.styles,
  }) : combinedPattern = styles.createCombinedPatternBasedOnStyleMap();

  final TextPartStyleDefinitions styles;
  final Pattern combinedPattern;
}

class TextPartStyleDefinitions {
  TextPartStyleDefinitions({required this.definitionList});

  final List<TextPartStyleDefinition> definitionList;

  RegExp createCombinedPatternBasedOnStyleMap() {
    final String combinedPatternString = definitionList
        .map<String>(
          (TextPartStyleDefinition textPartStyleDefinition) =>
              textPartStyleDefinition.pattern,
        )
        .join('|');

    return RegExp(
      combinedPatternString,
      multiLine: true,
      caseSensitive: false,
    );
  }
}

class TextPartStyleDefinition {
  TextPartStyleDefinition({
    required this.pattern,
    required this.style,
  });

  final String pattern;
  final TextStyle style;
}
