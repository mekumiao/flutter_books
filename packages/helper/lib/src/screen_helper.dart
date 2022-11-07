import 'dart:io';
import 'dart:math';

import 'package:flutter/widgets.dart';

/// https://medium.com/gskinner-team/flutter-simplify-platform-screen-size-detection-4cb6fc4f7ed1
///
/// ```dart
/// bool isLandscape = ScreenHelper.isLandscape(context)
/// bool isLargePhone = ScreenHelper.diagonal(context) > 720;
/// bool isTablet = ScreenHelper.diagonalInches(context) >= 7;
/// bool isNarrow = ScreenHelper.widthInches(context) < 3.5;
/// bool isLandscape = ScreenHelper.isLandscape(context)
/// bool isLargePhone = ScreenHelper.diagonal(context) > 720;
/// bool isTablet = ScreenHelper.diagonalInches(context) >= 7;
/// bool isNarrow = ScreenHelper.widthInches(context) < 3.5;
/// ```
class ScreenHelper {
  static double get _ppi => (Platform.isAndroid || Platform.isIOS) ? 150 : 96;

  static bool isLandscape(BuildContext context) =>
      MediaQuery.of(context).orientation == Orientation.landscape;

  static double diagonal(BuildContext context) {
    final s = MediaQuery.of(context).size;
    return sqrt((s.width * s.width) + (s.height * s.height));
  }

  static Size inches(BuildContext context) {
    final pxSize = MediaQuery.of(context).size;
    return Size(pxSize.width / _ppi, pxSize.height / _ppi);
  }

  static double widthInches(BuildContext context) => inches(context).width;

  static double heightInches(BuildContext context) => inches(context).height;

  static double diagonalInches(BuildContext context) =>
      diagonal(context) / _ppi;
}

extension MediaQueryExtension on BuildContext {
  Size get size => MediaQuery.of(this).size;
  double get height => MediaQuery.of(this).size.height;
  double get width => MediaQuery.of(this).size.width;
}
