import 'package:bloc/bloc.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:equatable/equatable.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required ConfigurationRepository configurationRepository})
      : _configurationRepository = configurationRepository,
        super(SplashInitial());

  final int _maxcomputationCount = 3;
  final ConfigurationRepository _configurationRepository;

  Future<void> startCountdown() async {
    emit(SplashInProcess(seconds: _maxcomputationCount));
    final stream = Stream<int>.periodic(
      const Duration(seconds: 1),
      (count) => _maxcomputationCount - count - 1,
    ).take(_maxcomputationCount);
    await stream.forEach((seconds) {
      emit(SplashInProcess(seconds: seconds));
    });
    emit(SplashCompleted());
    // 短时间内不再显示广告页
    _configurationRepository.updateConfig(isDisplayedSplash: true);
  }
}
