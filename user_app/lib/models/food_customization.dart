enum CustomizationLevel {
  none,
  easy,
  regular,
  extra;

  String get displayName {
    switch (this) {
      case CustomizationLevel.none:
        return 'None';
      case CustomizationLevel.easy:
        return 'Easy';
      case CustomizationLevel.regular:
        return 'Regular';
      case CustomizationLevel.extra:
        return 'Extra';
    }
  }
}

class IngredientCustomization {
  final String name;
  final String emoji;
  CustomizationLevel selectedLevel;

  IngredientCustomization({
    required this.name,
    required this.emoji,
    this.selectedLevel = CustomizationLevel.regular,
  });

  IngredientCustomization copyWith({
    String? name,
    String? emoji,
    CustomizationLevel? selectedLevel,
  }) {
    return IngredientCustomization(
      name: name ?? this.name,
      emoji: emoji ?? this.emoji,
      selectedLevel: selectedLevel ?? this.selectedLevel,
    );
  }
}

class FoodUpgrade {
  final String name;
  final double price;
  final int calories;
  bool isSelected;

  FoodUpgrade({
    required this.name,
    required this.price,
    required this.calories,
    this.isSelected = false,
  });
}
