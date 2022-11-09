import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

class MockLoginCubit extends MockCubit<LoginState> implements LoginCubit {}

void main() {
  const otherLoginButtonKey = Key('loginPage_otherLoginButton_textButton');

  group('LoginPage', () {
    late LoginCubit loginCubit;

    setUp(() {
      loginCubit = MockLoginCubit();
      when(() => loginCubit.state).thenReturn(const LoginState());
      when(() => loginCubit.logInWithGoogle()).thenAnswer((_) async {});
      when(() => loginCubit.logInWithCredentials()).thenAnswer((_) async {});
    });

    test('is routable', () {
      expect(LoginPage.route(), isA<MaterialPageRoute<void>>());
      expect(LoginPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders LoginView', (tester) async {
      await tester.pumpApp(const LoginPage());
      expect(find.byType(LoginView), findsOneWidget);
    });

    testWidgets('logInWithGoogle when sign in with other button is pressed',
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
      verify(() => loginCubit.logInWithGoogle()).called(1);
    });

    testWidgets('Sign in with Google Button', (tester) async {
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
}
