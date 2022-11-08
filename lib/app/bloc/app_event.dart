part of 'app_bloc.dart';

abstract class AppEvent extends Equatable {
  const AppEvent();

  @override
  List<Object> get props => [];
}

class AutoAuthorized extends AppEvent {}

class LogoutRequested extends AppEvent {}

class ThemeModeChanged extends AppEvent {
  const ThemeModeChanged(this.themeMode);

  final ThemeMode themeMode;

  @override
  List<Object> get props => [themeMode];
}

class LanguageCodeChanged extends AppEvent {
  const LanguageCodeChanged(this.languageCode);

  final String languageCode;

  @override
  List<Object> get props => [languageCode];
}

class UserChanged extends AppEvent {
  const UserChanged(this.user);

  final User user;

  @override
  List<Object> get props => [user];
}
