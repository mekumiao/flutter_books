import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/language/language.dart';
import 'package:configuration_repository/configuration_repository.dart';
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

  group('LanguageCubit', () {
    test('initial state is initial when user is empty', () {
      expect(
        LanguageCubit(configurationRepository: configurationRepository).state,
        const LanguageState(),
      );
    });
  });

  group('languageCodeChanged', () {
    blocTest<LanguageCubit, LanguageState>(
      'invokes updateConfig',
      setUp: () {},
      build: () => LanguageCubit(
        configurationRepository: configurationRepository,
      ),
      act: (cubit) => cubit.languageCodeChanged('zh'),
      seed: () => const LanguageState(),
      expect: () => [
        const LanguageState(languageCode: 'zh'),
      ],
      verify: (_) {
        verify(
          () => configurationRepository.updateConfig(
            languageCode: 'zh',
          ),
        ).called(1);
      },
    );
  });
}
