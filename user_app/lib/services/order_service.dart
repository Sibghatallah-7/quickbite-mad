import 'package:flutter/foundation.dart';
import '../models/cart_item.dart';
import '../models/order_model.dart';

class OrderService extends ChangeNotifier {
  final List<OrderModel> _orders = [
    OrderModel(
      id: 'ORD-1001',
      items: [],
      totalAmount: 18.48,
      status: 'Delivered',
      deliveryAddress: '123 Food Street, Gourmet City',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
    ),
  ];

  List<OrderModel> get orders => List.unmodifiable(_orders);
  OrderModel? _activeOrder;

  OrderModel? get activeOrder => _activeOrder;

  Future<OrderModel> placeOrder(List<CartItem> items, double totalAmount, String address) async {
    await Future.delayed(const Duration(seconds: 1));
    final newOrder = OrderModel(
      id: 'ORD-${DateTime.now().millisecondsSinceEpoch.toString().substring(7)}',
      items: List.from(items),
      totalAmount: totalAmount,
      status: 'Preparing',
      deliveryAddress: address,
      createdAt: DateTime.now(),
    );
    _orders.insert(0, newOrder);
    _activeOrder = newOrder;
    notifyListeners();

    // Simulate order progress
    _simulateOrderProgress(newOrder.id);

    return newOrder;
  }

  void _simulateOrderProgress(String orderId) async {
    await Future.delayed(const Duration(seconds: 5));
    _updateStatus(orderId, 'On the Way');
    await Future.delayed(const Duration(seconds: 6));
    _updateStatus(orderId, 'Delivered');
    if (_activeOrder?.id == orderId) {
      _activeOrder = null;
    }
    notifyListeners();
  }

  void _updateStatus(String orderId, String newStatus) {
    final index = _orders.indexWhere((o) => o.id == orderId);
    if (index >= 0) {
      final old = _orders[index];
      _orders[index] = OrderModel(
        id: old.id,
        items: old.items,
        totalAmount: old.totalAmount,
        status: newStatus,
        deliveryAddress: old.deliveryAddress,
        createdAt: old.createdAt,
      );
      if (_activeOrder?.id == orderId) {
        _activeOrder = _orders[index];
      }
      notifyListeners();
    }
  }
}
