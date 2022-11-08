import 'package:flutter/material.dart';
import 'package:general_data/src/dimens.dart';

class TextStyles {
  const TextStyles._();

  static const TextStyle text = TextStyle(
    fontSize: Dimens.font_sp14,
    textBaseline: TextBaseline.alphabetic,
  );

  static const TextStyle textSize10 = TextStyle(
    fontSize: Dimens.font_sp10,
  );

  static const TextStyle textSize12 = TextStyle(
    fontSize: Dimens.font_sp12,
  );

  static const TextStyle textSize16 = TextStyle(
    fontSize: Dimens.font_sp16,
  );

  static const TextStyle textBold14 = TextStyle(
    fontSize: Dimens.font_sp14,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textBold16 = TextStyle(
    fontSize: Dimens.font_sp16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textBold18 = TextStyle(
    fontSize: Dimens.font_sp18,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textBold24 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle textBold26 = TextStyle(
    fontSize: 26,
    fontWeight: FontWeight.bold,
  );
}
