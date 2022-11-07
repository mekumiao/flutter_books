import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// 本地化扩展
extension AppLocalizationsBuildContextX on BuildContext {
  AppLocalizations get apptr => AppLocalizations.of(this);
}
