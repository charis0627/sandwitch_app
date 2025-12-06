// Comprehensive widget tests for CartScreen

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/cart_screen.dart';

void main() {
  group('CartScreen widget tests', () {
    testWidgets('displays empty cart message when cart is empty',
        (WidgetTester tester) async {
      final cart = Cart();

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      expect(find.text('Your cart is empty'), findsOneWidget);
      expect(find.byType(ListView), findsNothing);
    });

    testWidgets('displays cart items with correct details',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      cart.add(sandwich1, 2);
      cart.add(sandwich2, 1);

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      // Check that ListView is displayed
      expect(find.byType(ListView), findsOneWidget);

      // Check for sandwich names
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);

      // Check for size and bread details
      expect(find.text('Footlong • white bread • Qty: 2'), findsOneWidget);
      expect(find.text('Six-inch • wheat bread • Qty: 1'), findsOneWidget);

      // Check for prices (Veggie Delight footlong: 7.50 * 2 = 15.00)
      expect(find.text('\$15.00'), findsOneWidget);
      // Chicken Teriyaki six-inch: 5.00 * 1 = 5.00
      expect(find.text('\$5.00'), findsOneWidget);
    });

    testWidgets('displays correct total price in bottom navigation bar',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sandwich2 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      cart.add(sandwich1, 1); // 7.50
      cart.add(sandwich2, 2); // 5.00 * 2 = 10.00

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      // Check for total label
      expect(find.text('Total:'), findsOneWidget);
      // Check for total price (7.50 + 10.00 = 17.50)
      expect(find.text('\$17.50'), findsOneWidget);
    });

    testWidgets('does not display bottom navigation bar when cart is empty',
        (WidgetTester tester) async {
      final cart = Cart();

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      expect(find.text('Total:'), findsNothing);
    });

    testWidgets('displays multiple items correctly',
        (WidgetTester tester) async {
      final cart = Cart();
      final sandwich1 = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: true,
        breadType: BreadType.white,
      );
      final sandwich2 = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );
      final sandwich3 = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );

      cart.add(sandwich1, 1);
      cart.add(sandwich2, 3);
      cart.add(sandwich3, 2);

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      // Check for all ListTile cards
      expect(find.byType(Card), findsNWidgets(3));
      expect(find.byType(ListTile), findsNWidgets(3));

      // Check for all sandwich names
      expect(find.text('Veggie Delight'), findsOneWidget);
      expect(find.text('Chicken Teriyaki'), findsOneWidget);
      expect(find.text('Meatball Marinara'), findsOneWidget);
    });

    testWidgets('displays correct icons', (WidgetTester tester) async {
      final cart = Cart();
      final sandwich = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.white,
      );

      cart.add(sandwich, 1);

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      // Check for fastfood icon in ListTile
      expect(find.byIcon(Icons.fastfood), findsOneWidget);
    });

    testWidgets('back button navigates back', (WidgetTester tester) async {
      final cart = Cart();

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: Builder(
              builder: (context) => ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CartScreen(cart: cart),
                    ),
                  );
                },
                child: const Text('Go to Cart'),
              ),
            ),
          ),
        ),
      );

      // Tap button to navigate to CartScreen
      await tester.tap(find.text('Go to Cart'));
      await tester.pumpAndSettle();

      // Verify we're on CartScreen
      expect(find.text('Cart'), findsOneWidget);

      // Tap back button
      await tester.tap(find.byType(BackButton));
      await tester.pumpAndSettle();

      // Verify we're back to the original screen
      expect(find.text('Go to Cart'), findsOneWidget);
      expect(find.text('Cart'), findsNothing);
    });

    testWidgets('calculates total correctly with mixed items',
        (WidgetTester tester) async {
      final cart = Cart();

      // Add various combinations
      cart.add(
        Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: true,
          breadType: BreadType.white,
        ),
        2,
      ); // 7.50 * 2 = 15.00

      cart.add(
        Sandwich(
          type: SandwichType.veggieDelight,
          isFootlong: false,
          breadType: BreadType.wheat,
        ),
        1,
      ); // 4.50 * 1 = 4.50

      cart.add(
        Sandwich(
          type: SandwichType.chickenTeriyaki,
          isFootlong: true,
          breadType: BreadType.wholemeal,
        ),
        1,
      ); // 8.00 * 1 = 8.00

      await tester.pumpWidget(
        MaterialApp(
          home: CartScreen(cart: cart),
        ),
      );

      // Total should be 15.00 + 4.50 + 8.00 = 27.50
      expect(find.text('\$27.50'), findsOneWidget);
    });
  });
}
