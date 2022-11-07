import 'package:configuration_repository/src/local_storage.dart';
import 'package:flutter/material.dart';

class MemoryStore extends LocalStore {
  MemoryStore();

  ThemeMode? _themeMode;
  String? _languageCode;

  @override
  ThemeMode get themeMode => _themeMode ?? ThemeMode.system;

  @override
  set themeMode(ThemeMode mode) => _themeMode = mode;

  @override
  String get languageCode => _languageCode ?? '';

  @override
  set languageCode(String code) => _languageCode = code;
}
