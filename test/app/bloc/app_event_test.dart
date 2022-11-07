import 'package:booksapp/app/bloc/app_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('AppEvent', () {
    group('AppLoaded', () {
      test('supports value comparisons', () {
        expect(AppLoaded(), AppLoaded());
      });
    });

    group('LogoutRequested', () {
      test('supports value comparisons', () {
        expect(LogoutRequested(), LogoutRequested());
      });
    });

    group('ThemeModeChanged', () {
      test('supports value comparisons', () {
        expect(
          const ThemeModeChanged(ThemeMode.dark),
          const ThemeModeChanged(ThemeMode.dark),
        );
        expect(
          const ThemeModeChanged(ThemeMode.dark),
          isNot(const ThemeModeChanged(ThemeMode.light)),
        );
      });
    });

    group('LanguageCodeChanged', () {
      test('supports value comparisons', () {
        expect(
          const LanguageCodeChanged('zh'),
          const LanguageCodeChanged('zh'),
        );
        expect(
          const LanguageCodeChanged('en'),
          isNot(const LanguageCodeChanged('zh')),
        );
      });
    });

    group('UserChanged', () {
      test('supports value comparisons', () {
        final user = MockUser();
        expect(
          UserChanged(user),
          UserChanged(user),
        );
        expect(
          UserChanged(MockUser()),
          isNot(UserChanged(MockUser())),
        );
      });
    });
  });
}
