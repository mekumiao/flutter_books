import 'dart:async';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/language/language.dart';
import 'package:booksapp/setting/setting.dart';
import 'package:booksapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helper.dart';

void main() {
  const logOutButtonKey = Key('settingPage_logOutButton');
  const languageButtonKey = Key('settingPage_languageButton');
  const themeButtonKey = Key('settingPage_themeButton');

  group('SettingPage', () {
    test('is routable', () {
      expect(SettingPage.route(), isA<MaterialPageRoute<void>>());
      expect(SettingPage.page(), isA<MaterialPage<void>>());
    });

    group('renders', () {
      testWidgets('renders SettingView', (tester) async {
        await tester.pumpApp(const SettingPage());
        expect(find.byType(SettingView), findsOneWidget);
      });
    });

    group('calls', () {
      testWidgets('navigate to ThemePage when tab themeButton', (tester) async {
        await tester.pumpApp(const SettingPage());
        await tester.tap(find.byKey(themeButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(ThemePage), findsOneWidget);
      });

      testWidgets('navigate to LanguagePage when tab languageButton',
          (tester) async {
        await tester.pumpApp(const SettingPage());
        await tester.tap(find.byKey(languageButtonKey));
        await tester.pumpAndSettle();
        expect(find.byType(LanguagePage), findsOneWidget);
      });

      testWidgets('dialog LogoutWindow when tab logOutButton', (tester) async {
        final authenticationRepository = createMockAuthenticationRepository();
        when(() => authenticationRepository.user).thenAnswer(
          (_) => Stream.fromIterable([
            const User(id: '1'),
          ]),
        );
        when(() => authenticationRepository.currentUser).thenReturn(
          const User(id: '1'),
        );
        await tester.pumpApp(
          const SettingPage(),
          authenticationRepository: authenticationRepository,
        );
        await tester.tap(find.byKey(logOutButtonKey));
        await tester.pumpAndSettle();
        expect(find.text('Are you sure you want to log out?'), findsOneWidget);
      });
    });
  });
}
