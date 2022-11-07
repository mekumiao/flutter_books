part of 'app_bloc.dart';

enum AppStatus {
  initial,
  authenticated,
  unauthenticated,
}

class AppState extends Equatable {
  const AppState({
    this.themeMode = ThemeMode.system,
    this.languageCode = '',
    this.status = AppStatus.initial,
    this.user = User.empty,
  });

  final AppStatus status;
  final ThemeMode themeMode;
  final String languageCode;
  final User user;

  AppState copyWith({
    AppStatus? status,
    ThemeMode? themeMode,
    String? languageCode,
    User? user,
  }) {
    return AppState(
      status: status ?? this.status,
      themeMode: themeMode ?? this.themeMode,
      languageCode: languageCode ?? this.languageCode,
      user: user ?? this.user,
    );
  }

  AppState authenticated(User? user) {
    return copyWith(status: AppStatus.authenticated, user: user);
  }

  AppState unauthenticated() {
    return copyWith(status: AppStatus.unauthenticated, user: User.empty);
  }

  Locale? get language => languageCode.isNotEmpty ? Locale(languageCode) : null;

  @override
  List<Object> get props => [
        status,
        user,
        themeMode,
        languageCode,
      ];
}
