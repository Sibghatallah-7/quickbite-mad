import 'package:flutter/material.dart';
import '../models/order_model.dart';

class AdminOrderCard extends StatelessWidget {
  final OrderModel order;
  final ValueChanged<OrderStatus> onStatusChanged;

  const AdminOrderCard({
    super.key,
    required this.order,
    required this.onStatusChanged,
  });

  Color _getStatusColor(OrderStatus status) {
    switch (status) {
      case OrderStatus.pending:
        return Colors.orange;
      case OrderStatus.preparing:
        return Colors.blue;
      case OrderStatus.ready:
        return Colors.purple;
      case OrderStatus.delivered:
        return Colors.green;
      case OrderStatus.cancelled:
        return Colors.red;
    }
  }

  String _formatTime(DateTime time) {
    final hour = time.hour > 12 ? time.hour - 12 : (time.hour == 0 ? 12 : time.hour);
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.hour >= 12 ? 'PM' : 'AM';
    return '$hour:$minute $period';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final statusColor = _getStatusColor(order.status);

    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          children: [
            // Header Row: Order ID & Status Badge
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const Icon(Icons.receipt_long, size: 20, color: Colors.deepOrange),
                    const SizedBox(width: 8),
                    Text(
                      order.id,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: statusColor.withOpacity(0.5)),
                  ),
                  child: Text(
                    order.status.displayName,
                    style: TextStyle(
                      color: statusColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
            const Divider(height: 20),

            // Customer Info
            Row(
              children: [
                const Icon(Icons.person_outline, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  order.customerName,
                  style: const TextStyle(fontWeight: FontWeight.w600),
                ),
                const Spacer(),
                const Icon(Icons.phone_outlined, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  order.customerPhone,
                  style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                ),
              ],
            ),
            const SizedBox(height: 6),
            Row(
              crossAxisAlignment: CrossAlignment.start,
              children: [
                const Icon(Icons.location_on_outlined, size: 18, color: Colors.grey),
                const SizedBox(width: 6),
                Expanded(
                  child: Text(
                    order.deliveryAddress,
                    style: TextStyle(fontSize: 12, color: Colors.grey[700]),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Items List Summary
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: order.items.map((item) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 2),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${item.quantity}x  ${item.foodItem.name}',
                          style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                        ),
                        Text(
                          'Rs. ${item.totalPrice.toStringAsFixed(0)}',
                          style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 12),

            // Footer: Total, Time & Status Changer
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAlignment.start,
                  children: [
                    Text(
                      'Total: Rs. ${order.totalAmount.toStringAsFixed(0)}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: theme.colorScheme.primary,
                      ),
                    ),
                    Text(
                      _formatTime(order.orderTime),
                      style: TextStyle(fontSize: 11, color: Colors.grey[600]),
                    ),
                  ],
                ),

                // Status Dropdown Button
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<OrderStatus>(
                      value: order.status,
                      icon: const Icon(Icons.arrow_drop_down),
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                      onChanged: (newStatus) {
                        if (newStatus != null) {
                          onStatusChanged(newStatus);
                        }
                      },
                      items: OrderStatus.values.map((status) {
                        return DropdownMenuItem<OrderStatus>(
                          value: status,
                          child: Text(status.displayName),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
