import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../infrastructure/entities/user.dart';

const _tag = 'NutriPlato|UserProvider';

class UserProvider extends ChangeNotifier {
  User user = User();

  void loadUser() async {
    dev.log('loadUser → cargando usuario legacy', name: _tag);
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString('username');

    if (userString != null) {
      final userMap = jsonDecode(userString);
      final user = User.fromJson(userMap);
      this.user = user;
      dev.log('loadUser → usuario cargado: username="${user.username}"',
          name: _tag);
    } else {
      dev.log('loadUser → no hay usuario guardado (primera vez)', name: _tag);
    }

    notifyListeners();
  }

  void saveUser(User username) async {
    dev.log('saveUser → guardando usuario: username="${username.username}"',
        name: _tag);
    user = username;

    final prefs = await SharedPreferences.getInstance();
    final userJson = jsonEncode(user.toJson());
    await prefs.setString('username', userJson);
    dev.log('saveUser → guardado OK', name: _tag);

    notifyListeners();
  }
}
