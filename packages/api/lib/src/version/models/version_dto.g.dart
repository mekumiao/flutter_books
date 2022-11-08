// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDto _$VersionDtoFromJson(Map<String, dynamic> json) => VersionDto(
      id: json['id'] as String,
      url: json['url'] as String,
      name: json['name'] as String,
      versionCode: json['version_code'] as int,
      versionName: json['version_name'] as String,
      remark: json['remark'] as String,
    );

Map<String, dynamic> _$VersionDtoToJson(VersionDto instance) =>
    <String, dynamic>{
      'id': instance.id,
      'url': instance.url,
      'name': instance.name,
      'version_code': instance.versionCode,
      'version_name': instance.versionName,
      'remark': instance.remark,
    };
