import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helper.dart';

class MockThemeCubit extends MockCubit<ThemeState> implements ThemeCubit {}

void main() {
  const lightThemeButtonKey = Key('themePage_lightThemeButton');
  const darkThemeButtonKey = Key('themePage_darkThemeButton');
  const systemThemeButtonKey = Key('themePage_systemThemeButton');

  group('ThemePage', () {
    late ThemeCubit themeCubit;

    test('is routable', () {
      expect(ThemePage.route(), isA<MaterialPageRoute<void>>());
    });

    group('renders', () {
      testWidgets('renders ThemeView', (tester) async {
        await tester.pumpApp(const ThemePage());
        expect(find.byType(ThemeView), findsOneWidget);
      });
    });

    group('calls', () {
      setUp(() {
        themeCubit = MockThemeCubit();
        when(() => themeCubit.state).thenReturn(const ThemeState());
      });

      testWidgets('invikes themeModeChanged when tap _LightThemeButton',
          (tester) async {
        when(
          () => themeCubit.themeModeChanged(ThemeMode.light),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: themeCubit,
            child: const Scaffold(body: ThemeView()),
          ),
        );
        await tester.tap(find.byKey(lightThemeButtonKey));
        await tester.pump();
        verify(() => themeCubit.themeModeChanged(ThemeMode.light)).called(1);
      });

      testWidgets('invikes themeModeChanged when tap _DarkThemeButton',
          (tester) async {
        when(
          () => themeCubit.themeModeChanged(ThemeMode.dark),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: themeCubit,
            child: const Scaffold(body: ThemeView()),
          ),
        );
        await tester.tap(find.byKey(darkThemeButtonKey));
        await tester.pump();
        verify(() => themeCubit.themeModeChanged(ThemeMode.dark)).called(1);
      });

      testWidgets('invikes themeModeChanged when tap _SystemThemeButton',
          (tester) async {
        when(
          () => themeCubit.themeModeChanged(ThemeMode.system),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: themeCubit,
            child: const Scaffold(body: ThemeView()),
          ),
        );
        await tester.tap(find.byKey(systemThemeButtonKey));
        await tester.pump();
        verify(() => themeCubit.themeModeChanged(ThemeMode.system)).called(1);
      });
    });
  });
}
