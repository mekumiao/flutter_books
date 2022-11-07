import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/app/bloc/app_bloc.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

void main() {
  group('AppBloc', () {
    final user = MockUser();
    late AuthenticationRepository authenticationRepository;
    late ConfigurationRepository configurationRepository;

    setUp(() {
      authenticationRepository = createMockAuthenticationRepository();
      configurationRepository = createMockConfigurationRepository();
    });

    test('initial state is initial when user is empty', () {
      expect(
        AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ).state,
        const AppState(),
      );
    });

    group('AppLoaded', () {
      blocTest<AppBloc, AppState>(
        'invokes refreshToken',
        setUp: () {
          when(
            () => authenticationRepository.refreshToken(),
          ).thenAnswer((_) async {});
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        act: (bloc) => bloc.add(AppLoaded()),
        verify: (_) {
          verify(() => authenticationRepository.refreshToken()).called(1);
        },
      );
    });

    group('UserChanged', () {
      blocTest<AppBloc, AppState>(
        'emits authenticated when user is not empty',
        setUp: () {
          when(() => user.isEmpty).thenReturn(false);
          when(() => user.isNotEmpty).thenReturn(true);
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(user),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        seed: AppState.new,
        expect: () => [const AppState().authenticated(user)],
      );

      blocTest<AppBloc, AppState>(
        'emits unauthenticated when user is empty',
        setUp: () {
          when(() => authenticationRepository.user).thenAnswer(
            (_) => Stream.value(User.empty),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        expect: () => [const AppState().unauthenticated()],
      );
    });

    group('LogoutRequested', () {
      blocTest<AppBloc, AppState>(
        'invokes logOut',
        setUp: () {
          when(
            () => authenticationRepository.logOut(),
          ).thenAnswer((_) async {});
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        act: (bloc) => bloc.add(LogoutRequested()),
        verify: (_) {
          verify(() => authenticationRepository.logOut()).called(1);
        },
      );
    });

    group('ThemeModeChanged', () {
      blocTest<AppBloc, AppState>(
        'change themeMode',
        setUp: () {
          when(
            () => configurationRepository.config,
          ).thenAnswer(
            (_) => Stream.value(
              const Config(themeMode: ThemeMode.light),
            ),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        seed: AppState.new,
        expect: () => [const AppState(themeMode: ThemeMode.light)],
      );
    });

    group('LanguageCodeChanged', () {
      blocTest<AppBloc, AppState>(
        'change languageCode',
        setUp: () {
          when(
            () => configurationRepository.config,
          ).thenAnswer(
            (_) => Stream.value(
              const Config(languageCode: 'zh'),
            ),
          );
        },
        build: () => AppBloc(
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
        ),
        seed: AppState.new,
        expect: () => [const AppState(languageCode: 'zh')],
      );
    });
  });
}
