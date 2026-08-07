import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:nutriplato/infrastructure/entities/food/nutri_food.dart';

const _tag = 'NutriPlato|FoodApiService';
const _timeout = Duration(seconds: 6);

/// User-Agent propio (OpenFoodFacts lo pide para no bloquear la app).
const Map<String, String> _headers = {
  'User-Agent':
      'NutriPlato/3.0 (app de nutrición; contacto: nutriplato@example.com)',
};

/// Cliente de OpenFoodFacts (API gratuita, sin tokens).
///
/// Devuelve alimentos normalizados a porción de 100 g. Si la red falla,
/// los llamadores deben usar la base local como fallback.
class FoodApiService {
  final http.Client _client;

  FoodApiService({http.Client? client}) : _client = client ?? http.Client();

  /// Busca alimentos por nombre en OpenFoodFacts.
  Future<List<NutriFood>> searchFoods(String query, {int pageSize = 25}) async {
    if (query.trim().isEmpty) return const [];

    final uri = Uri.https('world.openfoodfacts.org', '/cgi/search.pl', {
      'search_terms': query.trim(),
      'search_simple': '1',
      'action': 'process',
      'json': '1',
      'page_size': '$pageSize',
      'fields':
          'product_name,brands,quantity,nutriments,image_front_small_url,barcode',
    });

    try {
      final res = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (res.statusCode != 200) {
        dev.log('searchFoods → HTTP ${res.statusCode}', name: _tag);
        return const [];
      }
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      final products = body['products'] as List<dynamic>? ?? [];
      final foods = products
          .map((p) => _normalize(p as Map<String, dynamic>))
          .whereType<NutriFood>()
          .toList();
      dev.log('searchFoods → "$query": ${foods.length} resultados', name: _tag);
      return foods;
    } catch (e) {
      dev.log('searchFoods → ERROR (fallback local): $e', name: _tag);
      return const [];
    }
  }

  /// Busca un producto por código de barras.
  Future<NutriFood?> getByBarcode(String barcode) async {
    final cleaned = barcode.replaceAll(RegExp(r'[^0-9]'), '');
    if (cleaned.length < 8) return null;

    final uri = Uri.https(
      'world.openfoodfacts.org',
      '/api/v2/product/$cleaned.json',
    );

    try {
      final res = await _client.get(uri, headers: _headers).timeout(_timeout);
      if (res.statusCode != 200) return null;
      final body = jsonDecode(res.body) as Map<String, dynamic>;
      if (body['status'] != 1) return null;
      final product = body['product'] as Map<String, dynamic>?;
      if (product == null) return null;
      dev.log(
        'getByBarcode → encontrado: ${product['product_name']}',
        name: _tag,
      );
      return _normalize(product);
    } catch (e) {
      dev.log('getByBarcode → ERROR (fallback local): $e', name: _tag);
      return null;
    }
  }

  /// Convierte un producto de OpenFoodFacts a [NutriFood] por 100 g.
  NutriFood? _normalize(Map<String, dynamic> product) {
    final name = (product['product_name'] as String? ?? '').trim();
    if (name.isEmpty) return null;

    final n = product['nutriments'] as Map<String, dynamic>? ?? {};
    final energyKcal =
        _num(n['energy-kcal_100g']) ?? (_num(n['energy_100g']) ?? 0) / 4.184;
    final protein = _num(n['proteins_100g']) ?? 0;
    final carbs = _num(n['carbohydrates_100g']) ?? 0;
    final fat = _num(n['fat_100g']) ?? 0;
    final fiber = _num(n['fiber_100g']);
    final sodium = _num(n['sodium_100g']);
    final sugars = _num(n['sugars_100g']);

    final brand = (product['brands'] as String? ?? '').trim();
    final quantity = (product['quantity'] as String? ?? '').trim();
    final imageUrl = product['image_front_small_url'] as String?;

    final details = [
      if (brand.isNotEmpty) brand,
      if (quantity.isNotEmpty) quantity,
    ].join(' · ');

    return NutriFood(
      alimento: name,
      category: 'online',
      categoryIcon: Icons.cloud_queue,
      categoryColor: const Color(0xFF00838F),
      cantidadSugerida: '100',
      unidad: 'g',
      pesoRedondeado: '100',
      pesoNeto: '100',
      energia: energyKcal.toStringAsFixed(0),
      proteina: protein.toStringAsFixed(1),
      lipidos: fat.toStringAsFixed(1),
      hidratosDeCarbono: carbs.toStringAsFixed(1),
      fibra: fiber?.toStringAsFixed(1) ?? 'ND',
      sodio: sodium?.toStringAsFixed(0) ?? 'ND',
      azucarEquivalente: sugars?.toStringAsFixed(1) ?? 'ND',
      image: imageUrl != null
          ? Image.network(
              imageUrl,
              errorBuilder: (_, _, _) => const SizedBox.shrink(),
            )
          : null,
    )..description = details.isEmpty ? 'OpenFoodFacts' : details;
  }

  double? _num(dynamic v) {
    if (v == null) return null;
    final d = double.tryParse(v.toString());
    return d;
  }

  void dispose() {
    _client.close();
  }
}
