import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../services/food_service.dart';
import '../services/order_service.dart';
import 'manage_food_screen.dart';
import 'manage_orders_screen.dart';
import 'admin_login_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final FoodService _foodService = FoodService();
  final OrderService _orderService = OrderService();
  final AdminService _adminService = AdminService();

  void _refreshData() {
    setState(() {});
  }

  void _logout() async {
    await _adminService.logout();
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const AdminLoginScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final foodCount = _foodService.getAllFoodItems().length;
    final totalOrders = _orderService.totalOrdersCount;
    final pendingOrders = _orderService.pendingOrdersCount;
    final revenue = _orderService.totalRevenue;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Admin Dashboard', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Logout'),
                  content: const Text('Are you sure you want to log out?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        _logout();
                      },
                      child: const Text('Logout', style: TextStyle(color: Colors.red)),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          _refreshData();
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAlignment.start,
            children: [
              // Welcome Banner
              Card(
                color: theme.colorScheme.primaryContainer,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: theme.colorScheme.primary,
                        child: const Icon(Icons.restaurant, color: Colors.white, size: 28),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAlignment.start,
                          children: [
                            Text(
                              'Welcome Back!',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              _adminService.adminEmail,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: Colors.grey[700],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Quick Stats Grid
              Text(
                'Overview',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              GridView.count(
                crossAxisCount: 2,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
                childAspectRatio: 1.4,
                children: [
                  _buildStatCard(
                    context: context,
                    title: 'Total Revenue',
                    value: 'Rs. ${revenue.toStringAsFixed(0)}',
                    icon: Icons.attach_money,
                    color: Colors.green,
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Total Orders',
                    value: '$totalOrders',
                    icon: Icons.shopping_bag_outlined,
                    color: Colors.blue,
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Pending Orders',
                    value: '$pendingOrders',
                    icon: Icons.pending_actions,
                    color: Colors.orange,
                  ),
                  _buildStatCard(
                    context: context,
                    title: 'Menu Items',
                    value: '$foodCount',
                    icon: Icons.fastfood_outlined,
                    color: Colors.purple,
                  ),
                ],
              ),
              const SizedBox(height: 24),

              // Action Buttons / Navigation Cards
              Text(
                'Quick Actions',
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),

              _buildActionCard(
                context: context,
                title: 'Manage Food Menu',
                subtitle: 'Add, edit, or remove dishes & set availability',
                icon: Icons.restaurant_menu,
                color: Colors.deepOrange,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ManageFoodScreen()),
                  );
                  _refreshData();
                },
              ),
              const SizedBox(height: 12),

              _buildActionCard(
                context: context,
                title: 'Manage Orders',
                subtitle: 'View live customer orders & update status',
                icon: Icons.receipt_long,
                color: Colors.indigo,
                onTap: () async {
                  await Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const ManageOrdersScreen()),
                  );
                  _refreshData();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required BuildContext context,
    required String title,
    required String value,
    required IconData icon,
    required Color color,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundColor: color.withOpacity(0.15),
                  child: Icon(icon, color: color, size: 18),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionCard({
    required BuildContext context,
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12),
        leading: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withOpacity(0.15),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color, size: 28),
        ),
        title: Text(
          title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}
