import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/auth_service.dart';
import '../services/cart_service.dart';
import '../services/order_service.dart';
import 'order_tracking_screen.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  late final TextEditingController _addressController;
  String _paymentMethod = 'Cash on Delivery';
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    final user = Provider.of<AuthService>(context, listen: false).currentUser;
    _addressController = TextEditingController(text: user?.address ?? 'St. Sunset Road, Seminyak, Badung Regency, Bali');
  }

  void _placeOrder() async {
    setState(() => _isLoading = true);
    final cart = Provider.of<CartService>(context, listen: false);
    final orderService = Provider.of<OrderService>(context, listen: false);

    await orderService.placeOrder(cart.items, cart.totalAmount, _addressController.text);
    cart.clearCart();
    setState(() => _isLoading = false);

    if (mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute(builder: (_) => const OrderTrackingScreen()),
        (route) => route.isFirst,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartService>(context);

    return Scaffold(
      appBar: AppBar(title: const Text('Checkout')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('Delivery Address', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            TextField(
              controller: _addressController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.location_on),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
              ),
            ),
            const SizedBox(height: 24),
            const Text('Payment Method', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),

            // Cash on Delivery Option
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: _paymentMethod == 'Cash on Delivery' ? const Color(0xFFD32F2F) : Colors.grey[300]!),
              ),
              leading: const Icon(Icons.money, color: Color(0xFFD32F2F)),
              title: const Text('Cash on Delivery', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: _paymentMethod == 'Cash on Delivery' ? const Icon(Icons.check_circle, color: Color(0xFFD32F2F)) : null,
              onTap: () => setState(() => _paymentMethod = 'Cash on Delivery'),
            ),
            const SizedBox(height: 10),

            // Card Option
            ListTile(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: _paymentMethod == 'Card' ? const Color(0xFFD32F2F) : Colors.grey[300]!),
              ),
              leading: const Icon(Icons.credit_card, color: Color(0xFFD32F2F)),
              title: const Text('Credit/Debit Card', style: TextStyle(fontWeight: FontWeight.bold)),
              trailing: _paymentMethod == 'Card' ? const Icon(Icons.check_circle, color: Color(0xFFD32F2F)) : null,
              onTap: () => setState(() => _paymentMethod = 'Card'),
            ),

            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total:', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                Text('\$${cart.totalAmount.toStringAsFixed(2)}', style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFFD32F2F))),
              ],
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD32F2F),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                onPressed: _isLoading ? null : _placeOrder,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text('Place Order', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
