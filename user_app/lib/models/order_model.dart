import 'cart_item.dart';

class OrderModel {
  final String id;
  final List<CartItem> items;
  final double totalAmount;
  final String status;
  final String deliveryAddress;
  final DateTime createdAt;

  OrderModel({
    required this.id,
    required this.items,
    required this.totalAmount,
    this.status = 'Pending',
    required this.deliveryAddress,
    required this.createdAt,
  });
}
