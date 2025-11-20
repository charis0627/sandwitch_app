import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/models/sandwich.dart';

void main() {
  group('Sandwich model', () {
    test('name getter returns friendly names for each SandwichType', () {
      final expected = {
        SandwichType.veggieDelight: 'Veggie Delight',
        SandwichType.chickenTeriyaki: 'Chicken Teriyaki',
        SandwichType.tunaMelt: 'Tuna Melt',
        SandwichType.meatballMarinara: 'Meatball Marinara',
      };

      for (final entry in expected.entries) {
        final sandwich = Sandwich(
          type: entry.key,
          isFootlong: true,
          breadType: BreadType.white,
        );
        expect(sandwich.name, entry.value);
      }
    });

    test('image returns correct asset path for footlong and six-inch', () {
      final footlong = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: true,
        breadType: BreadType.wheat,
      );

      final sixInch = Sandwich(
        type: SandwichType.chickenTeriyaki,
        isFootlong: false,
        breadType: BreadType.wheat,
      );

      expect(footlong.image,
          'assets/images/${SandwichType.chickenTeriyaki.name}_footlong.png');
      expect(sixInch.image,
          'assets/images/${SandwichType.chickenTeriyaki.name}_six_inch.png');
    });

    test('properties preserve values (isFootlong and breadType)', () {
      final s = Sandwich(
        type: SandwichType.tunaMelt,
        isFootlong: false,
        breadType: BreadType.wholemeal,
      );

      expect(s.type, SandwichType.tunaMelt);
      expect(s.isFootlong, isFalse);
      expect(s.breadType, BreadType.wholemeal);
    });
  });
}
