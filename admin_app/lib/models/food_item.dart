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
    switch (category.toLowerCase()) {
      case 'burger':
        return '🍔';
      case 'pizza':
        return '🍕';
      case 'sides':
      case 'fries':
        return '🍟';
      case 'sandwich':
        return '🥪';
      case 'rice':
      case 'biryani':
        return '🍛';
      case 'drinks':
      case 'beverages':
        return '🥤';
      case 'dessert':
        return '🍰';
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
  }) {
    return FoodItem(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      price: price ?? this.price,
      category: category ?? this.category,
      imageUrl: imageUrl ?? this.imageUrl,
      available: available ?? this.available,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'category': category,
      'imageUrl': imageUrl,
      'available': available,
    };
  }

  factory FoodItem.fromMap(Map<String, dynamic> map) {
    return FoodItem(
      id: map['id'] ?? '',
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] as num?)?.toDouble() ?? 0.0,
      category: map['category'] ?? 'General',
      imageUrl: map['imageUrl'] ?? '',
      available: map['available'] ?? true,
    );
  }
}
