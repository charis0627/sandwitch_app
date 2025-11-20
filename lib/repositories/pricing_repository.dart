enum SandwichSize { sixinch, footlong }

class PricingRepository {
  PricingRepository();

  static const int sixinchPrice = 700;
  static const int footlongPrice = 1100;

  int totalPrice({required int quantity, required SandwichSize size}) {
    final qty = quantity < 0 ? 0 : quantity;
    final unit = size == SandwichSize.footlong ? footlongPrice : sixinchPrice;
    return qty * unit;
  }

  double totalPricePounds({required int quantity, required SandwichSize size}) {
    return totalPrice(quantity: quantity, size: size) / 100.0;
  }

  String totalPriceFormatted(
      {required int quantity, required SandwichSize size}) {
    final pence = totalPrice(quantity: quantity, size: size);
    final pounds = pence ~/ 100;
    final remainder = pence % 100;
    return '£$pounds.${remainder.toString().padLeft(2, '0')}';
  }
}
