import '../models/food_item.dart';

class FoodService {
  final List<FoodItem> _menuItems = [
    const FoodItem(
      id: 'f1',
      name: 'Cheesy Zinger Burger',
      description: 'Crispy fried chicken fillet with double cheese, lettuce, and special mayo sauce.',
      price: 6.99,
      category: 'Burger',
    ),
    const FoodItem(
      id: 'f2',
      name: 'Double Beef Burger',
      description: 'Juicy double beef patties with melted cheddar cheese and smoky BBQ sauce.',
      price: 8.49,
      category: 'Burger',
    ),
    const FoodItem(
      id: 'f3',
      name: 'Pepperoni Supreme Pizza',
      description: 'Loaded with double pepperoni, mozzarella cheese, and Italian herbs.',
      price: 12.99,
      category: 'Pizza',
    ),
    const FoodItem(
      id: 'f4',
      name: 'Fajita Chicken Pizza',
      description: 'Spicy chicken fajita chunks, bell peppers, onions, and jalapeños.',
      price: 13.99,
      category: 'Pizza',
    ),
    const FoodItem(
      id: 'f5',
      name: 'Crispy French Fries',
      description: 'Golden, crispy potato fries seasoned with savory spices.',
      price: 3.49,
      category: 'Sides',
    ),
    const FoodItem(
      id: 'f6',
      name: 'Garlic Mayo Fries',
      description: 'Crispy fries drizzled with creamy garlic mayo sauce.',
      price: 4.49,
      category: 'Sides',
    ),
    const FoodItem(
      id: 'f7',
      name: 'Club Sandwich',
      description: 'Triple-decker sandwich with chicken, egg, cheese, and fresh veggies.',
      price: 5.99,
      category: 'Sandwich',
    ),
    const FoodItem(
      id: 'f8',
      name: 'Chicken Biryani',
      description: 'Traditional aromatic basmati rice cooked with tender spiced chicken.',
      price: 9.99,
      category: 'Rice',
    ),
    const FoodItem(
      id: 'f9',
      name: 'Iced Cold Cola',
      description: 'Refreshing carbonated soft drink served chilled.',
      price: 1.99,
      category: 'Drinks',
    ),
  ];

  List<String> get categories => ['All', 'Burger', 'Pizza', 'Sides', 'Sandwich', 'Rice', 'Drinks'];

  List<FoodItem> getFoodItems({String category = 'All', String searchQuery = ''}) {
    return _menuItems.where((item) {
      final matchesCategory = category == 'All' || item.category == category;
      final matchesSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
