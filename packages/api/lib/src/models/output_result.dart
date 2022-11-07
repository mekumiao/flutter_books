import 'package:json_annotation/json_annotation.dart';

part 'output_result.g.dart';

@JsonSerializable()
class OutputResult {
  const OutputResult({
    required this.code,
    required this.message,
    this.result,
  });

  factory OutputResult.fromJson(Map<String, dynamic> json) =>
      _$OutputResultFromJson(json);

  static const OutputResult empty = OutputResult(code: 0, message: '');

  bool get isEmpty => identical(this, empty);

  bool get isNotEmpty => !isEmpty;

  final int code;
  final String message;
  final dynamic result;

  Map<String, dynamic> toJson() => _$OutputResultToJson(this);
}
