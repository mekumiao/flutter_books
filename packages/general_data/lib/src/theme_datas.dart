import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
// import 'package:general_data/general_data.dart';

class ThemeDatas {
  const ThemeDatas._();

  static ThemeData lightThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        // errorColor: Colours.error,
        // primaryColor: Colours.light,
        // indicatorColor: Colours.light,
        // scaffoldBackgroundColor: Colours.light,
        // canvasColor: Colours.light,
        pageTransitionsTheme: _NoTransitionsOnWeb(),
      );

  static ThemeData darkThemeData(String fontFamily) => ThemeData(
        fontFamily: fontFamily,
        // errorColor: Colours.error,
        // primaryColor: Colours.dark,
        // indicatorColor: Colours.dark,
        // scaffoldBackgroundColor: Colours.dark,
        // canvasColor: Colours.dark,
        pageTransitionsTheme: _NoTransitionsOnWeb(),
      );
}

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
