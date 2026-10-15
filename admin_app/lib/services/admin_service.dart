class AdminService {
  static final AdminService _instance = AdminService._internal();
  factory AdminService() => _instance;
  AdminService._internal();

  bool _isLoggedIn = false;
  String _adminEmail = 'admin@quickbite.com';
  String _adminName = 'Admin QuickBite';

  bool get isLoggedIn => _isLoggedIn;
  String get adminEmail => _adminEmail;
  String get adminName => _adminName;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (email.trim().isNotEmpty && password.length >= 6) {
      _isLoggedIn = true;
      _adminEmail = email.trim();
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    await Future.delayed(const Duration(milliseconds: 300));
    _isLoggedIn = false;
  }
}
