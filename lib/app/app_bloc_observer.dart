import 'package:diagnose_logger/diagnose_logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    Log.logger.d('bloc: ${bloc.runtimeType} on create');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    Log.logger
      ..d('bloc: ${bloc.runtimeType} on change')
      ..v(change);
  }

  @override
  void onTransition(
    Bloc<dynamic, dynamic> bloc,
    Transition<dynamic, dynamic> transition,
  ) {
    super.onTransition(bloc, transition);
    Log.logger
      ..d('bloc: ${bloc.runtimeType} on transition')
      ..v(transition);
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    super.onError(bloc, error, stackTrace);
    Log.logger
        .e('bloc: error: ${bloc.runtimeType} on error', error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    Log.logger.d('bloc: ${bloc.runtimeType} on close');
  }
}
