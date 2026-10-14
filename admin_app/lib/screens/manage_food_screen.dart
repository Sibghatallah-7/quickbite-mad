import 'package:flutter/material.dart';
import '../services/food_service.dart';
import '../widgets/admin_food_card.dart';
import 'add_edit_food_screen.dart';

class ManageFoodScreen extends StatefulWidget {
  const ManageFoodScreen({super.key});

  @override
  State<ManageFoodScreen> createState() => _ManageFoodScreenState();
}

class _ManageFoodScreenState extends State<ManageFoodScreen> {
  final FoodService _foodService = FoodService();
  String _selectedCategory = 'All';
  String _searchQuery = '';

  void _refreshList() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final allItems = _foodService.getAllFoodItems();
    final categories = ['All', ..._foodService.getCategories()];

    final filteredItems = allItems.where((item) {
      final matchesCategory = _selectedCategory == 'All' || item.category == _selectedCategory;
      final matchesSearch = item.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
          item.description.toLowerCase().contains(_searchQuery.toLowerCase());
      return matchesCategory && matchesSearch;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Food Menu', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const AddEditFoodScreen()),
          );
          _refreshList();
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Food'),
      ),
      body: Column(
        children: [
          // Search Field
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Search food items...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 10),
              ),
              onChanged: (val) {
                setState(() => _searchQuery = val);
              },
            ),
          ),

          // Category Chips
          SizedBox(
            height: 48,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                final isSelected = cat == _selectedCategory;
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text(cat),
                    selected: isSelected,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() => _selectedCategory = cat);
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 8),

          // Food List
          Expanded(
            child: filteredItems.isEmpty
                ? const Center(
                    child: Text(
                      'No food items found.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  )
                : ListView.builder(
                    itemCount: filteredItems.length,
                    itemBuilder: (context, index) {
                      final item = filteredItems[index];
                      return AdminFoodCard(
                        foodItem: item,
                        onEdit: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => AddEditFoodScreen(foodItem: item),
                            ),
                          );
                          _refreshList();
                        },
                        onToggleAvailability: (val) {
                          _foodService.toggleAvailability(item.id);
                          _refreshList();
                        },
                        onDelete: () {
                          _foodService.deleteFoodItem(item.id);
                          _refreshList();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Deleted "${item.name}"')),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
