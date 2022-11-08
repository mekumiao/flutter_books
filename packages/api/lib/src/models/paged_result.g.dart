// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PagedResult _$PagedResultFromJson(Map<String, dynamic> json) => PagedResult(
      items: json['items'] as List<dynamic>,
      startingIndex: json['starting_index'] as int,
      hasNext: json['has_next'] as bool,
    );

Map<String, dynamic> _$PagedResultToJson(PagedResult instance) =>
    <String, dynamic>{
      'items': instance.items,
      'starting_index': instance.startingIndex,
      'has_next': instance.hasNext,
    };
