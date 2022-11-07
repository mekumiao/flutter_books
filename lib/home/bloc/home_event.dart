part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object> get props => [];
}

class TabChanged extends HomeEvent {
  const TabChanged(this.index);

  final int index;

  @override
  List<Object> get props => [index];
}
