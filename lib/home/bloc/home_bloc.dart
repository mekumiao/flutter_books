import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.g.dart';

class HomeBloc extends HydratedBloc<HomeEvent, HomeState> {
  HomeBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(HomeState.empty) {
    on<TabChanged>(_onTabChanged);

    _userStreamSubscription = _authenticationRepository.user.listen((user) {
      if (user.isEmpty) add(const TabChanged(0));
    });
  }

  late final StreamSubscription<User> _userStreamSubscription;
  final AuthenticationRepository _authenticationRepository;

  void _onTabChanged(
    TabChanged event,
    Emitter<HomeState> emit,
  ) {
    emit(state.copyWith(index: event.index));
  }

  @override
  Future<void> close() {
    _userStreamSubscription.cancel();
    return super.close();
  }

  @override
  HomeState? fromJson(Map<String, dynamic> json) => HomeState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(HomeState state) => state.toJson();
}
