import 'package:booksapp/setting/setting.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SettingEvent', () {
    group('VersionLoaded', () {
      test('supports value comparisons', () {
        expect(VersionLoaded(), VersionLoaded());
      });
    });
  });
}
