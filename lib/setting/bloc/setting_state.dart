part of 'setting_bloc.dart';

class SettingState extends Equatable {
  const SettingState({this.verison = '0.0'});

  final String verison;

  SettingState copyWith({String? verison}) {
    return SettingState(verison: verison ?? this.verison);
  }

  @override
  List<Object> get props => [verison];
}
