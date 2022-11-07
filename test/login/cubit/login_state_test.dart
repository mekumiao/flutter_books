import 'package:booksapp/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';

void main() {
  group('LoginState', () {
    test('has correct status', () {
      const state = LoginState();
      expect(state.status, FormzStatus.pure);
      expect(state.email.status, FormzInputStatus.pure);
      expect(state.password.status, FormzInputStatus.pure);
    });

    test('supports value comparisons', () {
      const state = LoginState();
      expect(
        state,
        isNot(state.copyWith(email: const Email.dirty('tt'))),
      );
      expect(
        state,
        isNot(state.copyWith(password: const Password.dirty('tt'))),
      );
    });
  });
}
