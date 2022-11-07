import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/home/home.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('HomeBloc', () {
    late AuthenticationRepository authenticationRepository;

    setUp(() {
      setHydratedStorage();
      authenticationRepository = createMockAuthenticationRepository();
    });

    test('initial state is initial when user is empty', () {
      expect(
        HomeBloc(
          authenticationRepository: authenticationRepository,
        ).state,
        HomeState.empty,
      );
    });

    group('TabChanged', () {
      blocTest<HomeBloc, HomeState>(
        'change tabIndex',
        setUp: () {},
        build: () => HomeBloc(
          authenticationRepository: authenticationRepository,
        ),
        act: (bloc) => bloc.add(const TabChanged(3)),
        expect: () => [const HomeState(index: 3)],
      );
    });
  });
}
