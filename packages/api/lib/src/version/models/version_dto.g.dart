// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'version_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VersionDto _$VersionDtoFromJson(Map<String, dynamic> json) => VersionDto(
      id: json['Id'] as String,
      url: json['Url'] as String,
      name: json['Name'] as String,
      versionCode: json['VersionCode'] as int,
      versionName: json['VersionName'] as String,
      remark: json['Remark'] as String,
    );

Map<String, dynamic> _$VersionDtoToJson(VersionDto instance) =>
    <String, dynamic>{
      'Id': instance.id,
      'Url': instance.url,
      'Name': instance.name,
      'VersionCode': instance.versionCode,
      'VersionName': instance.versionName,
      'Remark': instance.remark,
    };
