part of 'splash_cubit.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class SplashInitial extends SplashState {}

class SplashInProcess extends SplashState {
  const SplashInProcess({this.seconds = 0});

  final int seconds;
  @override
  List<Object> get props => [seconds];
}

class SplashCompleted extends SplashState {}
