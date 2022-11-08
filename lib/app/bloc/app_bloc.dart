import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_transformer/bloc_transformer.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:oktoast/oktoast.dart';

part 'app_event.dart';
part 'app_state.dart';

class AppBloc extends Bloc<AppEvent, AppState> {
  AppBloc({
    required AuthenticationRepository authenticationRepository,
    required ConfigurationRepository configurationRepository,
  })  : _authenticationRepository = authenticationRepository,
        _configurationRepostory = configurationRepository,
        super(
          AppState(
            user: authenticationRepository.currentUser,
            themeMode: configurationRepository.currentConfig.themeMode,
            languageCode: configurationRepository.currentConfig.languageCode,
          ),
        ) {
    on<AutoAuthorized>(_onAutoAuthorized);
    on<UserChanged>(_onUserChanged, transformer: throttleDroppable());
    on<LogoutRequested>(_onLogoutRequested);
    on<ThemeModeChanged>(_onThemeModeChanged);
    on<LanguageCodeChanged>(_onLanguageCodeChanged);

    _userSubscription = _authenticationRepository.user.listen((user) {
      add(UserChanged(user));
    });

    _configSubscription = _configurationRepostory.config.listen(
      (config) {
        add(ThemeModeChanged(config.themeMode));
        add(LanguageCodeChanged(config.languageCode));
      },
    );
  }

  final AuthenticationRepository _authenticationRepository;
  final ConfigurationRepository _configurationRepostory;

  late final StreamSubscription<User> _userSubscription;
  late final StreamSubscription<Config> _configSubscription;

  Future<void> _onAutoAuthorized(
    AutoAuthorized event,
    Emitter<AppState> emit,
  ) async {
    try {
      await _authenticationRepository.ensureAvailable();
    } on RefreshTokenError catch (e) {
      if (e.code == 2) {
        showToast('登录已过期，需要重新登录');
        addError(e);
      }
    }
  }

  void _onUserChanged(
    UserChanged event,
    Emitter<AppState> emit,
  ) {
    emit(
      event.user.isEmpty
          ? state.unauthenticated()
          : state.authenticated(event.user),
    );
  }

  Future<void> _onLogoutRequested(
    LogoutRequested event,
    Emitter<AppState> emit,
  ) async {
    try {
      await _authenticationRepository.logOut();
    } catch (e) {
      showToast(e.toString());
      addError(e);
    }
  }

  void _onThemeModeChanged(
    ThemeModeChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(themeMode: event.themeMode));
  }

  void _onLanguageCodeChanged(
    LanguageCodeChanged event,
    Emitter<AppState> emit,
  ) {
    emit(state.copyWith(languageCode: event.languageCode));
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    _configSubscription.cancel();
    return super.close();
  }
}
