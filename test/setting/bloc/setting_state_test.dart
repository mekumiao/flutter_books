import 'package:booksapp/setting/setting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingState', () {
    group('initial', () {
      test('has correct status', () {
        const state = SettingState();
        expect(state.verison, '0.0');
        expect(state, const SettingState());
      });
    });

    group('copywith', () {
      test('has correct status', () {
        final state = const SettingState().copyWith(verison: '0.1');
        expect(state.verison, '0.1');
      });
    });
  });
}
