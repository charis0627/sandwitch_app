import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Cart model', () {
    test('add increases items and totalQuantity, totals update', () {
      final cart = Cart();

      final s1 = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.white,
      );

      cart.add(s1);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 1);
      expect(cart.totalPricePence(), 700);
      expect(cart.totalPriceFormatted(), '£7.00');

      // add same sandwich again -> quantity increases
      cart.add(s1, 1);
      expect(cart.items.length, 1);
      expect(cart.totalQuantity, 2);
      expect(cart.totalPricePence(), 1400);
    });

    test('adding distinct sandwiches creates separate items and sums prices',
        () {
      final cart = Cart();

      final six = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      final foot = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      cart.add(six, 2); // 2 * 700 = 1400
      cart.add(foot, 1); // 1 * 1100 = 1100

      expect(cart.items.length, 2);
      expect(cart.totalQuantity, 3);
      expect(cart.totalPricePence(), 2500);
      expect(cart.totalPriceFormatted(), '£25.00');
    });

    test(
        'remove decreases quantity and removes item when quantity reaches zero',
        () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );

      cart.add(s, 3);
      expect(cart.totalQuantity, 3);

      cart.remove(s); // remove 1
      expect(cart.totalQuantity, 2);

      cart.remove(s, 2); // remove remaining
      expect(cart.totalQuantity, 0);
      expect(cart.items.length, 0);
    });

    test('removeItem removes item regardless of quantity', () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.meatballMarinara,
        isFootlong: true,
        breadType: BreadType.wholemeal,
      );

      cart.add(s, 5);
      expect(cart.items.length, 1);

      cart.removeItem(s);
      expect(cart.items.length, 0);
      expect(cart.isEmpty, isTrue);
    });

    test('setQuantity sets value, and negative quantity is ignored', () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      cart.setQuantity(s, 4);
      expect(cart.totalQuantity, 4);

      cart.setQuantity(s, 0);
      expect(cart.items.length, 0);

      // negative quantity ignored
      cart.setQuantity(s, -2);
      expect(cart.items.length, 0);
    });

    test('clear empties the cart', () {
      final cart = Cart();
      final s = Sandwich(
        type: SandwichType.veggieDelight,
        isFootlong: false,
        breadType: BreadType.white,
      );

      cart.add(s, 2);
      expect(cart.isEmpty, isFalse);
      cart.clear();
      expect(cart.isEmpty, isTrue);
    });
  });
}
