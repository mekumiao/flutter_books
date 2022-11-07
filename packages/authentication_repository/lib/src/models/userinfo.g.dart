// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userinfo.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Userinfo _$UserinfoFromJson(Map<String, dynamic> json) => Userinfo(
      sub: json['sub'] as String? ?? '',
      name: json['name'] as String? ?? '',
      email: json['email'] as String? ?? '',
      picture: json['picture'] as String? ?? '',
      role:
          (json['role'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
    );

Map<String, dynamic> _$UserinfoToJson(Userinfo instance) => <String, dynamic>{
      'sub': instance.sub,
      'name': instance.name,
      'email': instance.email,
      'picture': instance.picture,
      'role': instance.role,
    };
