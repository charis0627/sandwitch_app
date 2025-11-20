import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/repositories/pricing_repository.dart';

/// A CartItem holds a [Sandwich] and the quantity ordered.
class CartItem {
  final Sandwich sandwich;
  int quantity;

  CartItem(this.sandwich, this.quantity)
      : assert(quantity >= 0, 'quantity cannot be negative');
}

/// Simple cart that holds multiple [CartItem]s and computes totals using
/// [PricingRepository].
class Cart {
  final PricingRepository _pricingRepository;
  final List<CartItem> _items = [];

  Cart({PricingRepository? pricingRepository})
      : _pricingRepository = pricingRepository ?? PricingRepository();

  /// Returns an unmodifiable view of cart items.
  List<CartItem> get items => List.unmodifiable(_items);

  /// Returns total number of sandwiches in the cart (sum of quantities).
  int get totalQuantity => _items.fold(0, (s, e) => s + e.quantity);

  /// Returns true when the cart contains no items.
  bool get isEmpty => _items.isEmpty;

  /// Adds [quantity] of [sandwich] to the cart. If the same sandwich (same
  /// type, size and bread) already exists, increments its quantity.
  void add(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final idx = _indexOf(sandwich);
    if (idx >= 0) {
      _items[idx].quantity += quantity;
    } else {
      _items.add(CartItem(sandwich, quantity));
    }
  }

  /// Removes [quantity] of [sandwich] from the cart. If quantity reaches 0,
  /// the item is removed entirely.
  void remove(Sandwich sandwich, [int quantity = 1]) {
    if (quantity <= 0) return;
    final idx = _indexOf(sandwich);
    if (idx < 0) return;
    final item = _items[idx];
    if (quantity >= item.quantity) {
      _items.removeAt(idx);
    } else {
      item.quantity -= quantity;
    }
  }

  /// Set the exact [quantity] for a sandwich; if [quantity] is 0 the item is
  /// removed.
  void setQuantity(Sandwich sandwich, int quantity) {
    if (quantity < 0) return;
    final idx = _indexOf(sandwich);
    if (idx < 0) {
      if (quantity > 0) _items.add(CartItem(sandwich, quantity));
      return;
    }
    if (quantity == 0) {
      _items.removeAt(idx);
    } else {
      _items[idx].quantity = quantity;
    }
  }

  /// Remove the item completely regardless of quantity.
  void removeItem(Sandwich sandwich) {
    final idx = _indexOf(sandwich);
    if (idx >= 0) _items.removeAt(idx);
  }

  /// Clear all items from the cart.
  void clear() => _items.clear();

  int _indexOf(Sandwich sandwich) {
    for (var i = 0; i < _items.length; i++) {
      if (_sameSandwich(_items[i].sandwich, sandwich)) return i;
    }
    return -1;
  }

  bool _sameSandwich(Sandwich a, Sandwich b) {
    return a.type == b.type &&
        a.isFootlong == b.isFootlong &&
        a.breadType == b.breadType;
  }

  /// Compute total price in pence across all cart items.
  int totalPricePence() {
    var total = 0;
    for (final item in _items) {
      final size = item.sandwich.isFootlong
          ? SandwichSize.footlong
          : SandwichSize.sixinch;
      total +=
          _pricingRepository.totalPrice(quantity: item.quantity, size: size);
    }
    return total;
  }

  /// Total price as pounds (double).
  double totalPricePounds() => totalPricePence() / 100.0;

  /// Formatted total price, e.g. "£12.00".
  String totalPriceFormatted() {
    final pence = totalPricePence();
    final pounds = pence ~/ 100;
    final remainder = pence % 100;
    return '£$pounds.${remainder.toString().padLeft(2, '0')}';
  }
}
