import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Equatable {
  const User({
    required this.id,
    this.name = '',
    this.email = '',
    this.picture = '',
    this.role = const [],
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

  final String id;
  final String name;
  final String email;
  final List<String> role;
  final String picture;

  static const empty = User(id: '');

  bool get isEmpty => this == User.empty;

  bool get isNotEmpty => this != User.empty;

  bool get isAdmin => role.contains('admin');

  @override
  List<Object?> get props => [id, name, email, picture, role];
}
