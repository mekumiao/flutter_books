import 'dart:async';

import 'package:configuration_repository/src/local_storage.dart';
import 'package:configuration_repository/src/memory_storage.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

class ConfigurationRepository {
  ConfigurationRepository({required LocalStorage store}) : _store = store;

  factory ConfigurationRepository.localStore() {
    return ConfigurationRepository(store: LocalStorage());
  }

  factory ConfigurationRepository.memoryStore() {
    return ConfigurationRepository(store: MemoryStorage());
  }

  final LocalStorage _store;

  final _stream = StreamController<Config>.broadcast();
  Stream<Config> get config => _stream.stream;

  Config get currentConfig => Config.fromStorageModel(_store.model);

  void updateConfig({
    ThemeMode? themeMode,
    String? languageCode,
  }) {
    final model = _store.model = _store.model.copyWith(
      themeMode: themeMode,
      languageCode: languageCode,
    );
    _stream.add(Config.fromStorageModel(model));
  }
}

class Config extends Equatable {
  const Config({
    this.themeMode = ThemeMode.system,
    this.languageCode = '',
  });

  factory Config.fromStorageModel(LocalStorageModel model) {
    return Config(
      themeMode: model.themeMode,
      languageCode: model.languageCode,
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
  List<Object?> get props => [
        themeMode,
        languageCode,
      ];
}
