import 'dart:async';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_data/general_data.dart';

class ThemeHelper {
  static bool isDark(BuildContext context) {
    return Theme.of(context).brightness == Brightness.dark;
  }

  static Color? getTextColor(BuildContext context) {
    return isDark(context) ? Colours.dark_text : null;
  }

  static Color getDialogTextFieldColor(BuildContext context) {
    return isDark(context) ? Colours.dark_bg_gray_ : Colours.bg_gray;
  }

  static StreamSubscription<dynamic>? _subscription;

  /// 设置NavigationBar样式，使得导航栏颜色与深色模式的设置相符。
  static void setSystemNavigationBar(ThemeMode mode) {
    /// 主题切换动画（AnimatedTheme）时间为200毫秒，延时设置导航栏颜色，这样过渡相对自然。
    _subscription?.cancel();

    Stream.fromFuture(
      Future<dynamic>.delayed(const Duration(milliseconds: 200)),
    ).listen((_) {
      var isDark = false;
      if (mode == ThemeMode.dark ||
          (mode == ThemeMode.system &&
              window.platformBrightness == Brightness.dark)) {
        isDark = true;
      }
      setSystemBarStyle(isDark: isDark);
    });
  }

  /// 设置StatusBar、NavigationBar样式。(仅针对安卓)
  /// 本项目在android MainActivity中已设置，不需要覆盖设置。
  static void setSystemBarStyle({bool? isDark}) {
    if (Platform.isAndroid) {
      final isDarka = isDark ?? window.platformBrightness == Brightness.dark;
      final systemUiOverlayStyle = SystemUiOverlayStyle(
        /// 透明状态栏
        statusBarColor: Colors.transparent,
        systemNavigationBarColor:
            isDarka ? Colours.dark_bg_color : Colors.white,
        systemNavigationBarIconBrightness:
            isDarka ? Brightness.light : Brightness.dark,
      );
      SystemChrome.setSystemUIOverlayStyle(systemUiOverlayStyle);
    }
  }
}

extension ThemeExtension on BuildContext {
  bool get isDark => ThemeHelper.isDark(this);
  Color get backgroundColor => Theme.of(this).scaffoldBackgroundColor;
  Color get dialogBackgroundColor => Theme.of(this).canvasColor;
}
