// ignore: depend_on_referenced_packages
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:dart_rss/dart_rss.dart';

void rssInDo() {
  final client = http.Client();

  // RSS feed
  client
      .get(Uri.parse(
          'https://developer.apple.com/news/releases/rss/releases.rss'))
      .then((response) {
    return response.body;
  }).then((bodyString) {
    final channel = RssFeed.parse(bodyString);
    debugPrint(channel as String?);
    return channel;
  });

  // Atom feed
  client
      .get(Uri.parse('https://www.theverge.com/rss/index.xml'))
      .then((response) {
    return response.body;
  }).then((bodyString) {
    final feed = AtomFeed.parse(bodyString);
    debugPrint(feed as String?);
    for (var element in feed.items) {
      debugPrint(element.title);
    }
    return feed;
  });
}
