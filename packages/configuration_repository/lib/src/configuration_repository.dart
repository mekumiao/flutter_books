import 'dart:async';

import 'package:configuration_repository/src/local_storage.dart';
import 'package:configuration_repository/src/memory_store.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConfigurationRepository {
  ConfigurationRepository({required LocalStore store}) : _store = store;

  factory ConfigurationRepository.localStore() {
    return ConfigurationRepository(store: LocalStore());
  }

  factory ConfigurationRepository.memoryStore() {
    return ConfigurationRepository(store: MemoryStore());
  }

  final LocalStore _store;

  final _stream = StreamController<Config>.broadcast();
  Stream<Config> get config => _stream.stream;

  Config get currentConfig => Config.fromStore(_store);

  void updateConfig({
    ThemeMode? themeMode,
    String? languageCode,
  }) {
    if (themeMode != null) _store.themeMode = themeMode;
    if (languageCode != null) _store.languageCode = languageCode;
    _stream.add(Config.fromStore(_store));
  }
}

class Config extends Equatable {
  const Config({
    this.themeMode = ThemeMode.system,
    this.languageCode = '',
  });

  factory Config.fromStore(LocalStore store) {
    return Config(
      themeMode: store.themeMode,
      languageCode: store.languageCode,
    );
  }

  final ThemeMode themeMode;
  final String languageCode;

  static const empty = Config();

  Config copyWith({
    ThemeMode? themeMode,
    String? languageCode,
  }) {
    return Config(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  @override
  List<Object?> get props => [themeMode, languageCode];
}
