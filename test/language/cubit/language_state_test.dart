import 'package:booksapp/language/language.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('LanguageState', () {
    test('has correct status', () {
      const state = LanguageState();
      expect(state.languageCode, '');
    });

    test('supports value comparisons', () {
      const state = LanguageState();
      expect(
        state,
        isNot(state.copyWith(languageCode: 'zh')),
      );
    });
  });
}
