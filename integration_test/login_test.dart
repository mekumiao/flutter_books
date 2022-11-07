import 'package:booksapp/home/home.dart';
import 'package:booksapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

import 'helper.dart';

void main() {
  ensureInitialized();

  const loginButtonKey = Key('loginForm_loginButton_myButton');
  const emailInputKey = Key('loginForm_emailInput_textField');
  const passwordInputKey = Key('loginForm_passwordInput_textField');

  const testEmail = 'test@gmail.com';
  const testPassword = 'testP@ssw0rd1';

  group('登录功能测试', () {
    testWidgets('正确登录', (tester) async {
      await tester.pumpApp(const LoginPage());
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(emailInputKey), testEmail);
      await tester.pumpAndSettle();

      await tester.enterText(find.byKey(passwordInputKey), testPassword);
      await tester.pumpAndSettle();

      await tester.tap(find.byKey(loginButtonKey));
      await tester.pumpAndSettle();

      expect(find.byType(HomePage), findsOneWidget);
    });

    group('输入测试', () {
      testWidgets('邮箱格式错误', (tester) async {
        await tester.pumpApp(const LoginPage());
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(emailInputKey), 'test33@.com');
        await tester.pumpAndSettle();
        expect(find.text('invalid email'), findsOneWidget);
      });

      testWidgets('密码不能为空', (tester) async {
        await tester.pumpApp(const LoginPage());
        await tester.pumpAndSettle();

        await tester.enterText(find.byKey(passwordInputKey), 'a');
        await tester.pumpAndSettle();
        await tester.sendKeyEvent(LogicalKeyboardKey.backspace);
        await tester.pumpAndSettle();
        expect(find.text('invalid password'), findsOneWidget);
      });
    });
  });
}
