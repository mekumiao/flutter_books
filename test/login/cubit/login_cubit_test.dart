import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/login/login.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

void main() {
  late AuthenticationRepository authenticationRepository;

  const testEmail = Email.dirty('test@qq.com');
  const testPassword = Password.dirty('123123@tt');

  setUp(() {
    setHydratedStorage();
    authenticationRepository = createMockAuthenticationRepository();
    when(
      () => authenticationRepository.logInWithEmailAndPassword(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async {});
    when(
      () => authenticationRepository.logInWithID4(),
    ).thenAnswer((_) async {});
  });

  group('LoginCubit', () {
    test('initial state is initial when user is empty', () {
      expect(
        LoginCubit(authenticationRepository: authenticationRepository).state,
        const LoginState(),
      );
    });
  });

  group('logInWithCredentials', () {
    blocTest<LoginCubit, LoginState>(
      'invokes logInWithEmailAndPassword',
      setUp: () {},
      build: () => LoginCubit(
        authenticationRepository: authenticationRepository,
      ),
      act: (cubit) => cubit.logInWithCredentials(),
      seed: () => const LoginState(
        email: testEmail,
        password: testPassword,
        status: FormzStatus.valid,
      ),
      expect: () => [
        const LoginState(
          email: testEmail,
          password: testPassword,
          status: FormzStatus.submissionInProgress,
        ),
        const LoginState(
          email: testEmail,
          password: testPassword,
          status: FormzStatus.submissionSuccess,
        ),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.logInWithEmailAndPassword(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).called(1);
      },
    );
  });

  group('logInWithOther', () {
    blocTest<LoginCubit, LoginState>(
      'invokes logInWithID4',
      setUp: () {
        when(
          () => authenticationRepository.logInWithID4(),
        ).thenAnswer((_) async {});
      },
      build: () => LoginCubit(
        authenticationRepository: authenticationRepository,
      ),
      act: (cubit) => cubit.logInWithOther(),
      seed: () => const LoginState(email: testEmail, password: testPassword),
      expect: () => [
        const LoginState(
          email: testEmail,
          password: testPassword,
          status: FormzStatus.submissionSuccess,
        ),
      ],
      verify: (_) {
        verify(
          () => authenticationRepository.logInWithID4(),
        ).called(1);
      },
    );
  });
}
