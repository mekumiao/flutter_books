import 'package:booksapp/home/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../helper.dart';

void main() {
  group('HomePage', () {
    test('is routable', () {
      expect(HomePage.route(), isA<MaterialPageRoute<void>>());
      expect(HomePage.page(), isA<MaterialPage<void>>());
    });

    group('renders', () {
      testWidgets('renders HomeView', (tester) async {
        await tester.pumpApp(const HomePage());
        expect(find.byType(HomeView), findsOneWidget);
      });
    });

    group('calls', () {
      testWidgets('TabChanged when tab BottomNavigationBar', (tester) async {
        await tester.pumpApp(const HomePage());
        await tester.tap(find.byType(InkResponse).last);
        await tester.pump();
        final indexedStack = tester.widget<IndexedStack>(
          find.byType(IndexedStack),
        );
        expect(indexedStack.index, isNot(0));
      });
    });
  });
}
