import 'dart:convert';
import 'dart:developer' as dev;
import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/micronutrients.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _tag = 'NutriPlato|CustomFoodProvider';
const _kCustomFoodsKey = 'custom_foods';

/// Proveedor de alimentos creados por el usuario.
class CustomFoodProvider with ChangeNotifier {
  List<Food> _foods = [];
  List<Food> get foods => _foods;

  /// Carga los alimentos personalizados desde almacenamiento.
  Future<void> loadFoods() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = prefs.getStringList(_kCustomFoodsKey) ?? [];
      _foods = raw
          .map((s) {
            try {
              return _foodFromJson(jsonDecode(s) as Map<String, dynamic>);
            } catch (e) {
              dev.log('loadFoods → ERROR deserializando: $e', name: _tag);
              return null;
            }
          })
          .whereType<Food>()
          .toList();
      dev.log(
        'loadFoods → ${_foods.length} alimentos personalizados',
        name: _tag,
      );
      notifyListeners();
    } catch (e, st) {
      dev.log('loadFoods → ERROR: $e', name: _tag, error: e, stackTrace: st);
    }
  }

  /// Agrega un alimento personalizado.
  Future<void> addFood(Food food) async {
    _foods.insert(0, food);
    await _save();
    dev.log('addFood → "${food.name}" (${food.energia} kcal)', name: _tag);
  }

  /// Elimina un alimento personalizado por nombre.
  Future<void> removeFood(String name) async {
    _foods.removeWhere((f) => f.name == name);
    await _save();
    dev.log('removeFood → "$name"', name: _tag);
  }

  bool contains(String name) => _foods.any((f) => f.name == name);

  Future<void> _save() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final raw = _foods.map((f) => jsonEncode(_foodToJson(f))).toList();
      await prefs.setStringList(_kCustomFoodsKey, raw);
      notifyListeners();
    } catch (e, st) {
      dev.log('_save → ERROR: $e', name: _tag, error: e, stackTrace: st);
    }
  }

  Map<String, dynamic> _foodToJson(Food f) => {
    'name': f.name,
    'category': f.category,
    'color': f.color,
    'cantidadSugerida': f.cantidadSugerida,
    'unidad': f.unidad,
    'pesoRedondeado': f.pesoRedondeado,
    'pesoNeto': f.pesoNeto,
    'energia': f.energia,
    'proteina': f.proteina,
    'lipidos': f.lipidos,
    'hidratosDeCarbono': f.hidratosDeCarbono,
    if (f.micros != null) 'micros': f.micros!.toJson(),
  };

  Food _foodFromJson(Map<String, dynamic> m) => Food(
    name: m['name'],
    category: m['category'] ?? 'custom',
    icon: const Icon(Icons.restaurant, color: Colors.green),
    color: Color(m['color']),
    cantidadSugerida: m['cantidadSugerida'] ?? '1',
    unidad: m['unidad'] ?? 'porción',
    pesoRedondeado: m['pesoRedondeado'] ?? m['pesoNeto'] ?? '100',
    pesoNeto: m['pesoNeto'] ?? '100',
    energia: m['energia'],
    proteina: m['proteina'],
    lipidos: m['lipidos'],
    hidratosDeCarbono: m['hidratosDeCarbono'],
    micros: m['micros'] != null
        ? Micronutrients.fromJson(m['micros'] as Map<String, dynamic>)
        : null,
  );
}
