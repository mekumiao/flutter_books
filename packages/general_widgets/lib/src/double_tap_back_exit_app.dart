import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// 双击返回退出
class DoubleTapBackExitApp extends StatefulWidget {
  const DoubleTapBackExitApp({
    super.key,
    required this.child,
    this.duration = const Duration(milliseconds: 2500),
    this.onFirst,
    this.onSecond,
  });

  final Widget child;
  final Duration duration;
  final VoidCallback? onFirst;
  final VoidCallback? onSecond;

  @override
  DoubleTapBackExitAppState createState() => DoubleTapBackExitAppState();
}

class DoubleTapBackExitAppState extends State<DoubleTapBackExitApp> {
  DateTime? _lastTime;

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _isExit,
      child: widget.child,
    );
  }

  Future<bool> _isExit() async {
    if (_lastTime == null ||
        DateTime.now().difference(_lastTime!) > widget.duration) {
      _lastTime = DateTime.now();
      widget.onFirst?.call();
      return Future.value(false);
    }
    widget.onSecond?.call();
    await SystemNavigator.pop();
    return Future.value(true);
  }
}
