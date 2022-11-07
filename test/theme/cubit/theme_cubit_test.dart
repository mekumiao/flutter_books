import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/theme/theme.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

void main() {
  late ConfigurationRepository configurationRepository;

  setUp(() {
    setHydratedStorage();
    configurationRepository = createMockConfigurationRepository();
    when(
      () => configurationRepository.updateConfig(
        themeMode: any(named: 'themeMode'),
        languageCode: any(named: 'languageCode'),
      ),
    ).thenAnswer((_) async {});
  });

  group('ThemeCubit', () {
    test('initial state is initial when user is empty', () {
      expect(
        ThemeCubit(configurationRepository: configurationRepository).state,
        const ThemeState(),
      );
    });
  });

  group('themeModeChanged', () {
    blocTest<ThemeCubit, ThemeState>(
      'invokes updateConfig',
      setUp: () {},
      build: () => ThemeCubit(
        configurationRepository: configurationRepository,
      ),
      act: (cubit) => cubit.themeModeChanged(ThemeMode.light),
      seed: () => const ThemeState(),
      expect: () => [
        const ThemeState(themeMode: ThemeMode.light),
      ],
      verify: (_) {
        verify(
          () => configurationRepository.updateConfig(
            themeMode: ThemeMode.light,
          ),
        ).called(1);
      },
    );
  });
}
