import 'package:flutter/foundation.dart';
import '../models/app_user.dart';

class AuthService extends ChangeNotifier {
  AppUser? _currentUser = AppUser(
    id: 'user_1',
    name: 'John Doe',
    email: 'john@quickbite.com',
    phone: '+1234567890',
    address: '123 Food Street, Gourmet City',
  );

  AppUser? get currentUser => _currentUser;
  bool get isLoggedIn => _currentUser != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 800));
    if (email.isNotEmpty && password.isNotEmpty) {
      _currentUser = AppUser(
        id: 'user_1',
        name: email.split('@')[0],
        email: email,
        phone: '+1234567890',
        address: '123 Food Street, Gourmet City',
      );
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password, String phone, String address) async {
    await Future.delayed(const Duration(milliseconds: 800));
    _currentUser = AppUser(
      id: 'user_${DateTime.now().millisecondsSinceEpoch}',
      name: name,
      email: email,
      phone: phone,
      address: address,
    );
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
