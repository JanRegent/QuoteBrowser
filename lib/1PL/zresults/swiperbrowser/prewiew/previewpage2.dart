/* spell-checker: disable */

import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:wx_text/wx_text.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../2BL_domain/bl.dart';

bool previewPageOn = false;

Future<void> openURL(String url) async {
  final Uri uri = Uri.parse(url);
  if (!await launchUrl(uri)) {
    throw Exception('Could not launch $uri');
  }
}

Future<void> sendMail(String address) async {
  final Uri uri = Uri.parse('mailto:$address');
  if (!await launchUrl(uri)) {
    throw Exception('Could not send mail $uri');
  }
}

// ignore: must_be_immutable
class PreviewPage2 extends StatefulWidget {
  VoidCallback swiperSetstate;
  PreviewPage2(this.swiperSetstate, {super.key});

  @override
  State<PreviewPage2> createState() => _PreviewPage2State();
}

class _PreviewPage2State extends State<PreviewPage2> {
  @override
  void initState() {
    super.initState();
    highParts();
    highTags();
  }

//----------------------------------------------------------------------
  List<WxTextFilter> filter = [];
  void highTags() {
    List<String> tags = bl.orm.currentRow.tags.value.split('#');
    for (var i = 0; i < tags.length; i++) {
      if (tags[i].isEmpty) continue;

      filter.add(WxTextFilter.highlight(
        search: tags[i],
        style: const TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
      ));
    }
  }

  void highParts() {
    List<String> parts = bl.orm.currentRow.yellowParts.value.split('__|__');

    for (var i = 0; i < parts.length; i++) {
      if (parts[i].isEmpty) continue;

      filter.add(WxTextFilter.highlight(
        search: parts[i],
        style: const TextStyle(color: Colors.red),
      ));
    }
  }

  Row titleRow() {
    return Row(
      children: [
        Obx(() => Text(bl.orm.currentRow.author.value)),
        const Text(' / '),
        Obx(() => Text(
            '${bl.orm.currentRow.book.value}\n${bl.orm.currentRow.parPage.value}'))
      ],
    );
  }

  IconButton previewPageReset() {
    return IconButton(
        onPressed: () {
          previewPageOn = false;
          widget.swiperSetstate();
        },
        icon: const Icon(Icons.edit));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          shape:
              const Border(bottom: BorderSide(color: Colors.orange, width: 4)),
          elevation: 4,
          leading: const Text(' '),
          title: titleRow(),
          actions: [previewPageReset()],
        ),
        body: SingleChildScrollView(
            child: Obx(() => WxText(
                  bl.orm.currentRow.quote.value,
                  highlight: 'highlighted',
                  textAlign: TextAlign.justify,
                  filter: filter,
                  fontSize: 20,
                ))));
  }
}

class TypingText extends StatefulWidget {
  const TypingText({super.key});

  @override
  State<TypingText> createState() => _TypingTextState();
}

class _TypingTextState extends State<TypingText> {
  final key = GlobalKey<WxAnimatedTextState>();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        WxAnimatedText(
          key: key,
          repeat: 0,
          mirror: true,
          reverse: true,
          curve: Curves.linear,
          delay: const Duration(milliseconds: 300),
          duration: const Duration(milliseconds: 1000),
          reverseDelay: const Duration(milliseconds: 300),
          reverseDuration: const Duration(milliseconds: 7000),
          transition: WxAnimatedText.typing(trails: '_'),
          child: const WxText(
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua',
            variant: WxTextVariant.titleLarge,
            gradient: LinearGradient(colors: [
              Colors.blue,
              Colors.red,
              Colors.amber,
            ]),
          ),
        ),
        const SizedBox(height: 20),
        OutlinedButton(
          onPressed: () => key.currentState?.play(reset: true),
          child: const WxText('ReTyping Text'),
        ),
      ],
    );
  }
}

class Wrapper extends StatelessWidget {
  const Wrapper({
    super.key,
    required this.children,
  });

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20.0),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 400),
            child: SizedBox(
              width: double.infinity,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: children,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
