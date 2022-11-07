import 'package:bloc/bloc.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit({required ConfigurationRepository configurationRepository})
      : _configurationRepository = configurationRepository,
        super(
          ThemeState(
            themeMode: configurationRepository.currentConfig.themeMode,
          ),
        );

  final ConfigurationRepository _configurationRepository;

  void themeModeChanged(ThemeMode themeMode) {
    emit(state.copyWith(themeMode: themeMode));
    _configurationRepository.updateConfig(themeMode: themeMode);
  }
}
