import 'package:flutter/material.dart';
import '../services/admin_service.dart';
import '../services/food_service.dart';
import '../services/order_service.dart';
import 'manage_food_screen.dart';
import 'manage_orders_screen.dart';
import 'add_edit_food_screen.dart';
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

  String _selectedRevenuePeriod = 'This Month';
  int _currentNavIndex = 0;

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
    final foodCount = _foodService.getAllFoodItems().length;
    final totalOrders = _orderService.totalOrdersCount;
    final pendingOrders = _orderService.pendingOrdersCount;
    final completedOrders = totalOrders > pendingOrders ? totalOrders - pendingOrders : 451;
    final revenue = _orderService.totalRevenue > 0 ? _orderService.totalRevenue : 125750.0;

    return Scaffold(
      backgroundColor: const Color(0xFFFFF7F1),
      drawer: _buildNavigationDrawer(foodCount),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async => _refreshData(),
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            physics: const AlwaysScrollableScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP HEADER BAR (Logo, Drawer Button, Search, Notifications, Avatar)
                Row(
                  children: [
                    // Drawer Hamburger Icon Button
                    Builder(
                      builder: (context) => IconButton(
                        icon: const Icon(Icons.menu, color: Colors.black87, size: 24),
                        onPressed: () => Scaffold.of(context).openDrawer(),
                      ),
                    ),

                    // QuickBite Header Pill
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: const Row(
                        children: [
                          Icon(Icons.room_service, color: Colors.white, size: 16),
                          SizedBox(width: 4),
                          Text(
                            'QuickBite',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Search Bar
                    Expanded(
                      child: Container(
                        height: 38,
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey[200]!),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.search, size: 18, color: Colors.grey[400]),
                            const SizedBox(width: 6),
                            Expanded(
                              child: TextField(
                                decoration: InputDecoration(
                                  hintText: 'Search here...',
                                  hintStyle: TextStyle(fontSize: 12, color: Colors.grey[400]),
                                  border: InputBorder.none,
                                  isDense: true,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),

                    // Notification Bell with Badge 3
                    Badge(
                      label: const Text('3'),
                      backgroundColor: const Color(0xFFFF6B00),
                      child: const Icon(Icons.notifications_outlined, color: Colors.black87, size: 24),
                    ),
                    const SizedBox(width: 10),

                    // Admin Avatar
                    GestureDetector(
                      onTap: () => Scaffold.of(context).openDrawer(),
                      child: const CircleAvatar(
                        radius: 16,
                        backgroundColor: Color(0xFFFFE0B2),
                        child: Text('👨‍🍳', style: TextStyle(fontSize: 16)),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // GREETING BANNER WITH PIZZA PHOTO ARTWORK
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Good Morning, Admin! 👋',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              "Here's what's happening today",
                              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                            ),
                          ],
                        ),
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16),
                        child: Image.network(
                          'https://images.unsplash.com/photo-1513104890138-7c749659a591?auto=format&fit=crop&w=300&q=80',
                          width: 80,
                          height: 60,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) => const Text('🍕', style: TextStyle(fontSize: 40)),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // BENTO 4-GRID STATISTICS CARDS (Reference Image Layout)
                GridView.count(
                  crossAxisCount: 2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 1.35,
                  children: [
                    // CARD 1: TOTAL REVENUE (Solid Orange)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF6B00),
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFF6B00).withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text('PKR', style: TextStyle(color: Colors.white70, fontSize: 11, fontWeight: FontWeight.bold)),
                              Container(
                                padding: const EdgeInsets.all(4),
                                decoration: BoxDecoration(color: Colors.white24, borderRadius: BorderRadius.circular(8)),
                                child: const Icon(Icons.north_east, color: Colors.white, size: 14),
                              ),
                            ],
                          ),
                          Text(
                            revenue.toStringAsFixed(0),
                            style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
                          ),
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total Revenue', style: TextStyle(color: Colors.white70, fontSize: 11)),
                              Text('↑ 12%', style: TextStyle(color: Colors.white, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // CARD 2: TOTAL ORDERS (Light Peach)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFFE6D9),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$totalOrders', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: const Color(0xFFFF6B00).withValues(alpha: 0.15),
                                child: const Icon(Icons.shopping_cart_outlined, color: Color(0xFFFF6B00), size: 16),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Total Orders', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                              SizedBox(height: 2),
                              Text('↑ 8%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // CARD 3: PENDING ORDERS (Soft Green)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F3E3),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$pendingOrders', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.green.withValues(alpha: 0.2),
                                child: const Icon(Icons.access_time, color: Colors.green, size: 16),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Pending Orders', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                              SizedBox(height: 2),
                              Text('↑ 5%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // CARD 4: COMPLETED ORDERS (Soft Lavender)
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0E5FA),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('$completedOrders', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.black87)),
                              CircleAvatar(
                                radius: 14,
                                backgroundColor: Colors.purple.withValues(alpha: 0.2),
                                child: const Icon(Icons.check_circle_outline, color: Colors.purple, size: 16),
                              ),
                            ],
                          ),
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('Completed', style: TextStyle(fontSize: 11, color: Colors.black54, fontWeight: FontWeight.w500)),
                              SizedBox(height: 2),
                              Text('↑ 10%', style: TextStyle(color: Colors.green, fontSize: 11, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // REVENUE OVERVIEW BENTO CARD (With Custom Line Chart)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.04),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Revenue Overview',
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'PKR ${revenue.toStringAsFixed(0)}',
                                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                                  ),
                                  const SizedBox(width: 6),
                                  const Text(
                                    '↑ 12% vs last month',
                                    style: TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Dropdown Period Filter
                          DropdownButton<String>(
                            value: _selectedRevenuePeriod,
                            underline: const SizedBox(),
                            style: const TextStyle(fontSize: 11, color: Colors.black87, fontWeight: FontWeight.bold),
                            icon: const Icon(Icons.arrow_drop_down, size: 18),
                            items: ['This Week', 'This Month', 'This Year'].map((p) {
                              return DropdownMenuItem(value: p, child: Text(p));
                            }).toList(),
                            onChanged: (val) {
                              if (val != null) setState(() => _selectedRevenuePeriod = val);
                            },
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),

                      // Interactive Custom Orange Line Chart Widget
                      SizedBox(
                        height: 120,
                        width: double.infinity,
                        child: CustomPaint(
                          painter: RevenueLineChartPainter(),
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Day Labels (Mon, Tue, Wed, Thu, Fri, Sat, Sun)
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Mon', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Tue', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Wed', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Thu', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Fri', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Sat', style: TextStyle(fontSize: 10, color: Colors.grey)),
                          Text('Sun', style: TextStyle(fontSize: 10, color: Colors.grey)),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // POPULAR FOOD ITEMS & RECENT ORDERS ROW (Reference Image)
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Popular Food Items Bento Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Popular Food', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFoodScreen())),
                                  child: const Text('See All ➔', style: TextStyle(fontSize: 10, color: Color(0xFFFF6B00), fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Container(
                                    width: 40,
                                    height: 40,
                                    color: const Color(0xFFFFF0E8),
                                    child: const Center(child: Text('🍔', style: TextStyle(fontSize: 22))),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                const Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text('Classic Burger', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold), maxLines: 1),
                                      Text('2.5K Orders 🔥', style: TextStyle(fontSize: 9, color: Colors.grey)),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),

                    // Recent Orders Bento Card
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withValues(alpha: 0.04),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Recent Orders', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                                GestureDetector(
                                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageOrdersScreen())),
                                  child: const Text('See All ➔', style: TextStyle(fontSize: 10, color: Color(0xFFFF6B00), fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                const CircleAvatar(radius: 14, backgroundColor: Color(0xFFE5F0FF), child: Text('👤', style: TextStyle(fontSize: 12))),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text('#Q12345', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
                                      Text('Rs. 850', style: TextStyle(fontSize: 9, color: Colors.grey[600])),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  decoration: BoxDecoration(color: Colors.green.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(6)),
                                  child: const Text('Delivered', style: TextStyle(fontSize: 9, color: Colors.green, fontWeight: FontWeight.bold)),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 80),
              ],
            ),
          ),
        ),
      ),

      // FLOATING MOBILE NAVIGATION BAR (Reference Image)
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Container(
        width: 56,
        height: 56,
        margin: const EdgeInsets.only(top: 20),
        child: FloatingActionButton(
          backgroundColor: const Color(0xFFFF6B00),
          elevation: 4,
          shape: const CircleBorder(),
          onPressed: () async {
            await Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddEditFoodScreen()),
            );
            _refreshData();
          },
          child: const Icon(Icons.add, color: Colors.white, size: 30),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        color: Colors.white,
        elevation: 10,
        child: SizedBox(
          height: 50,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              // Home Tab
              IconButton(
                icon: Icon(Icons.home, color: _currentNavIndex == 0 ? const Color(0xFFFF6B00) : Colors.grey[400]),
                onPressed: () => setState(() => _currentNavIndex = 0),
              ),

              // Orders Tab
              IconButton(
                icon: Icon(Icons.receipt_long, color: _currentNavIndex == 1 ? const Color(0xFFFF6B00) : Colors.grey[400]),
                onPressed: () {
                  setState(() => _currentNavIndex = 1);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageOrdersScreen()));
                },
              ),

              const SizedBox(width: 40), // Spacer for central FAB

              // Menu Tab
              IconButton(
                icon: Icon(Icons.restaurant_menu, color: _currentNavIndex == 2 ? const Color(0xFFFF6B00) : Colors.grey[400]),
                onPressed: () {
                  setState(() => _currentNavIndex = 2);
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFoodScreen()));
                },
              ),

              // Profile Tab
              IconButton(
                icon: Icon(Icons.person_outline, color: _currentNavIndex == 3 ? const Color(0xFFFF6B00) : Colors.grey[400]),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // NAVIGATION DRAWER (Sidebar based on Reference Image)
  Widget _buildNavigationDrawer(int foodCount) {
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          // Drawer Header
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(color: Color(0xFFFF6B00)),
            accountName: Text(
              _adminService.adminName,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            accountEmail: Text(_adminService.adminEmail),
            currentAccountPicture: const CircleAvatar(
              backgroundColor: Colors.white,
              child: Text('👨‍🍳', style: TextStyle(fontSize: 32)),
            ),
          ),

          // Drawer Navigation Items
          _buildDrawerItem(Icons.dashboard, 'Dashboard', isSelected: true, onTap: () => Navigator.pop(context)),
          _buildDrawerItem(Icons.restaurant_menu, 'Food Menu ($foodCount)', onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFoodScreen()));
          }),
          _buildDrawerItem(Icons.category, 'Categories', onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageFoodScreen()));
          }),
          _buildDrawerItem(Icons.receipt_long, 'Orders', onTap: () {
            Navigator.pop(context);
            Navigator.push(context, MaterialPageRoute(builder: (_) => const ManageOrdersScreen()));
          }),
          _buildDrawerItem(Icons.people_outline, 'Customers', onTap: () => Navigator.pop(context)),
          _buildDrawerItem(Icons.two_wheeler, 'Riders', onTap: () => Navigator.pop(context)),
          _buildDrawerItem(Icons.local_offer_outlined, 'Offers & Discounts', onTap: () => Navigator.pop(context)),
          _buildDrawerItem(Icons.analytics_outlined, 'Analytics', onTap: () => Navigator.pop(context)),
          _buildDrawerItem(Icons.settings_outlined, 'Settings', onTap: () => Navigator.pop(context)),
          const Divider(),
          _buildDrawerItem(Icons.logout, 'Logout', color: Colors.red, onTap: () {
            Navigator.pop(context);
            _logout();
          }),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, {bool isSelected = false, Color? color, VoidCallback? onTap}) {
    final themeColor = color ?? (isSelected ? const Color(0xFFFF6B00) : Colors.black87);
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: isSelected ? const Color(0xFFFF6B00).withValues(alpha: 0.12) : Colors.transparent,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(icon, color: themeColor),
        title: Text(
          title,
          style: TextStyle(color: themeColor, fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
        onTap: onTap,
      ),
    );
  }
}

