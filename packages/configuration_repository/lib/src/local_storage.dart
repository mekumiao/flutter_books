import 'package:flutter/material.dart';
import 'package:sp_util/sp_util.dart';

class LocalStore {
  LocalStore();

  static const _themeModeKey = '__theme_mode_store_key__';
  static const _languageCodeKey = '__language_code_store_key__';

  ThemeMode? _themeMode;
  String? _languageCode;

  ThemeMode get themeMode {
    if (_themeMode == null) {
      try {
        _themeMode = ThemeMode.values[SpUtil.getInt(_themeModeKey)!];
      } catch (_) {}
    }
    return _themeMode!;
  }

  set themeMode(ThemeMode mode) {
    _themeMode = mode;
    SpUtil.putInt(_themeModeKey, mode.index);
  }

  String get languageCode {
    if (_languageCode == null) {
      try {
        _languageCode = SpUtil.getString(_languageCodeKey);
      } catch (_) {}
    }
    return _languageCode!;
  }

  set languageCode(String code) {
    _languageCode = code;
    SpUtil.putString(_languageCodeKey, code);
  }
}
