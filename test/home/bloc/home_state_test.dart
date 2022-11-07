import 'package:booksapp/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('HomeState', () {
    group('initial', () {
      test('has correct status', () {
        expect(HomeState.empty.index, 0);
        expect(const HomeState(index: 3).index, 3);
      });
    });
  });
}
