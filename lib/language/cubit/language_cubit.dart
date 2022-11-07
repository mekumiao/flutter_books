import 'package:bloc/bloc.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:equatable/equatable.dart';

part 'language_state.dart';

class LanguageCubit extends Cubit<LanguageState> {
  LanguageCubit({
    required ConfigurationRepository configurationRepository,
  })  : _configurationRepository = configurationRepository,
        super(
          LanguageState(
            languageCode: configurationRepository.currentConfig.languageCode,
          ),
        );

  final ConfigurationRepository _configurationRepository;

  void languageCodeChanged(String languageCode) {
    emit(state.copyWith(languageCode: languageCode));
    _configurationRepository.updateConfig(languageCode: languageCode);
  }
}
