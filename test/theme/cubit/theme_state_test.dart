import 'package:booksapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('ThemeState', () {
    test('has correct status', () {
      const state = ThemeState();
      expect(state.themeMode, ThemeMode.system);
    });

    test('supports value comparisons', () {
      const state = ThemeState();
      expect(
        state,
        isNot(state.copyWith(themeMode: ThemeMode.light)),
      );
    });
  });
}
