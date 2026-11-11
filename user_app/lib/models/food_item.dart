import 'food_customization.dart';

class IngredientItem {
  final String name;
  final String emoji;
  final String colorHex;

  const IngredientItem({
    required this.name,
    required this.emoji,
    this.colorHex = 'FFFFE082',
  });
}

class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final bool available;
  final double rating;
  final int likes;
  final int calories;
  final List<IngredientItem> ingredients;
  final List<IngredientCustomization> customizations;
  final List<FoodUpgrade> popularUpgrades;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl = '',
    this.available = true,
    this.rating = 4.8,
    this.likes = 25,
    this.calories = 450,
    this.ingredients = const [],
    this.customizations = const [],
    this.popularUpgrades = const [],
  });

  String get emoji {
    switch (category) {
      case 'Burger':
      case 'Burgers':
        return '🍔';
      case 'Pizza':
        return '🍕';
      case 'Sides':
      case 'Snacks & Sides':
        return '🍟';
      case 'Sandwich':
        return '🥪';
      case 'Rice':
        return '🍛';
      case 'Drinks':
        return '🥤';
      case 'Tacos':
        return '🌮';
      default:
        return '🍽️';
    }
  }

  FoodItem copyWith({
    String? id,
    String? name,
    String? description,
    double? price,
    String? category,
    String? imageUrl,
    bool? available,
    double? rating,
    int? likes,
    int? calories,
    List<IngredientItem>? ingredients,
    List<IngredientCustomization>? customizations,
    List<FoodUpgrade>? popularUpgrades,
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      available: available ?? this.available,
      rating: rating ?? this.rating,
      likes: likes ?? this.likes,
      calories: calories ?? this.calories,
      ingredients: ingredients ?? this.ingredients,
      customizations: customizations ?? this.customizations,
      popularUpgrades: popularUpgrades ?? this.popularUpgrades,
    );
  }
}
