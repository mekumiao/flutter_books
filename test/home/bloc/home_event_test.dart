import 'package:booksapp/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeEvent', () {
    group('TabChanged', () {
      test('supports value comparisons', () {
        expect(const TabChanged(1), const TabChanged(1));
        expect(const TabChanged(1), isNot(const TabChanged(2)));
      });
    });
  });
}
