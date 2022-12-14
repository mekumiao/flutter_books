import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

class MockEmail extends Mock implements Email {}

class MockPassword extends Mock implements Password {}

void main() {
  const emailInputKey = Key('loginForm_emailInput_textField');
  const passwordInputKey = Key('loginForm_passwordInput_textField');

  const loginButtonKey = Key('loginForm_loginButton_myButton');
  const otherLoginButtonKey = Key('loginForm_otherLoginButton_textButton');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@ssw0rd1';

  group('LoginForm', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(const LoginState());
      when(() => loginCubit.logInWithOther()).thenAnswer((_) async {});
      when(() => loginCubit.logInWithCredentials()).thenAnswer((_) async {});
    });

    group('calls', () {
      testWidgets('emailChanged when email changes', (tester) async {
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(emailInputKey), testEmail);
        verify(() => loginCubit.emailChanged(testEmail)).called(1);
      });

      testWidgets('passwordChanged when password changes', (tester) async {
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        await tester.enterText(find.byKey(passwordInputKey), testPassword);
        verify(() => loginCubit.passwordChanged(testPassword)).called(1);
      });

      testWidgets('logInWithCredentials when login button is pressed',
          (tester) async {
        when(() => loginCubit.state).thenReturn(
          const LoginState(status: FormzStatus.valid),
        );
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        await tester.tap(find.byKey(loginButtonKey));
        verify(() => loginCubit.logInWithCredentials()).called(1);
      });

      testWidgets('logInWithOther when sign in with other button is pressed',
          (tester) async {
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        await tester.tap(find.byKey(otherLoginButtonKey));
        verify(() => loginCubit.logInWithOther()).called(1);
      });
    });

    group('renders', () {
      testWidgets('AuthenticationFailure SnackBar when submission fails',
          (tester) async {
        whenListen(
          loginCubit,
          Stream.fromIterable(const <LoginState>[
            LoginState(status: FormzStatus.submissionInProgress),
            LoginState(status: FormzStatus.submissionFailure),
          ]),
        );
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        await tester.pump();
        expect(find.text('Authentication Failure'), findsOneWidget);
      });

      testWidgets('invalid email error text when email is invalid',
          (tester) async {
        final email = MockEmail();
        when(() => email.invalid).thenReturn(true);
        when(() => email.value).thenReturn('');
        when(() => loginCubit.state).thenReturn(LoginState(email: email));
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        expect(find.text('invalid email'), findsOneWidget);
      });

      testWidgets('invalid password error text when password is invalid',
          (tester) async {
        final password = MockPassword();
        when(() => password.invalid).thenReturn(true);
        when(() => password.value).thenReturn('');
        when(() => loginCubit.state).thenReturn(LoginState(password: password));
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        expect(find.text('invalid password'), findsOneWidget);
      });

      testWidgets('disabled login button when status is not validated',
          (tester) async {
        when(() => loginCubit.state).thenReturn(
          const LoginState(status: FormzStatus.invalid),
        );
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        final loginButton = tester.widget<ElevatedButton>(
          find.byKey(loginButtonKey),
        );
        expect(loginButton.enabled, isFalse);
      });

      testWidgets('enabled login button when status is validated',
          (tester) async {
        when(() => loginCubit.state).thenReturn(
          const LoginState(status: FormzStatus.valid),
        );
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        final loginButton = tester.widget<ElevatedButton>(
          find.byKey(loginButtonKey),
        );
        expect(loginButton.enabled, isTrue);
      });

      testWidgets('Sign in with Other Button', (tester) async {
        await tester.pumpMaterialApp(
          Scaffold(
            body: BlocProvider.value(
              value: loginCubit,
              child: const LoginForm(),
            ),
          ),
        );
        expect(find.byKey(otherLoginButtonKey), findsOneWidget);
      });
    });
  });
}
