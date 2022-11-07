import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/app.dart';
import 'package:booksapp/gen/fonts.gen.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:general_data/general_data.dart';
import 'package:general_widgets/general_widgets.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mocktail/mocktail.dart';

class MockUser extends Mock implements User {}

class MockStorage extends Mock implements Storage {}

class MockAuthenticationRepository extends Mock
    implements AuthenticationRepository {}

class MockConfigurationRepository extends Mock
    implements ConfigurationRepository {}

void setHydratedStorage({Storage? storage}) {
  HydratedBloc.storage = storage ?? _buildMockStorage();
}

Storage _buildMockStorage() {
  TestWidgetsFlutterBinding.ensureInitialized();

  final storage = MockStorage();
  when(() => storage.write(any(), any<dynamic>())).thenAnswer((_) async {});
  when(() => storage.read(any())).thenReturn((_) => null);
  return storage;
}

MaterialApp _buildTestMaterialApp({required Widget home}) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: const [
      ...AppLocalizations.localizationsDelegates,
      GeneralLocalizations.delegate,
    ],
    theme: ThemeDatas.lightThemeData(FontFamily.pingfang),
    themeMode: ThemeMode.light,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

AuthenticationRepository createMockAuthenticationRepository() {
  final authenticationRepository = MockAuthenticationRepository();
  when(() => authenticationRepository.user).thenAnswer(
    (_) => const Stream.empty(),
  );
  when(
    () => authenticationRepository.currentUser,
  ).thenReturn(User.empty);
  return authenticationRepository;
}

ConfigurationRepository createMockConfigurationRepository() {
  final configurationRepository = MockConfigurationRepository();
  when(() => configurationRepository.config).thenAnswer(
    (_) => const Stream.empty(),
  );
  when(
    () => configurationRepository.currentConfig,
  ).thenReturn(Config.empty);
  return configurationRepository;
}

extension PumpX on WidgetTester {
  Future<void> pumpMaterialApp(Widget child) {
    return pumpWidget(_buildTestMaterialApp(home: child));
  }

  Future<void> pumpApp(
    Widget child, {
    AppBloc? appBloc,
    AuthenticationRepository? authenticationRepository,
    ConfigurationRepository? configurationRepository,
  }) {
    setHydratedStorage();
    final authenticationRepositorySecond =
        authenticationRepository ?? createMockAuthenticationRepository();
    final configurationRepositorySecond =
        configurationRepository ?? createMockConfigurationRepository();
    final appBlocSecond = appBloc ??
        AppBloc(
          authenticationRepository: authenticationRepositorySecond,
          configurationRepository: configurationRepositorySecond,
        );

    return pumpWidget(
      MultiRepositoryProvider(
        providers: [
          RepositoryProvider.value(value: authenticationRepositorySecond),
          RepositoryProvider.value(value: configurationRepositorySecond),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider.value(value: appBlocSecond),
          ],
          child: _buildTestMaterialApp(home: child),
        ),
      ),
    );
  }
}
