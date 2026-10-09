import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';

import '../../infrastructure/entities/user.dart';

const _tag = 'NutriPlato|UserProvider';

class UserProvider extends ChangeNotifier {
  UserProvider(this._preferences);

  final PreferencesRepository _preferences;

  User user = User();

  void loadUser() async {
    dev.log('loadUser → cargando usuario legacy', name: _tag);
    final userString = _preferences.usernameJson;

    if (userString != null) {
      final userMap = jsonDecode(userString);
      final user = User.fromJson(userMap);
      this.user = user;
      dev.log(
        'loadUser → usuario cargado: username="${user.username}"',
        name: _tag,
      );
    } else {
      dev.log('loadUser → no hay usuario guardado (primera vez)', name: _tag);
    }

    notifyListeners();
  }

  void saveUser(User username) async {
    dev.log(
      'saveUser → guardando usuario: username="${username.username}"',
      name: _tag,
    );
    user = username;

    final userJson = jsonEncode(user.toJson());
    await _preferences.setUsernameJson(userJson);
    dev.log('saveUser → guardado OK', name: _tag);

    notifyListeners();
  }
}
