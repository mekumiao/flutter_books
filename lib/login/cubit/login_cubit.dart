import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:json_annotation/json_annotation.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(const LoginState());

  final AuthenticationRepository _authenticationRepository;

  Future<void> logInWithCredentials() async {
    if (!state.status.isValidated) return;
    emit(state.copyWith(status: FormzStatus.submissionInProgress));
    try {
      await _authenticationRepository.logInWithEmailAndPassword(
        email: state.email.value,
        password: state.password.value,
      );
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ),
      );
      addError(e);
    }
  }

  Future<void> logInWithOther() async {
    try {
      await _authenticationRepository.logInWithID4();
      emit(state.copyWith(status: FormzStatus.submissionSuccess));
    } catch (e) {
      emit(
        state.copyWith(
          status: FormzStatus.submissionFailure,
          errorMessage: e.toString(),
        ),
      );
      addError(e);
    }
  }

  void emailChanged(String value) {
    emit(
      state.copyWith(email: Email.dirty(value)).copyStatus(),
    );
  }

  void passwordChanged(String value) {
    emit(
      state.copyWith(password: Password.dirty(value)).copyStatus(),
    );
  }
}
