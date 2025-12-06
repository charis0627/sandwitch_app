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
          'Cart View',
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
          : Column(
              children: [
                Expanded(
                  child: Center(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 40),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ...items.map((item) {
                            final sandwich = item.sandwich;
                            final unitPrice = _priceFor(sandwich);
                            final totalPrice = unitPrice * item.quantity;

                            final sizeText =
                                sandwich.isFootlong ? 'Footlong' : 'Six-inch';
                            final breadText = sandwich.breadType.name;

                            return Padding(
                              padding: const EdgeInsets.only(bottom: 32),
                              child: Column(
                                children: [
                                  Text(
                                    sandwich.name,
                                    style: const TextStyle(
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Text(
                                    '$sizeText on $breadText bread',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Qty: ${item.quantity} - £${totalPrice.toStringAsFixed(2)}',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black87,
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }).toList(),
                          const SizedBox(height: 16),
                          Text(
                            'Total: £${_calculateTotal().toStringAsFixed(2)}',
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(16),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.arrow_back, color: Colors.white),
                        SizedBox(width: 8),
                        Text(
                          'Back to Order',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
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
