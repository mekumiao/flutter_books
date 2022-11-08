// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'output_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OutputResult _$OutputResultFromJson(Map<String, dynamic> json) => OutputResult(
      code: json['code'] as int,
      message: json['message'] as String,
      result: json['result'],
    );

Map<String, dynamic> _$OutputResultToJson(OutputResult instance) =>
    <String, dynamic>{
      'code': instance.code,
      'message': instance.message,
      'result': instance.result,
    };
