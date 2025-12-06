import 'package:flutter/material.dart';
import 'package:sandwich_shop/models/cart.dart';
import 'package:sandwich_shop/models/sandwich.dart';
import 'package:sandwich_shop/views/app_styles.dart';

const TextStyle heading2 = TextStyle(
  fontSize: 20,
  fontWeight: FontWeight.bold,
);

class CartScreen extends StatefulWidget {
  final Cart cart;

  const CartScreen({super.key, required this.cart});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  // Helper to compute price for a sandwich using same logic as OrderScreen
  double _priceFor(Sandwich sandwich) {
    const double sixInchBase = 5.0;
    const double footlongExtra = 3.0;
    double base = sixInchBase;
    if (sandwich.type == SandwichType.veggieDelight) {
      base = 4.5;
    }
    return sandwich.isFootlong ? base + footlongExtra : base;
  }

  @override
  Widget build(BuildContext context) {
    final items = widget.cart.items;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cart',
          style: heading1,
        ),
      ),
      body: items.isEmpty
          ? const Center(
              child: Text(
                'Your cart is empty',
                style: heading2,
              ),
            )
          : ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                final sandwich = item.sandwich;
                final unitPrice = _priceFor(sandwich);
                final totalPrice = unitPrice * item.quantity;

                final sizeText = sandwich.isFootlong ? 'Footlong' : 'Six-inch';
                final breadText = sandwich.breadType.name;

                return Card(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: const Icon(Icons.fastfood, size: 40),
                    title: Text(
                      sandwich.name,
                      style: heading2,
                    ),
                    subtitle: Text(
                      '$sizeText • $breadText bread • Qty: ${item.quantity}',
                      style: normalText,
                    ),
                    trailing: Text(
                      '\$${totalPrice.toStringAsFixed(2)}',
                      style: heading2,
                    ),
                  ),
                );
              },
            ),
      bottomNavigationBar: items.isEmpty
          ? null
          : Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey.shade100,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade400,
                    blurRadius: 4,
                    offset: const Offset(0, -2),
                  ),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Total:',
                    style: heading1,
                  ),
                  Text(
                    '\$${_calculateTotal().toStringAsFixed(2)}',
                    style: heading1,
                  ),
                ],
              ),
            ),
    );
  }

  double _calculateTotal() {
    double total = 0.0;
    for (final item in widget.cart.items) {
      final unitPrice = _priceFor(item.sandwich);
      total += unitPrice * item.quantity;
    }
    return total;
  }
}
