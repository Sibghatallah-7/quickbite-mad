class FoodItem {
  final String id;
  final String name;
  final String description;
  final double price;
  final String category;
  final String imageUrl;
  final bool available;

  const FoodItem({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.category,
    this.imageUrl = '',
    this.available = true,
  });

  String get emoji {
    switch (category) {
      case 'Burger':
        return '🍔';
      case 'Pizza':
        return '🍕';
      case 'Sides':
        return '🍟';
      case 'Sandwich':
        return '🥪';
      case 'Rice':
        return '🍛';
      case 'Drinks':
        return '🥤';
      default:
        return '🍽️';
    }
  }
}