// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:dartx/dartx.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../1PL/pages/2books/bookslist.dart';
import 'repos/authbooksmap.dart';
import 'repos/dailylist.dart';

import 'bluti.dart';

import 'orm.dart';
import 'repos/sheetrowshelper.dart';
import 'usecases/keys4swiper/_preparekeys.dart';

Bl bl = Bl();

class Bl {
  bool devMode = false;
  bool userViewMode = true;
  bool highligthOnOff = false;

  Color saveHeadColor = Colors.lightBlue;

  DailyList dailyList = DailyList();
  BooksList bookList = BooksList();

  //RxString filteredSheetName = ''.obs;
  RxMap lastCount = {}.obs;
  RxMap booksCount = {}.obs;
  RxString homeTitle = ''.obs;

  Orm orm = Orm();
  SheetRowsHelper sheetRowsHelper = SheetRowsHelper();

  PrepareKeys prepareKeys = PrepareKeys();

  Future init() async {
    await sheetRowsHelper.initDB();

    devModeSet();
  }

  List<String> authors = [];
  Set authorsSet = {};
  AuthorBooksMap authorBooksMap = AuthorBooksMap();
  void updateSlowly() async {
    authors = [];
    authors.addAll(blUti.toListString(authorsSet.toList().sorted()));
    authorBooksMap.getData();
  }

  void devModeSet() {
    //flutter run -d chrome --web-renderer html --dart-define=devmode=1
    try {
      String devModeStr =
          const String.fromEnvironment('devmode', defaultValue: '');
      if (devModeStr == '1') devMode = true;
    } catch (_) {}
  }
}

//----------------------------------------------------------isar

