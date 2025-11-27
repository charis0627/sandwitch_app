// Comprehensive widget tests for `OrderScreen` in `main.dart`.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/main.dart';

void main() {
  group('OrderScreen (main.dart) widget tests', () {
    testWidgets('renders OrderScreen as home', (WidgetTester tester) async {
      await tester.pumpWidget(const App());
      expect(find.byType(OrderScreen), findsOneWidget);
    });

    testWidgets('quantity controls increment and decrement',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final quantityLabel = find.text('Quantity: ');
      expect(quantityLabel, findsOneWidget);

      final rowFinder =
          find.ancestor(of: quantityLabel, matching: find.byType(Row));
      expect(rowFinder, findsOneWidget);

      final addBtn = find.descendant(
          of: rowFinder, matching: find.widgetWithIcon(IconButton, Icons.add));
      final removeBtn = find.descendant(
          of: rowFinder,
          matching: find.widgetWithIcon(IconButton, Icons.remove));

      expect(find.descendant(of: rowFinder, matching: find.text('1')),
          findsOneWidget);

      await tester.ensureVisible(addBtn);
      await tester.tap(addBtn);
      await tester.pump();
      expect(find.descendant(of: rowFinder, matching: find.text('2')),
          findsOneWidget);

      await tester.ensureVisible(removeBtn);
      await tester.tap(removeBtn);
      await tester.pump();
      expect(find.descendant(of: rowFinder, matching: find.text('1')),
          findsOneWidget);
    });

    testWidgets('quantity does not go below zero', (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final quantityLabel = find.text('Quantity: ');
      final rowFinder =
          find.ancestor(of: quantityLabel, matching: find.byType(Row));
      expect(rowFinder, findsOneWidget);

      final removeBtn = find.descendant(
          of: rowFinder,
          matching: find.widgetWithIcon(IconButton, Icons.remove));

      // decrement the initial 1 -> 0
      await tester.ensureVisible(removeBtn);
      await tester.tap(removeBtn);
      await tester.pump();
      expect(find.descendant(of: rowFinder, matching: find.text('0')),
          findsOneWidget);

      // try to go below 0
      await tester.tap(removeBtn);
      await tester.pump();
      expect(find.descendant(of: rowFinder, matching: find.text('0')),
          findsOneWidget);
    });

    testWidgets('size Switch toggles and image asset changes to six-inch',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final switchFinder = find.byType(Switch);
      expect(switchFinder, findsOneWidget);

      Switch s = tester.widget<Switch>(switchFinder);
      expect(s.value, isTrue);

      await tester.ensureVisible(switchFinder);
      await tester.tap(switchFinder);
      await tester.pumpAndSettle();

      s = tester.widget<Switch>(switchFinder);
      expect(s.value, isFalse);

      final imageFinder = find.byType(Image);
      final Image img = tester.widget<Image>(imageFinder);
      final provider = img.image as AssetImage;
      expect(provider.assetName, contains('_six_inch'));
    });

    // Note: DropdownMenu widgets are platform/SDK-sensitive and can be
    // flaky in unit tests. We keep tests focused on controls that render
    // reliably in the test environment (image, size switch, quantity, add).

    testWidgets('Add to Cart button enabled/disabled based on quantity',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final addToCartFinder =
          find.widgetWithText(ElevatedButton, 'Add to Cart');
      expect(addToCartFinder, findsOneWidget);
      ElevatedButton btn = tester.widget<ElevatedButton>(addToCartFinder);
      // initial quantity = 1 -> enabled
      expect(btn.onPressed, isNotNull);

      final quantityLabel = find.text('Quantity: ');
      final rowFinder =
          find.ancestor(of: quantityLabel, matching: find.byType(Row));
      expect(rowFinder, findsOneWidget);

      final removeBtn = find.descendant(
          of: rowFinder,
          matching: find.widgetWithIcon(IconButton, Icons.remove));
      await tester.ensureVisible(removeBtn);
      await tester.tap(removeBtn);
      await tester.pump();

      btn = tester.widget<ElevatedButton>(addToCartFinder);
      expect(btn.onPressed, isNull);
    });

    testWidgets('Add to Cart works for multiple quantities (no exceptions)',
        (WidgetTester tester) async {
      await tester.pumpWidget(const App());

      final quantityLabel = find.text('Quantity: ');
      final rowFinder =
          find.ancestor(of: quantityLabel, matching: find.byType(Row));
      expect(rowFinder, findsOneWidget);

      final addBtn = find.descendant(
          of: rowFinder, matching: find.widgetWithIcon(IconButton, Icons.add));
      final addToCartFinder =
          find.widgetWithText(ElevatedButton, 'Add to Cart');

      // make quantity 3
      await tester.ensureVisible(addBtn);
      await tester.tap(addBtn);
      await tester.pump();
      await tester.ensureVisible(addBtn);
      await tester.tap(addBtn);
      await tester.pump();

      expect(addToCartFinder, findsOneWidget);
      await tester.ensureVisible(addToCartFinder);
      await tester.tap(addToCartFinder);
      await tester.pump();

      // app remains on OrderScreen and no exceptions thrown
      expect(find.byType(OrderScreen), findsOneWidget);
    });
  });
}
