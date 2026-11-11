import 'package:flutter/material.dart';
import '../models/food_customization.dart';
import '../models/food_item.dart';

class CustomizeFoodScreen extends StatefulWidget {
  final FoodItem food;

  const CustomizeFoodScreen({super.key, required this.food});

  @override
  State<CustomizeFoodScreen> createState() => _CustomizeFoodScreenState();
}

class _CustomizeFoodScreenState extends State<CustomizeFoodScreen> {
  late List<IngredientCustomization> _customizations;

  @override
  void initState() {
    super.initState();
    _customizations = widget.food.customizations.isNotEmpty
        ? widget.food.customizations.map((e) => e.copyWith()).toList()
        : [
            IngredientCustomization(name: 'Seasoned beef', emoji: '🥩'),
            IngredientCustomization(name: 'Lettuce', emoji: '🥬'),
            IngredientCustomization(name: 'Cheese', emoji: '🧀'),
          ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Customize',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black87),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Change What's Included Accordion
                  ExpansionTile(
                    initiallyExpanded: true,
                    title: const Text(
                      "Change what's included",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Colors.black87,
                      ),
                    ),
                    children: _customizations.map((item) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(item.emoji, style: const TextStyle(fontSize: 24)),
                                const SizedBox(width: 10),
                                Text(
                                  item.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),

                            // Segmented Level Choices (None, Easy, Regular, Extra)
                            Row(
                              children: CustomizationLevel.values.map((level) {
                                final isSelected = item.selectedLevel == level;
                                return Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 4),
                                    child: ChoiceChip(
                                      label: Center(
                                        child: Text(
                                          level.displayName,
                                          style: TextStyle(
                                            fontSize: 12,
                                            fontWeight:
                                                isSelected ? FontWeight.bold : FontWeight.normal,
                                            color: isSelected ? Colors.black87 : Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      selected: isSelected,
                                      selectedColor: Colors.white,
                                      backgroundColor: Colors.grey[100],
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        side: BorderSide(
                                          color: isSelected ? Colors.black87 : Colors.transparent,
                                          width: isSelected ? 1.5 : 1,
                                        ),
                                      ),
                                      showCheckmark: false,
                                      onSelected: (_) {
                                        setState(() {
                                          item.selectedLevel = level;
                                        });
                                      },
                                    ),
                                  ),
                                );
                              }).toList(),
                            ),
                            const Divider(height: 24),
                          ],
                        ),
                      );
                    }).toList(),
                  ),

                  // Sauces Section Accordion
                  const ExpansionTile(
                    title: Text(
                      'Sauces',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    children: [
                      ListTile(title: Text('Mayonnaise')),
                      ListTile(title: Text('Ketchup')),
                      ListTile(title: Text('Smoky BBQ')),
                    ],
                  ),

                  // Add Ons Accordion
                  const ExpansionTile(
                    title: Text(
                      'Add Ons',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    children: [
                      ListTile(title: Text(r'Jalapeños (+$0.50)')),
                      ListTile(title: Text(r'Extra Patty (+$3.00)')),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Sticky Apply Button
          Padding(
            padding: const EdgeInsets.all(20),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context, _customizations);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.grey[700],
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
