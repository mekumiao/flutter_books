import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

part 'setting_event.dart';
part 'setting_state.dart';

class SettingBloc extends Bloc<SettingEvent, SettingState> {
  SettingBloc() : super(const SettingState()) {
    on<VersionLoaded>(_onVersionLoaded);
  }

  Future<void> _onVersionLoaded(
    VersionLoaded event,
    Emitter<SettingState> emit,
  ) async {
    final packageInfo = await PackageInfo.fromPlatform();
    emit(state.copyWith(verison: packageInfo.version));
  }
}
