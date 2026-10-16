import 'package:flutter/material.dart';
import 'screens/admin_login_screen.dart';

void main() {
  runApp(const QuickBiteAdminApp());
}

class QuickBiteAdminApp extends StatelessWidget {
  const QuickBiteAdminApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'QuickBite Admin',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepOrange,
          primary: Colors.deepOrange,
        ),
      ),
      home: const AdminLoginScreen(),
    );
  }
}
