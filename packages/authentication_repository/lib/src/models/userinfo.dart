import 'package:json_annotation/json_annotation.dart';

part 'userinfo.g.dart';

@JsonSerializable(fieldRename: FieldRename.none)
class Userinfo {
  const Userinfo({
    this.sub = '',
    this.name = '',
    this.email = '',
    this.picture = '',
    this.role = const [],
  });

  factory Userinfo.fromJson(Map<String, dynamic> json) {
    final role = json['role'];
    if (role is String) {
      json['role'] = [role];
    }
    return _$UserinfoFromJson(json);
  }
  Map<String, dynamic> toJson() => _$UserinfoToJson(this);

  static const Userinfo empty = Userinfo();

  final String sub;
  final String name;
  final String email;
  final String picture;
  final List<String> role;
}
