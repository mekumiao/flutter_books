import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:sp_util/sp_util.dart';

part 'local_storage.g.dart';

class LocalStorage {
  LocalStorage();

  static const _storageKey = '__local_storage_key__';

  LocalStorageModel? _model;

  void _readOnce() {
    if (_model != null) return;
    try {
      _model = SpUtil.getObj<LocalStorageModel>(
        _storageKey,
        (v) => LocalStorageModel.fromJson(v as Map<String, dynamic>),
      );
    } catch (_) {}
    _model ??= const LocalStorageModel();
  }

  void _write() {
    if (_model == null) return;
    try {
      SpUtil.putObject(_storageKey, _model!.toJson());
    } catch (_) {}
  }

  LocalStorageModel get model {
    _readOnce();
    return _model!;
  }

  set model(LocalStorageModel model) {
    _model = model;
    _write();
  }
}

@JsonSerializable()
class LocalStorageModel {
  const LocalStorageModel({
    this.themeMode = ThemeMode.system,
    this.languageCode = '',
    this.isDisplayedSplash = false,
  });

  factory LocalStorageModel.fromJson(Map<String, dynamic> json) =>
      _$LocalStorageModelFromJson(json);
  Map<String, dynamic> toJson() => _$LocalStorageModelToJson(this);

  final ThemeMode themeMode;
  final String languageCode;
  final bool isDisplayedSplash;

  LocalStorageModel copyWith({
    ThemeMode? themeMode,
    String? languageCode,
    bool? isDisplayedSplash,
  }) {
    return LocalStorageModel(
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      isDisplayedSplash: isDisplayedSplash ?? this.isDisplayedSplash,
    );
  }
}
