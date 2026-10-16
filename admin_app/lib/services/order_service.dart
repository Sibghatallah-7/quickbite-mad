import '../models/order_model.dart';
import '../models/food_item.dart';

class OrderService {
  static final OrderService _instance = OrderService._internal();
  factory OrderService() => _instance;
  OrderService._internal();

  final List<OrderModel> _orders = [
    OrderModel(
      id: 'ORD-1001',
      customerName: 'Ali Khan',
      customerPhone: '+92 300 1234567',
      deliveryAddress: 'House 42, Block B, Johar Town, Lahore',
      items: const [
        OrderItem(
          foodItem: FoodItem(
            id: 'f1',
            name: 'Zinger Burger',
            description: 'Crispy chicken fillet',
            price: 499.0,
            category: 'Burger',
          ),
          quantity: 2,
        ),
        OrderItem(
          foodItem: FoodItem(
            id: 'f6',
            name: 'Chilled Soft Drink',
            description: '500ml beverage',
            price: 120.0,
            category: 'Drinks',
          ),
          quantity: 2,
        ),
      ],
      totalAmount: 1238.0,
      status: OrderStatus.pending,
      orderTime: DateTime.now().subtract(const Duration(minutes: 15)),
    ),
    OrderModel(
      id: 'ORD-1002',
      customerName: 'Fatima Ahmed',
      customerPhone: '+92 321 9876543',
      deliveryAddress: 'Apartment 3B, Gulberg Heights, Lahore',
      items: const [
        OrderItem(
          foodItem: FoodItem(
            id: 'f2',
            name: 'Pepperoni Pizza',
            description: 'Mozzarella & spicy pepperoni',
            price: 1199.0,
            category: 'Pizza',
          ),
          quantity: 1,
        ),
        OrderItem(
          foodItem: FoodItem(
            id: 'f3',
            name: 'Loaded Cheese Fries',
            description: 'Potato fries with cheddar sauce',
            price: 349.0,
            category: 'Sides',
          ),
          quantity: 1,
        ),
      ],
      totalAmount: 1548.0,
      status: OrderStatus.preparing,
      orderTime: DateTime.now().subtract(const Duration(minutes: 45)),
    ),
    OrderModel(
      id: 'ORD-1003',
      customerName: 'Usman Raza',
      customerPhone: '+92 333 4567890',
      deliveryAddress: 'Street 12, Sector F-7, Islamabad',
      items: const [
        OrderItem(
          foodItem: FoodItem(
            id: 'f5',
            name: 'Chicken Biryani',
            description: 'Basmati rice with chicken',
            price: 380.0,
            category: 'Rice',
          ),
          quantity: 3,
        ),
      ],
      totalAmount: 1140.0,
      status: OrderStatus.delivered,
      orderTime: DateTime.now().subtract(const Duration(hours: 3)),
    ),
  ];

  List<OrderModel> getAllOrders() {
    return List.unmodifiable(_orders);
  }

  List<OrderModel> getOrdersByStatus(OrderStatus status) {
    return _orders.where((order) => order.status == status).toList();
  }

  void updateOrderStatus(String orderId, OrderStatus newStatus) {
    final index = _orders.indexWhere((order) => order.id == orderId);
    if (index != -1) {
      _orders[index] = _orders[index].copyWith(status: newStatus);
    }
  }

  int get totalOrdersCount => _orders.length;

  int get pendingOrdersCount =>
      _orders.where((o) => o.status == OrderStatus.pending || o.status == OrderStatus.preparing).length;

  double get totalRevenue => _orders
      .where((o) => o.status != OrderStatus.cancelled)
      .fold(0.0, (sum, order) => sum + order.totalAmount);
}
