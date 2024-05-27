import 'package:flutter/material.dart';

Map wfilterMap = {
  'filtertype': 'w5',
  'w1': '',
  'w2': '',
  'w3': '',
  'w4': '',
  'w5': '',
  'author': '',
  'book': '',
  'stars': 0.0,
  'starsany': '',
  'favorite': '',
};

void wfilterMapClearAll() {
  for (var key in wfilterMap.keys) {
    wfilterMap[key] = '';
  }
  wfilterMap['stars'] = 0.0;
  wfilterMap['filtertype'] = 'w5';
}

List<TextEditingController> w5Cont = [
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController(),
  TextEditingController()
];
