import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/food_service.dart';
import '../services/cart_service.dart';
import '../widgets/food_card.dart';
import 'food_details_screen.dart';
import 'cart_screen.dart';
import 'order_history_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FoodService _foodService = FoodService();
  String _selectedCategory = 'Burgers';
  String _searchQuery = '';
  int _currentNavIndex = 0;

  @override
  Widget build(BuildContext context) {
    final categories = _foodService.categories;
    final foodItems = _foodService.getFoodItems(category: _selectedCategory, searchQuery: _searchQuery);

    final List<Widget> pages = [
      _buildHomeContent(categories, foodItems),
      const CartScreen(),
      const OrderHistoryScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF9F9F9),
      body: SafeArea(
        child: IndexedStack(
          index: _currentNavIndex,
          children: pages,
        ),
      ),

      // Custom Bottom Navigation Bar matching Screenshot 2
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 16,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: Consumer<CartService>(
          builder: (context, cart, child) {
            return BottomNavigationBar(
              currentIndex: _currentNavIndex,
              onTap: (index) => setState(() => _currentNavIndex = index),
              type: BottomNavigationBarType.fixed,
              backgroundColor: Colors.transparent,
              elevation: 0,
              selectedItemColor: const Color(0xFFD32F2F),
              unselectedItemColor: Colors.grey[400],
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: [
                const BottomNavigationBarItem(
                  icon: Icon(Icons.home_filled, size: 28),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Badge(
                    label: Text('${cart.itemCount}'),
                    isLabelVisible: cart.itemCount > 0,
                    backgroundColor: const Color(0xFFD32F2F),
                    child: const Icon(Icons.shopping_cart_outlined, size: 26),
                  ),
                  label: 'Cart',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.receipt_long_outlined, size: 26),
                  label: 'Orders',
                ),
                const BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline, size: 28),
                  label: 'Profile',
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(List<String> categories, List<dynamic> foodItems) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Top Bar: Notification, Location Pill, Avatar
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_none, size: 26, color: Colors.black87),
                onPressed: () {},
              ),

              // Location Pill
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.location_on, color: Colors.white, size: 16),
                    SizedBox(width: 4),
                    Text(
                      'Bali, Indonesia',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              // User Avatar
              const CircleAvatar(
                radius: 20,
                backgroundColor: Color(0xFFFFE0B2),
                child: Text('👤', style: TextStyle(fontSize: 20)),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Greeting
          const Text(
            'Hello, Lia!',
            style: TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            "It's time to pamper your tummy.",
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 20),

          // Search Bar & Filter Button Row
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: TextField(
                    onChanged: (val) => setState(() => _searchQuery = val),
                    decoration: InputDecoration(
                      hintText: 'Search',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      prefixIcon: Icon(Icons.search, color: Colors.grey[400]),
                      border: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),

              // Red Circular Filter Button
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: const Color(0xFFD32F2F),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: const Icon(Icons.tune, color: Colors.white, size: 22),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Category Chips
          SizedBox(
            height: 42,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final cat = categories[index];
                if (cat == 'All') return const SizedBox.shrink();

                final isSelected = cat == _selectedCategory;
                String catEmoji = '🍔';
                if (cat.contains('Snacks')) catEmoji = '🍟';
                if (cat.contains('Drinks')) catEmoji = '🥤';

                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: ChoiceChip(
                    avatar: Text(catEmoji, style: const TextStyle(fontSize: 14)),
                    label: Text(cat),
                    selected: isSelected,
                    selectedColor: const Color(0xFF7B0000),
                    backgroundColor: Colors.grey[100],
                    labelStyle: TextStyle(
                      color: isSelected ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 13,
                    ),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    side: BorderSide.none,
                    onSelected: (_) => setState(() => _selectedCategory = cat),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: 20),

          // Food List Cards
          foodItems.isEmpty
              ? Container(
                  height: 200,
                  alignment: Alignment.center,
                  child: Text(
                    'No food items found',
                    style: TextStyle(color: Colors.grey[500], fontSize: 16),
                  ),
                )
              : ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: foodItems.length,
                  itemBuilder: (context, index) {
                    final food = foodItems[index];
                    return FoodCard(
                      food: food,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => FoodDetailsScreen(food: food),
                          ),
                        );
                      },
                    );
                  },
                ),
        ],
      ),
    );
  }
}
