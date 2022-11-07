import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

import 'package:general_widgets/src/l10n/general_localizations_en.dart';
import 'package:general_widgets/src/l10n/general_localizations_zh.dart';

abstract class GeneralLocalizations {
  static GeneralLocalizations of(BuildContext context) {
    return Localizations.of<GeneralLocalizations>(
      context,
      GeneralLocalizations,
    )!;
  }

  static const LocalizationsDelegate<GeneralLocalizations> delegate =
      _AppLocalizationsDelegate();

  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('zh')
  ];

  String get tips;

  String get confirm;

  String get cancel;

  String get notfound;

  String get askDelete;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<GeneralLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<GeneralLocalizations> load(Locale locale) {
    return SynchronousFuture<GeneralLocalizations>(
      lookupAppLocalizations(locale),
    );
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

GeneralLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return GeneralLocalizationsEn();
    case 'zh':
      return GeneralLocalizationsZh();
  }

  throw FlutterError(
    // ignore: lines_longer_than_80_chars
    'GeneralLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

extension GeneralLocalizationsX on BuildContext {
  GeneralLocalizations get generaltr => GeneralLocalizations.of(this);
}
