// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResult _$PagedResultFromJson(Map<String, dynamic> json) => PagedResult(
      items: json['Items'] as List<dynamic>,
      startingIndex: json['StartingIndex'] as int,
      hasNext: json['HasNext'] as bool,
    );

Map<String, dynamic> _$PagedResultToJson(PagedResult instance) =>
    <String, dynamic>{
      'Items': instance.items,
      'StartingIndex': instance.startingIndex,
      'HasNext': instance.hasNext,
    };
