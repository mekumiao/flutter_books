import 'package:browser/src/webview_view.dart';
import 'package:flutter/material.dart';

class WebviewPage extends StatelessWidget {
  const WebviewPage({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final Uri url;

  static Route<void> route({required String title, required Uri url}) {
    return MaterialPageRoute<void>(
      builder: (_) => WebviewPage(title: title, url: url),
    );
  }

  static Page<void> page({required String title, required Uri url}) {
    return MaterialPage<void>(
      child: WebviewPage(title: title, url: url),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WebviewView(title: title, url: url);
  }
}
