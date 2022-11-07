import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:general_data/general_data.dart';

class ThemeDatas {
  const ThemeDatas._();

  static ThemeData darkThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        errorColor: Colours.dark_red,
        primaryColor: Colours.dark_app_main,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.dark,
          secondary: Colours.dark_app_main,
        ),
        // Tab指示器颜色
        indicatorColor: Colours.dark_app_main,
        // 页面背景色
        scaffoldBackgroundColor: Colours.dark_bg_color,
        // 主要用于Material背景色
        canvasColor: Colours.dark_material_bg,
        // 文字选择色（输入框选择文字等）
        // textSelectionColor: Colours.app_main.withAlpha(70),
        // textSelectionHandleColor: Colours.app_main,
        // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colours.app_main.withAlpha(70),
          selectionHandleColor: Colours.app_main,
          cursorColor: Colours.app_main,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyles.text),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states
                    .any((element) => element == MaterialState.disabled)) {
                  return Colours.text;
                }
                return Colours.dark_text;
              },
            ),
          ),
        ),
        textTheme: const TextTheme(
          // TextField输入文字颜色
          subtitle1: TextStyles.textDark,
          // Text文字样式
          bodyText2: TextStyles.textDark,
          subtitle2: TextStyles.textDarkGray12,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyles.textHint14,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colours.dark_bg_color,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
        dividerTheme: const DividerThemeData(
          color: Colours.dark_line,
          space: 0.6,
          thickness: 0.6,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.dark,
        ),
        pageTransitionsTheme: _NoTransitionsOnWeb(),
        // https://github.com/flutter/flutter/issues/77142
        visualDensity: VisualDensity.standard,
        snackBarTheme: SnackBarThemeData(
          backgroundColor: Colours.text,
          contentTextStyle: TextStyles.textDark.copyWith(
            fontSize: Dimens.font_sp15,
          ),
        ),
      );

  static ThemeData lightThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        errorColor: Colours.red,
        primaryColor: Colours.app_main,
        colorScheme: ColorScheme.fromSwatch().copyWith(
          brightness: Brightness.light,
          secondary: Colours.app_main,
        ),
        // Tab指示器颜色
        indicatorColor: Colours.app_main,
        // 页面背景色
        scaffoldBackgroundColor: Colors.white,
        // 主要用于Material背景色
        canvasColor: Colors.white,
        // 文字选择色（输入框选择文字等）
        // textSelectionColor: Colours.app_main.withAlpha(70),
        // textSelectionHandleColor: Colours.app_main,
        // 稳定版：1.23 变更(https://flutter.dev/docs/release/breaking-changes/text-selection-theme)
        textSelectionTheme: TextSelectionThemeData(
          selectionColor: Colours.app_main.withAlpha(70),
          selectionHandleColor: Colours.app_main,
          cursorColor: Colours.app_main,
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            textStyle: MaterialStateProperty.all(TextStyles.text),
            foregroundColor: MaterialStateProperty.resolveWith(
              (states) {
                if (states
                    .any((element) => element == MaterialState.disabled)) {
                  return Colours.dark_text;
                }
                return Colours.text;
              },
            ),
          ),
        ),
        textTheme: const TextTheme(
          // TextField输入文字颜色
          subtitle1: TextStyles.text,
          // Text文字样式
          bodyText2: TextStyles.text,
          subtitle2: TextStyles.textGray12,
        ),
        inputDecorationTheme: const InputDecorationTheme(
          hintStyle: TextStyles.textDarkGray14,
        ),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          color: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
        dividerTheme: const DividerThemeData(
          color: Colours.line,
          space: 0.6,
          thickness: 0.6,
        ),
        cupertinoOverrideTheme: const CupertinoThemeData(
          brightness: Brightness.light,
        ),
        pageTransitionsTheme: _NoTransitionsOnWeb(),
        // https://github.com/flutter/flutter/issues/77142
        visualDensity: VisualDensity.standard,
      );
}

/// https://medium.com/flutter/improving-perceived-performance-with-image-placeholders-precaching-and-disabled-navigation-6b3601087a2b
/// 对于Web应用程序，为了提高性能，可以禁用页面过渡动画。
class _NoTransitionsOnWeb extends PageTransitionsTheme {
  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    if (kIsWeb) {
      return child;
    }
    // FadeUpwardsPageTransitionsBuilder
    // OpenUpwardsPageTransitionsBuilder
    // CupertinoPageTransitionsBuilder
    // ZoomPageTransitionsBuilder
    return const ZoomPageTransitionsBuilder().buildTransitions(
      route,
      context,
      animation,
      secondaryAnimation,
      child,
    );
  }
}
