import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final api = ApiService();
  bool isLoggedIn = false;

  Future login(String email, String pass) async {
    final res = await api.login(email, pass);

    if (res['status'] == 'success') {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString("token", api.token);
      isLoggedIn = true;
    }
    notifyListeners();
  }

  Future signup(Map data) async {
    await api.register(data);
  }

  Future checkLogin() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString("token");

    if (token != null) {
      api.token = token;
      isLoggedIn = true;
    }
    notifyListeners();
  }

  Future logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    isLoggedIn = false;
    notifyListeners();
  }
}