import 'package:booksapp/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('SplashPage', () {
    test('is routable', () {
      expect(SplashPage.route(), isA<MaterialPageRoute<void>>());
      expect(SplashPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders SplashView', (tester) async {
      await tester.pumpApp(const SplashPage());
      expect(find.byType(SplashView), findsOneWidget);
    });
  });
}
