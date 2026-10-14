import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/cart_service.dart';
import 'checkout_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Cart')),
      body: Consumer<CartService>(
        builder: (context, cart, child) {
          if (cart.items.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.shopping_cart_outlined, size: 80, color: Colors.grey),
                  SizedBox(height: 16),
                  Text('Your cart is empty', style: TextStyle(fontSize: 18, color: Colors.grey)),
                ],
              ),
            );
          }
          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: cart.items.length,
                  itemBuilder: (context, index) {
                    final item = cart.items[index];
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Row(
                          children: [
                            Text(item.food.emoji, style: const TextStyle(fontSize: 40)),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(item.food.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                  const SizedBox(height: 4),
                                  Text('\$${item.food.price.toStringAsFixed(2)}', style: const TextStyle(color: Colors.orange)),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.remove, size: 18),
                                  onPressed: () => cart.updateQuantity(item.food.id, item.quantity - 1),
                                ),
                                Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                                IconButton(
                                  icon: const Icon(Icons.add, size: 18),
                                  onPressed: () => cart.updateQuantity(item.food.id, item.quantity + 1),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(color: Colors.grey.withOpacity(0.2), blurRadius: 10, offset: const Offset(0, -4)),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text('Total Amount:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.orange)),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.orange,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const CheckoutScreen()),
                          );
                        },
                        child: const Text('Proceed to Checkout', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
