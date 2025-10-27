import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';

class AuthService with ChangeNotifier {
  User? _user;
  bool _isLoading = false;

  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _user != null;
  bool get isAdmin => _user?.role == 'admin';

  Future<void> login(String email, String password) async {
    _isLoading = true;
    notifyListeners();

    await Future.delayed(const Duration(seconds: 2));

    if (email == 'admin@smartbin.com' && password == 'admin123') {
      _user = User(
        id: '1',
        username: 'Admin User',
        email: email,
        role: 'admin',
        token: 'mock_jwt_token',
      );
    } else if (email == 'user@smartbin.com' && password == 'user123') {
      _user = User(
        id: '2',
        username: 'Regular User',
        email: email,
        role: 'user',
        token: 'mock_jwt_token',
      );
    } else {
      _isLoading = false;
      notifyListeners();
      throw Exception('Invalid credentials');
    }

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', json.encode(_user!.toJson()));

    _isLoading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    _user = null;
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    notifyListeners();
  }

  Future<void> loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('user');

    if (userString != null) {
      try {
        _user = User.fromJson(json.decode(userString));
      } catch (e) {
        // Handle potential parsing errors, e.g., by logging out
        await logout();
      }
    }

    notifyListeners();
  }
}
