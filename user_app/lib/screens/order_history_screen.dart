import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/order_service.dart';

class OrderHistoryScreen extends StatelessWidget {
  const OrderHistoryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: Consumer<OrderService>(
        builder: (context, orderService, child) {
          final orders = orderService.orders;
          if (orders.isEmpty) {
            return const Center(child: Text('No past orders'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                child: ListTile(
                  title: Text(order.id, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${order.createdAt.toLocal().toString().split('.')[0]} • ${order.status}'),
                  trailing: Text('\$${order.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.orange)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
