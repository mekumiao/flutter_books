import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/app.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('AppState', () {
    group('initial', () {
      test('has correct status', () {
        const state = AppState();
        expect(state.status, AppStatus.initial);
        expect(state.user, User.empty);
      });
    });

    group('authenticated', () {
      test('has correct status', () {
        final user = MockUser();
        final state = const AppState().authenticated(user);
        expect(state.status, AppStatus.authenticated);
        expect(state.user, user);
      });
    });

    group('unauthenticated', () {
      test('has correct status', () {
        final state = const AppState().unauthenticated();
        expect(state.status, AppStatus.unauthenticated);
        expect(state.user, User.empty);
      });
    });
  });
}
