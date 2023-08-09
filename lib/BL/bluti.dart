// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'package:dartx/dartx.dart';

BLuti blUti = BLuti();

class BLuti {
  String url2fileid(String url) {
    try {
      if (!url.startsWith('https://docs.')) return url;
      String fileid =
          url.replaceFirst('https://docs.google.com/spreadsheets/d/', '');
      fileid = fileid.substring(0, fileid.indexOf('/'));
      // ignore: unnecessary_null_comparison
      if (fileid == null) return '';
      return fileid;
    } catch (_) {
      return '';
    }
  }

  String transl(String key) {
    if (key == 'Loading') return 'Načítání';
    if (key == 'Last5 rows') return 'Posledních 5 řádků';

    return key;
  }

  //--------------------------------------------------------dartX
  //https://pub.dev/packages/dartx
  //dartx by Simon Leier
  bool isBlankOrEmpty(String str) {
    return str.isNullOrEmpty;
  }

  String Function() capitalize(String str) {
    return str.capitalize;
  }

  //---------------------------------------------------------string clean
  String removeNonASCII(String str) {
    return str.replaceAll(RegExp(r'[^\x20-\x7E]'), '');
  }

  String removeHTMLtags(String html) {
    RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

    String parsedhtml = html.replaceAll(exp, ' ');
    return parsedhtml; //output with space
    //return html.replaceAll(exp, ''); //output without space

    //https://medium.com/@arrahmanbd/remove-html-tags-from-string-in-flutter-dart-with-regex-b824c613e82b
  }

  //---------------------------------------------------------date

  String todayStr() {
    DateTime day = DateTime.now();
    String zeroM = day.month < 10 ? '0' : '';
    String zeroD = day.day < 10 ? '0' : '';
    String today = '${day.year}-$zeroM${day.month}-$zeroD${day.day}';
    return today;
  }

  List<String> lastNdays(int nDays) {
    List<String> days = [];
    for (var i = 0; i <= nDays; i++) {
      days.add(todayStrN(i));
    }
    return days;
  }

  String todayStrN(int minusDay) {
    DateTime day = DateTime.now();
    day = day.subtract(Duration(days: minusDay));
    String zeroM = day.month < 10 ? '0' : '';
    String zeroD = day.day < 10 ? '0' : '';
    String today = '${day.year}-$zeroM${day.month}-$zeroD${day.day}';
    return today;
  }

  void isIrl(String url) {
    var urlPattern =
        r'^((?:.|\n)*?)((http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:‌​,.;]*)?)';
    var match =
        RegExp(urlPattern, caseSensitive: false).hasMatch(url).toString();

    match = match; // .allMatches || firstMatch || hasMatch || stringMatch
  }

  List<String> toListString(List<dynamic> items) {
    List<String> list = [];
    for (var item in items) {
      list.add(item.toString());
    }
    return list;
  }

  List<int> toListInt(List<dynamic> items) {
    List<int> list = [];
    for (var item in items) {
      int? intNum = int.tryParse(item.toString());
      list.add(intNum!);
    }
    return list;
  }

  List<Map> toListMap(List<dynamic> items) {
    List<Map> list = [];
    for (var item in items) {
      list.add(item);
    }
    return list;
  }

  List<dynamic> toListDynamic(List<String> items) {
    List<dynamic> list = [];
    for (var item in items) {
      list.add(item);
    }
    return list;
  }

  Map<String, dynamic> toMapStringDynamic(Map<dynamic, dynamic> resp) {
    Map<String, dynamic> map = {};
    for (String key in resp.keys) {
      map[key] = resp[key];
    }
    return map;
  }

  // date fomatter function
  String getFormattedDateFromFormattedString(
      {required String currentFormat,
      required String desiredFormat,
      required String value}) {
    String formattedDate = "";
    // ignore: unnecessary_null_comparison
    if (value != null || value.isNotEmpty) {
      try {
        DateTime dateTime =
            DateFormat(currentFormat).parse(value, true).toLocal();
        formattedDate = DateFormat(desiredFormat).format(dateTime);
      } catch (e) {
        return '';
      }
    }
    // rint("Formatted date time:  $formattedDate");
    return formattedDate.toString();
  }
}
