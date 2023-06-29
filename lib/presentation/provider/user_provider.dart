import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProvider extends ChangeNotifier {
  String username = "usuario";

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? userString = prefs.getString('user');

    if (userString != null) {
      username = userString;
    }

    notifyListeners();
  }

  void saveUser(String user) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user', user);
    username = user;

    notifyListeners();
  }
}
