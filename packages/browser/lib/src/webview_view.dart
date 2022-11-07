import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebviewView extends StatefulWidget {
  const WebviewView({
    super.key,
    required this.title,
    required this.url,
  });

  final String title;
  final Uri url;

  @override
  State<WebviewView> createState() => _WebviewViewState();
}

class _WebviewViewState extends State<WebviewView> {
  final _controller = Completer<WebViewController>();
  int _progressValue = 0;

  @override
  void initState() {
    super.initState();

    if (Platform.isAndroid) {
      WebView.platform = SurfaceAndroidWebView();
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<WebViewController>(
      future: _controller.future,
      builder: (context, snapshot) {
        return WillPopScope(
          onWillPop: () async {
            if (snapshot.hasData) {
              final canGoBack = await snapshot.data!.canGoBack();
              if (canGoBack) {
                // 网页可以返回时，优先返回上一页
                await snapshot.data!.goBack();
                return Future.value(false);
              }
            }
            return Future.value(true);
          },
          child: Scaffold(
            appBar: MyAppBar(title: widget.title),
            body: Stack(
              children: [
                WebView(
                  initialUrl: widget.url.toString(),
                  javascriptMode: JavascriptMode.unrestricted,
                  allowsInlineMediaPlayback: true,
                  onWebViewCreated: _controller.complete,
                  onProgress: (int progress) {
                    debugPrint('WebView is loading (progress : $progress%)');
                    setState(() {
                      _progressValue = progress;
                    });
                  },
                ),
                if (_progressValue != 100)
                  LinearProgressIndicator(
                    value: _progressValue / 100,
                    backgroundColor: Colors.transparent,
                    minHeight: 2,
                  )
                else
                  Gaps.empty,
              ],
            ),
          ),
        );
      },
    );
  }
}
