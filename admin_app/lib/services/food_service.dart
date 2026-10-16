import '../models/food_item.dart';

class FoodService {
  static final FoodService _instance = FoodService._internal();
  factory FoodService() => _instance;
  FoodService._internal();

  final List<FoodItem> _foodItems = [
    const FoodItem(
      id: 'f1',
      name: 'Zinger Burger',
      description: 'Crispy fried chicken fillet with lettuce and mayo in a soft sesame seed bun.',
      price: 499.0,
      category: 'Burger',
      available: true,
    ),
    const FoodItem(
      id: 'f2',
      name: 'Pepperoni Pizza',
      description: 'Classic mozzarella cheese topped with spicy beef pepperoni slices.',
      price: 1199.0,
      category: 'Pizza',
      available: true,
    ),
    const FoodItem(
      id: 'f3',
      name: 'Loaded Cheese Fries',
      description: 'Crispy potato fries smothered in cheddar cheese sauce and jalapeños.',
      price: 349.0,
      category: 'Sides',
      available: true,
    ),
    const FoodItem(
      id: 'f4',
      name: 'Club Sandwich',
      description: 'Triple-decker toasted sandwich with chicken, egg, cheese, lettuce and tomatoes.',
      price: 450.0,
      category: 'Sandwich',
      available: false,
    ),
    const FoodItem(
      id: 'f5',
      name: 'Chicken Biryani',
      description: 'Fragrant basmati rice cooked with spiced chicken and aromatic herbs.',
      price: 380.0,
      category: 'Rice',
      available: true,
    ),
    const FoodItem(
      id: 'f6',
      name: 'Chilled Soft Drink',
      description: '500ml refreshing ice-cold carbonated beverage.',
      price: 120.0,
      category: 'Drinks',
      available: true,
    ),
  ];

  List<FoodItem> getAllFoodItems() {
    return List.unmodifiable(_foodItems);
  }

  List<String> getCategories() {
    final categories = _foodItems.map((e) => e.category).toSet().toList();
    if (!categories.contains('Burger')) categories.add('Burger');
    if (!categories.contains('Pizza')) categories.add('Pizza');
    if (!categories.contains('Sides')) categories.add('Sides');
    if (!categories.contains('Sandwich')) categories.add('Sandwich');
    if (!categories.contains('Rice')) categories.add('Rice');
    if (!categories.contains('Drinks')) categories.add('Drinks');
    return categories;
  }

  FoodItem? getFoodById(String id) {
    try {
      return _foodItems.firstWhere((item) => item.id == id);
    } catch (_) {
      return null;
    }
  }

  void addFoodItem(FoodItem item) {
    _foodItems.add(item);
  }

  void updateFoodItem(FoodItem updatedItem) {
    final index = _foodItems.indexWhere((item) => item.id == updatedItem.id);
    if (index != -1) {
      _foodItems[index] = updatedItem;
    }
  }

  void toggleAvailability(String id) {
    final index = _foodItems.indexWhere((item) => item.id == id);
    if (index != -1) {
      final current = _foodItems[index];
      _foodItems[index] = current.copyWith(available: !current.available);
    }
  }

  void deleteFoodItem(String id) {
    _foodItems.removeWhere((item) => item.id == id);
  }
}
