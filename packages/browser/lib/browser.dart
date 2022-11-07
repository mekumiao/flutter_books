library browser;

import 'package:browser/src/webview_page.dart';
import 'package:flutter/widgets.dart';

class Browser {
  static Future<void> open({
    required BuildContext context,
    required String title,
    required Uri url,
  }) async {
    await Navigator.of(context).push(
      WebviewPage.route(title: title, url: url),
    );
  }
}
