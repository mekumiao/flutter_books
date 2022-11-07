import 'package:bloc_test/bloc_test.dart';
import 'package:booksapp/language/language.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockingjay/mockingjay.dart';

import '../../helper.dart';

class MockLanguageCubit extends MockCubit<LanguageState>
    implements LanguageCubit {}

void main() {
  const chineseLanguageButtonKey = Key('languagePage_chineseLanguageButton');
  const englishLanguageButtonKey = Key('languagePage_englishLanguageButton');
  const systemLanguageButtonKey = Key('languagePage_systemLanguageButton');

  group('LanguagePage', () {
    late LanguageCubit languageCubit;

    test('is routable', () {
      expect(LanguagePage.route(), isA<MaterialPageRoute<void>>());
    });

    group('renders', () {
      testWidgets('renders LanguageView', (tester) async {
        await tester.pumpApp(const LanguagePage());
        expect(find.byType(LanguageView), findsOneWidget);
      });
    });

    group('calls', () {
      setUp(() {
        languageCubit = MockLanguageCubit();
        when(() => languageCubit.state).thenReturn(const LanguageState());
      });

      testWidgets('invikes languageCodeChanged when tap _ChineseLanguageButton',
          (tester) async {
        when(
          () => languageCubit.languageCodeChanged('zh'),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: languageCubit,
            child: const Scaffold(body: LanguageView()),
          ),
        );
        await tester.tap(find.byKey(chineseLanguageButtonKey));
        await tester.pump();
        verify(() => languageCubit.languageCodeChanged('zh')).called(1);
      });

      testWidgets('invikes languageCodeChanged when tap _EnglishLanguageButton',
          (tester) async {
        when(
          () => languageCubit.languageCodeChanged('en'),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: languageCubit,
            child: const Scaffold(body: LanguageView()),
          ),
        );
        await tester.tap(find.byKey(englishLanguageButtonKey));
        await tester.pump();
        verify(() => languageCubit.languageCodeChanged('en')).called(1);
      });

      testWidgets('invikes languageCodeChanged when tap _SystemLanguageButton',
          (tester) async {
        when(
          () => languageCubit.languageCodeChanged(''),
        ).thenAnswer((_) {});

        await tester.pumpMaterialApp(
          BlocProvider.value(
            value: languageCubit,
            child: const Scaffold(body: LanguageView()),
          ),
        );
        await tester.tap(find.byKey(systemLanguageButtonKey));
        await tester.pump();
        verify(() => languageCubit.languageCodeChanged('')).called(1);
      });
    });
  });
}
