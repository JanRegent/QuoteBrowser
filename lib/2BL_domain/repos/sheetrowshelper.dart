import 'package:flutter/foundation.dart';

class SheetRows {
  String rowkey = '';
  String sheetName = '';
  String quote = '';
  String author = '';
  String book = '';
  String parPage = '';
  String tags = '';
  String yellowParts = '';
  String stars = '';
  String favorite = '';
  String dateinsert = '';
  String sourceUrl = '';
  String fileUrl = '';
  String original = '';
  String vydal = '';
  String folderUrl = '';
  String title = '';

  SheetRows();

  Map<String, dynamic> toMap(String sheetName) {
    return {
      "rowkey": rowkey,
      "sheetname": sheetName,
      "quote": quote,
      "author": author,
      "book": book,
      "parPage": parPage,
      "tags": tags,
      "yellowParts": yellowParts,
      "stars": stars,
      "favorite": favorite,
      "dateinsert": dateinsert,
      "sourceUrl": sourceUrl,
      "fileUrl": fileUrl,
      "original": original,
      "vydal": vydal,
      "folderUrl": folderUrl,
      "title": title,
    };
  }

  Map<String, dynamic> toMapFromSup(Map rowmap) {
    return {
      "rowkey": rowmap['rowkey'],
      "sheetname": rowmap['sheetname'],
      "quote": rowmap['quote'],
      "author": rowmap['author'],
      "book": rowmap['book'],
      "parpage": rowmap['parpage'],
      "tags": rowmap['tags'],
      "yellowparts": rowmap['yellowparts'],
      "stars": rowmap['stars'],
      "favorite": rowmap['favorite'],
      "dateinsert": rowmap['dateinsert'],
      "sourceurl": rowmap['sourceurl'],
      "fileurl": rowmap['fileurl'],
      "original": rowmap['original'],
      "vydal": rowmap['vydal'],
      "folderurl": rowmap['folderurl'],
      "title": rowmap['title'],
    };
  }

  Map<String, dynamic> toMapSup(String sheetName) {
    return {
      "rowkey": rowkey,
      "sheetname": sheetName,
      "quote": quote,
      "author": author,
      "book": book,
      "parpage": parPage,
      "tags": tags,
      "yellowparts": yellowParts,
      "stars": stars,
      "favorite": favorite,
      "dateinsert": dateinsert,
      "sourceurl": sourceUrl,
      "fileurl": fileUrl,
      "original": original,
      "vydal": vydal,
      "folderurl": folderUrl,
      "title": title,
    };
  }

  SheetRows fromMap(var maprow) {
    SheetRows row = SheetRows();
    row.rowkey = maprow['rowkey'] ?? '';

    row.sheetName = maprow['sheetname'] ?? '';
    row.quote = maprow['quote'] ?? '';
    row.author = maprow['author'] ?? '';
    row.book = maprow['book'] ?? '';
    row.parPage = maprow['parpage'] ?? '';
    row.tags = maprow['tags'] ?? '';
    row.yellowParts = maprow['yellowparts'] ?? '';
    row.stars = maprow['stars'] ?? '';
    row.favorite = maprow['favorite'] ?? '';
    row.dateinsert = maprow['dateinsert'] ?? '';
    row.sourceUrl = maprow['sourceUrl'] ?? '';
    row.fileUrl = maprow['fileurl'] ?? '';
    row.original = maprow['original'] ?? '';
    row.vydal = maprow['vydal'] ?? '';
    row.folderUrl = maprow['folderurl'] ?? '';
    row.title = maprow['title'] ?? '';
    return row;
  }

  void toString_() {
    debugPrint(
        '''
      "rowkey":     $rowkey
      "sheetname":  $sheetName
      "author":     $author
      "book":       $book
      "parPage":    $parPage
      "tags":       $tags
      "yellowParts":$yellowParts
      "stars":      $stars
      "favorite":   $favorite
      "dateinsert": $dateinsert
      "sourceUrl":  $sourceUrl
      "fileUrl":    $fileUrl
      "original":   $original
      "vydal":      $vydal
      "folderUrl":  $folderUrl
      "title":      $title
            "quote":      $quote

    };
  }

    ''');
  }
}
