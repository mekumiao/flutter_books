part of 'home_bloc.dart';

@JsonSerializable()
class HomeState extends Equatable {
  const HomeState({
    this.index = 0,
  });

  factory HomeState.fromJson(Map<String, dynamic> json) =>
      _$HomeStateFromJson(json);
  Map<String, dynamic> toJson() => _$HomeStateToJson(this);

  final int index;

  static const HomeState empty = HomeState();

  bool get isEmpty => this == empty;

  bool get isNotEmpty => this != empty;

  HomeState copyWith({
    int? index,
  }) {
    return HomeState(
      index: index ?? this.index,
    );
  }

  @override
  List<Object> get props => [index];
}
