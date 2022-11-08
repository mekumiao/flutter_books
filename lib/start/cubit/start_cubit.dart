import 'package:bloc/bloc.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:equatable/equatable.dart';

part 'start_state.dart';

class StartCubit extends Cubit<StartState> {
  StartCubit({required ConfigurationRepository configurationRepository})
      : _configurationRepository = configurationRepository,
        super(StartInitial());

  final ConfigurationRepository _configurationRepository;

  void started() {
    _configurationRepository.updateConfig(isStarted: true);
  }
}
