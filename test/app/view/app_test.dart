import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/app/bloc/app_bloc.dart';
import 'package:booksapp/app/view/app.dart';
import 'package:configuration_repository/configuration_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mock_api/mock_api.dart';
import 'package:mocktail/mocktail.dart';

import '../../helper.dart';

class MockAppBloc extends MockBloc<AppEvent, AppState> implements AppBloc {}

void main() {
  group('App', () {
    late AuthenticationRepository authenticationRepository;
    late ConfigurationRepository configurationRepository;
    late User user;

    setUp(() {
      user = MockUser();
      authenticationRepository = createMockAuthenticationRepository();
      configurationRepository = createMockConfigurationRepository();
      when(() => user.isNotEmpty).thenReturn(true);
      when(() => user.isEmpty).thenReturn(false);
      when(() => user.email).thenReturn('test@gmail.com');
    });

    testWidgets('renders AppView', (tester) async {
      await tester.pumpWidget(
        App(
          versionApi: const MockVersionApi(),
          authenticationRepository: authenticationRepository,
          configurationRepository: configurationRepository,
          adaptResultCallback: AdaptToken.none,
        ),
      );
      await tester.pump();
      expect(find.byType(AppView), findsOneWidget);
    });
  });
}
