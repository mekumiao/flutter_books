// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputResult _$OutputResultFromJson(Map<String, dynamic> json) => OutputResult(
      code: json['Code'] as int,
      message: json['Message'] as String,
      result: json['Result'],
    );

Map<String, dynamic> _$OutputResultToJson(OutputResult instance) =>
    <String, dynamic>{
      'Code': instance.code,
      'Message': instance.message,
      'Result': instance.result,
    };
