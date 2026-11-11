import '../models/food_item.dart';
import '../models/food_customization.dart';

class FoodService {
  final List<FoodItem> _menuItems = [
    FoodItem(
      id: 'f1',
      name: 'Double Patty Burger',
      description:
          'A delicious burger with two layers of grilled beef patty, arranged on a soft sesame-studded bun. Between the patties is a tantalizing layer of melted cheese, topped with special sauce, fresh lettuce, sliced tomatoes and onions. Served warm with rich flavors and a satisfying portion. Perfect for true burger lovers!',
      price: 20.00,
      category: 'Burgers',
      rating: 4.9,
      likes: 27,
      calories: 620,
      ingredients: const [
        IngredientItem(name: 'Cheese', emoji: '🧀'),
        IngredientItem(name: 'Garlic', emoji: '🧄'),
        IngredientItem(name: 'Lettuce', emoji: '🥬'),
        IngredientItem(name: 'Tomato', emoji: '🍅'),
        IngredientItem(name: 'Egg', emoji: '🥚'),
        IngredientItem(name: 'Sauce', emoji: '🥫'),
      ],
      customizations: [
        IngredientCustomization(name: 'Seasoned beef', emoji: '🥩'),
        IngredientCustomization(name: 'Lettuce', emoji: '🥬'),
        IngredientCustomization(name: 'Cheese', emoji: '🧀'),
      ],
      popularUpgrades: [
        FoodUpgrade(name: 'Extra Cheese', price: 1.50, calories: 60),
        FoodUpgrade(name: 'Bacon Strips', price: 2.00, calories: 90),
        FoodUpgrade(name: 'Special Sauce', price: 0.99, calories: 30),
      ],
    ),
    FoodItem(
      id: 'f2',
      name: 'Cheeseburger',
      description: 'Delicious, juicy, cheesy, double-layered classic beef burger with melted cheddar.',
      price: 23.00,
      category: 'Burgers',
      rating: 4.8,
      likes: 34,
      calories: 550,
      ingredients: const [
        IngredientItem(name: 'Cheese', emoji: '🧀'),
        IngredientItem(name: 'Lettuce', emoji: '🥬'),
        IngredientItem(name: 'Tomato', emoji: '🍅'),
        IngredientItem(name: 'Sauce', emoji: '🥫'),
      ],
      customizations: [
        IngredientCustomization(name: 'Cheddar cheese', emoji: '🧀'),
        IngredientCustomization(name: 'Lettuce', emoji: '🥬'),
      ],
      popularUpgrades: [
        FoodUpgrade(name: 'Extra Patty', price: 3.00, calories: 150),
      ],
    ),
    FoodItem(
      id: 'f3',
      name: 'Grilled Chicken Burger',
      description: 'Delicious, juicy, cheesy, double-layered chicken burger grilled to perfection.',
      price: 28.00,
      category: 'Burgers',
      rating: 4.7,
      likes: 19,
      calories: 480,
      ingredients: const [
        IngredientItem(name: 'Chicken', emoji: '🍗'),
        IngredientItem(name: 'Cheese', emoji: '🧀'),
        IngredientItem(name: 'Lettuce', emoji: '🥬'),
      ],
    ),
    FoodItem(
      id: 'f4',
      name: 'The Crunchtastic Taco',
      description:
          'Dish made with a crispy taco shell, filled with seasoned beef, topped with shredded lettuce, cheese, and your choice of toppings.',
      price: 3.19,
      category: 'Snacks & Sides',
      rating: 4.9,
      likes: 42,
      calories: 170,
      ingredients: const [
        IngredientItem(name: 'Seasoned beef', emoji: '🥩'),
        IngredientItem(name: 'Lettuce', emoji: '🥬'),
        IngredientItem(name: 'Cheese', emoji: '🧀'),
      ],
      customizations: [
        IngredientCustomization(name: 'Seasoned beef', emoji: '🥩'),
        IngredientCustomization(name: 'Lettuce', emoji: '🥬'),
        IngredientCustomization(name: 'Cheese', emoji: '🧀'),
      ],
      popularUpgrades: [
        FoodUpgrade(name: 'Guacamole', price: 0.00, calories: 30),
        FoodUpgrade(name: 'Salsa', price: 0.95, calories: 20),
        FoodUpgrade(name: 'Extra Cheese', price: 1.60, calories: 50),
      ],
    ),
    FoodItem(
      id: 'f5',
      name: 'Crispy French Fries',
      description: 'Golden, crispy potato fries seasoned with savory spices and garlic dip.',
      price: 4.50,
      category: 'Snacks & Sides',
      rating: 4.6,
      likes: 56,
      calories: 310,
    ),
    FoodItem(
      id: 'f6',
      name: 'Iced Cold Cola',
      description: 'Refreshing carbonated soft drink served chilled with ice and lemon slice.',
      price: 2.50,
      category: 'Drinks',
      rating: 4.9,
      likes: 80,
      calories: 140,
    ),
  ];

  List<String> get categories => ['All', 'Burgers', 'Snacks & Sides', 'Drinks'];

  List<FoodItem> getFoodItems({String category = 'All', String searchQuery = ''}) {
    return _menuItems.where((item) {
      final matchesCategory = category == 'All' || item.category == category;
      final matchesSearch = item.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();
  }
}
