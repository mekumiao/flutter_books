import 'package:booksapp/login/login.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('LoginPage', () {
    test('is routable', () {
      expect(LoginPage.route(), isA<MaterialPageRoute<void>>());
      expect(LoginPage.page(), isA<MaterialPage<void>>());
    });

    testWidgets('renders LoginView', (tester) async {
      await tester.pumpApp(const LoginPage());
      expect(find.byType(LoginView), findsOneWidget);
    });
  });
}
