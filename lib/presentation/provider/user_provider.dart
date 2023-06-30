import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/entities/user.dart';

class UserProvider extends ChangeNotifier {
  User user = User();

  void loadUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('username');

    if (userString != null) {
      final userMap = jsonDecode(userString);
      final user = User.fromJson(userMap);
      this.user = user;
    }

    notifyListeners();
  }

  void saveUser(User username) async {
    user = username;

    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('username', userJson);

    notifyListeners();
  }
}
