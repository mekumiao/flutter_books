import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'version_dto.g.dart';

@JsonSerializable()
class VersionDto extends Equatable {
  const VersionDto({
    required this.id,
    required this.url,
    required this.name,
    required this.versionCode,
    required this.versionName,
    required this.remark,
  });

  factory VersionDto.fromJson(Map<String, dynamic> json) =>
      _$VersionDtoFromJson(json);

  final String id;
  final String url;
  final String name;
  final int versionCode;
  final String versionName;
  final String remark;

  VersionDto copyWith({
    String? id,
    String? url,
    String? name,
    int? versionCode,
    String? versionName,
    String? remark,
  }) {
    return VersionDto(
      id: id ?? this.id,
      url: url ?? this.url,
      name: name ?? this.name,
      versionCode: versionCode ?? this.versionCode,
      versionName: versionName ?? this.versionName,
      remark: remark ?? this.remark,
    );
  }

  Map<String, dynamic> toJson() => _$VersionDtoToJson(this);

  @override
  List<Object?> get props => [id, versionCode];
}
