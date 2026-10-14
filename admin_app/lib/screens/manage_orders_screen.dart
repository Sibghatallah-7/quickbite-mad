import 'package:flutter/material.dart';
import '../models/order_model.dart';
import '../services/order_service.dart';
import '../widgets/admin_order_card.dart';

class ManageOrdersScreen extends StatefulWidget {
  const ManageOrdersScreen({super.key});

  @override
  State<ManageOrdersScreen> createState() => _ManageOrdersScreenState();
}

class _ManageOrdersScreenState extends State<ManageOrdersScreen> with SingleTickerProviderStateMixin {
  final OrderService _orderService = OrderService();
  late TabController _tabController;

  final List<String> _tabs = ['All', 'Pending', 'Preparing', 'Ready', 'Delivered', 'Cancelled'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  List<OrderModel> _getFilteredOrders(String filter) {
    final allOrders = _orderService.getAllOrders();
    if (filter == 'All') return allOrders;
    final status = OrderStatus.fromString(filter);
    return allOrders.where((order) => order.status == status).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Orders', style: TextStyle(fontWeight: FontWeight.bold)),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          tabs: _tabs.map((tab) => Tab(text: tab)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _tabs.map((tab) {
          final orders = _getFilteredOrders(tab);
          if (orders.isEmpty) {
            return Center(
              child: Text(
                'No $tab orders',
                style: const TextStyle(fontSize: 16, color: Colors.grey),
              ),
            );
          }
          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              final order = orders[index];
              return AdminOrderCard(
                order: order,
                onStatusChanged: (newStatus) {
                  setState(() {
                    _orderService.updateOrderStatus(order.id, newStatus);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Order ${order.id} updated to ${newStatus.displayName}'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
