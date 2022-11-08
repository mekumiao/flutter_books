// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'local_storage.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LocalStorageModel _$LocalStorageModelFromJson(Map<String, dynamic> json) =>
    LocalStorageModel(
      themeMode: $enumDecodeNullable(_$ThemeModeEnumMap, json['theme_mode']) ??
          ThemeMode.system,
      languageCode: json['language_code'] as String? ?? '',
      isDisplayedSplash: json['is_displayed_splash'] as bool? ?? true,
    );

Map<String, dynamic> _$LocalStorageModelToJson(LocalStorageModel instance) =>
    <String, dynamic>{
      'theme_mode': _$ThemeModeEnumMap[instance.themeMode],
      'language_code': instance.languageCode,
      'is_displayed_splash': instance.isDisplayedSplash,
    };

const _$ThemeModeEnumMap = {
  ThemeMode.system: 'system',
  ThemeMode.light: 'light',
  ThemeMode.dark: 'dark',
};
