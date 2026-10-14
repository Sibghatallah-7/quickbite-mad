import 'food_item.dart';

class CartItem {
  final FoodItem food;
  int quantity;

  CartItem({required this.food, this.quantity = 1});

  double get subtotal => food.price * quantity;
}