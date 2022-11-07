import 'package:json_annotation/json_annotation.dart';

part 'paged_result.g.dart';

@JsonSerializable()
class PagedResult {
  const PagedResult({
    required this.items,
    required this.startingIndex,
    required this.hasNext,
  });

  factory PagedResult.fromJson(Map<String, dynamic> json) =>
      _$PagedResultFromJson(json);

  final List<dynamic> items;
  final int startingIndex;
  final bool hasNext;

  Map<String, dynamic> toJson() => _$PagedResultToJson(this);
}
