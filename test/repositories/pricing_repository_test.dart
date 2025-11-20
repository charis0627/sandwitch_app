import 'package:flutter_test/flutter_test.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

void main() {
  group('PricingRepository', () {
    test('returns 0 pence for zero quantity (six-inch)', () {
      final repo = PricingRepository();
      final pence = repo.totalPrice(quantity: 0, size: SandwichSize.sixinch);
      expect(pence, 0);
    });

    test('calculates correct pence for one six-inch', () {
      final repo = PricingRepository();
      final pence = repo.totalPrice(quantity: 1, size: SandwichSize.sixinch);
      expect(pence, 700);
    });

    test('calculates correct pence for three footlong', () {
      final repo = PricingRepository();
      final pence = repo.totalPrice(quantity: 3, size: SandwichSize.footlong);
      expect(pence, 3300);
    });

    test('returns pounds as double correctly', () {
      final repo = PricingRepository();
      final pounds =
          repo.totalPricePounds(quantity: 2, size: SandwichSize.sixinch);
      expect(pounds, 14.0);
    });

    test('formats price string correctly', () {
      final repo = PricingRepository();
      final formatted =
          repo.totalPriceFormatted(quantity: 3, size: SandwichSize.footlong);
      expect(formatted, '£33.00');
    });

    test('clamps negative quantity to zero', () {
      final repo = PricingRepository();
      final pence = repo.totalPrice(quantity: -5, size: SandwichSize.footlong);
      expect(pence, 0);
    });
  });
}
