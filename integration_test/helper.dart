import 'package:api/api.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:booksapp/app/app.dart';
import 'package:booksapp/bootstrap.dart' show setupWindow;
import 'package:configuration_repository/configuration_repository.dart';
import 'package:environment_variable/environment_variable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:mock_api/mock_api.dart';
import 'package:mocktail/mocktail.dart';

void ensureInitialized() {
  Env.staging();
  setupWindow();
}

class MockStorage extends Mock implements Storage {}

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

ConfigurationRepository _createConfigurationRepository() {
  final store = MemoryStorage(const LocalStorageModel(languageCode: 'en'));
  return ConfigurationRepository(store: store);
}

extension PumpApp on WidgetTester {
  Future<void> pumpApp(
    Widget widget, {
    VersionApi? versionApi,
    AuthenticationRepository? authenticationRepository,
    ConfigurationRepository? configurationRepository,
  }) {
    setHydratedStorage();
    return pumpWidget(
      App(
        versionApi: versionApi ?? const MockVersionApi(),
        authenticationRepository:
            authenticationRepository ?? AuthenticationRepository.mock(),
        configurationRepository:
            configurationRepository ?? _createConfigurationRepository(),
        adaptResultCallback: AdaptToken.none,
        child: AppView(child: widget),
      ),
    );
  }

  Future<void> pumpRoute(Route<dynamic> route) {
    return pumpApp(Navigator(onGenerateRoute: (_) => route));
  }
}
