import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/order_service.dart';

class OrderTrackingScreen extends StatelessWidget {
  const OrderTrackingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order Status')),
      body: Consumer<OrderService>(
        builder: (context, orderService, child) {
          final activeOrder = orderService.activeOrder;
          if (activeOrder == null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 80, color: Colors.green),
                  const SizedBox(height: 16),
                  const Text('No Active Order', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Your food has been delivered or no order placed yet.', style: TextStyle(color: Colors.grey)),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.orange, foregroundColor: Colors.white),
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Back to Home'),
                  ),
                ],
              ),
            );
          }

          return Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Order ID: ${activeOrder.id}', style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Text('Status: ${activeOrder.status}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.orange)),
                const SizedBox(height: 24),
                const LinearProgressIndicator(color: Colors.orange),
                const SizedBox(height: 32),
                const Text('Delivery Address:', style: TextStyle(fontWeight: FontWeight.bold)),
                Text(activeOrder.deliveryAddress, style: const TextStyle(color: Colors.grey)),
                const SizedBox(height: 24),
                const Text('Items:', style: TextStyle(fontWeight: FontWeight.bold)),
                Expanded(
                  child: ListView.builder(
                    itemCount: activeOrder.items.length,
                    itemBuilder: (context, index) {
                      final item = activeOrder.items[index];
                      return ListTile(
                        leading: Text(item.food.emoji, style: const TextStyle(fontSize: 24)),
                        title: Text(item.food.name),
                        trailing: Text('x${item.quantity}'),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
