import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';

const _tag = 'NutriPlato|FavoritesProvider';

/// Proveedor de alimentos favoritos (guardados por nombre).
class FavoritesProvider with ChangeNotifier {
  FavoritesProvider(this._preferences);

  final PreferencesRepository _preferences;

  final Set<String> _names = {};

  Set<String> get names => Set.unmodifiable(_names);

  bool isFavorite(String name) => _names.contains(name);

  /// Carga los favoritos desde almacenamiento.
  Future<void> loadFavorites() async {
    try {
      final saved = _preferences.favoriteFoodNames;
      _names
        ..clear()
        ..addAll(saved);
      dev.log('loadFavorites → ${_names.length} favoritos', name: _tag);
      notifyListeners();
    } catch (e, st) {
      dev.log(
        'loadFavorites → ERROR: $e',
        name: _tag,
        error: e,
        stackTrace: st,
      );
    }
  }

  /// Agrega o elimina un favorito, devolviendo el nuevo estado.
  Future<bool> toggle(String name) async {
    final isFav = _names.contains(name);
    if (isFav) {
      _names.remove(name);
    } else {
      _names.add(name);
    }
    await _save();
    dev.log('toggle → "$name" ${isFav ? "removido" : "agregado"}', name: _tag);
    return !isFav;
  }

  Future<void> _save() async {
    try {
      await _preferences.setFavoriteFoodNames(_names.toList());
      notifyListeners();
    } catch (e, st) {
      dev.log('_save → ERROR: $e', name: _tag, error: e, stackTrace: st);
    }
  }
}