// CUSTOM PAINTER FOR REVENUE LINE CHART (Orange Line with Tooltip)
class RevenueLineChartPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final points = [
      Offset(0, size.height * 0.8),
      Offset(size.width * 0.16, size.height * 0.65),
      Offset(size.width * 0.33, size.height * 0.70),
      Offset(size.width * 0.50, size.height * 0.45),
      Offset(size.width * 0.66, size.height * 0.55),
      Offset(size.width * 0.83, size.height * 0.25), // Highlighted Peak node
      Offset(size.width, size.height * 0.40),
    ];

    // Draw Line
    final linePaint = Paint()
      ..color = const Color(0xFFFF6B00)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke;

    final path = Path()..moveTo(points[0].dx, points[0].dy);
    for (int i = 1; i < points.length; i++) {
      path.lineTo(points[i].dx, points[i].dy);
    }
    canvas.drawPath(path, linePaint);

    // Draw Fill Gradient under Line
    final fillPath = Path.from(path)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    final fillPaint = Paint()
      ..shader = LinearGradient(
        colors: [
          const Color(0xFFFF6B00).withValues(alpha: 0.25),
          const Color(0xFFFF6B00).withValues(alpha: 0.0),
        ],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height));

    canvas.drawPath(fillPath, fillPaint);

    // Draw Data Nodes & Tooltip on Peak (Friday node)
    final nodePaint = Paint()
      ..color = const Color(0xFFFF6B00)
      ..style = PaintingStyle.fill;

    final whiteNodePaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    for (int i = 0; i < points.length; i++) {
      canvas.drawCircle(points[i], 4, whiteNodePaint);
      canvas.drawCircle(points[i], 3, nodePaint);
    }

    // Highlight Active Tooltip on Peak Node (Friday)
    final peak = points[5];
    final tooltipRect = RRect.fromRectAndRadius(
      Rect.fromCenter(center: Offset(peak.dx, peak.dy - 18), width: 70, height: 20),
      const Radius.circular(6),
    );
    canvas.drawRRect(tooltipRect, Paint()..color = Colors.black);

    const textStyle = TextStyle(color: Colors.white, fontSize: 9, fontWeight: FontWeight.bold);
    const textSpan = TextSpan(text: 'PKR 28,500', style: textStyle);
    final textPainter = TextPainter(text: textSpan, textDirection: TextDirection.ltr);
    textPainter.layout();
    textPainter.paint(canvas, Offset(peak.dx - (textPainter.width / 2), peak.dy - 24));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
