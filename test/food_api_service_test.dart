import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:http/testing.dart';
import 'package:nutriplato/infrastructure/services/food_api_service.dart';

http.Response _json(Object body, {int status = 200}) => http.Response(
  jsonEncode(body),
  status,
  headers: {'content-type': 'application/json; charset=utf-8'},
);

void main() {
  group('FoodApiService.searchFoods', () {
    test('normaliza productos de OpenFoodFacts a porción de 100 g', () async {
      final client = MockClient((request) async {
        expect(request.url.host, 'world.openfoodfacts.org');
        expect(request.url.queryParameters['search_terms'], 'avena');
        return _json({
          'products': [
            {
              'product_name': 'Avena tradicional',
              'brands': 'Quaker',
              'quantity': '500 g',
              'nutriments': {
                'energy-kcal_100g': 380,
                'proteins_100g': 13.5,
                'carbohydrates_100g': 60,
                'fat_100g': 7,
                'fiber_100g': 9,
                'sodium_100g': 0.005,
                'sugars_100g': 1,
              },
            },
          ],
        });
      });
      final api = FoodApiService(client: client);

      final foods = await api.searchFoods('avena');

      expect(foods, hasLength(1));
      final food = foods.single;
      expect(food.name, 'Avena tradicional');
      expect(food.category, 'online');
      expect(food.energia, '380');
      expect(food.proteina, '13.5');
      expect(food.hidratosDeCarbono, '60.0');
      expect(food.lipidos, '7.0');
      expect(food.micros?.fibra, '9.0');
      expect(food.description, 'Quaker · 500 g');
    });

    test('usa energy_100g / 4.184 cuando falta energy-kcal_100g', () async {
      final client = MockClient(
        (_) async => _json({
          'products': [
            {
              'product_name': 'Leche',
              'nutriments': {'energy_100g': 250},
            },
          ],
        }),
      );
      final api = FoodApiService(client: client);

      final foods = await api.searchFoods('leche');

      expect(foods.single.energia, '60');
    });

    test('omite productos sin nombre', () async {
      final client = MockClient(
        (_) async => _json({
          'products': [
            {'product_name': '', 'brands': 'X'},
            {'product_name': 'Válido', 'nutriments': {}},
          ],
        }),
      );
      final api = FoodApiService(client: client);

      final foods = await api.searchFoods('x');

      expect(foods, hasLength(1));
      expect(foods.single.name, 'Válido');
    });

    test('consulta vacía no hace peticiones', () async {
      var called = false;
      final client = MockClient((_) async {
        called = true;
        return _json({'products': []});
      });
      final api = FoodApiService(client: client);

      expect(await api.searchFoods('   '), isEmpty);
      expect(called, isFalse);
    });

    test('HTTP 500 devuelve lista vacía (fallback local)', () async {
      final client = MockClient((_) async => _json({}, status: 500));
      final api = FoodApiService(client: client);

      expect(await api.searchFoods('avena'), isEmpty);
    });

    test('JSON inválido devuelve lista vacía sin lanzar', () async {
      final client = MockClient((_) async => http.Response('no-json', 200));
      final api = FoodApiService(client: client);

      expect(await api.searchFoods('avena'), isEmpty);
    });
  });

  group('FoodApiService.getByBarcode', () {
    test('devuelve el producto cuando status es 1', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/v2/product/7501234567890.json');
        return _json({
          'status': 1,
          'product': {
            'product_name': 'Galletas',
            'nutriments': {'energy-kcal_100g': 450, 'proteins_100g': 6},
          },
        });
      });
      final api = FoodApiService(client: client);

      final food = await api.getByBarcode('7501234567890');

      expect(food, isNotNull);
      expect(food!.name, 'Galletas');
      expect(food.energia, '450');
    });

    test('limpia caracteres no numéricos del código', () async {
      final client = MockClient((request) async {
        expect(request.url.path, '/api/v2/product/7501234567890.json');
        return _json({'status': 0});
      });
      final api = FoodApiService(client: client);

      await api.getByBarcode('750-1234 567890');
    });

    test('código corto devuelve null sin petición', () async {
      var called = false;
      final client = MockClient((_) async {
        called = true;
        return _json({'status': 1});
      });
      final api = FoodApiService(client: client);

      expect(await api.getByBarcode('123'), isNull);
      expect(called, isFalse);
    });

    test('status 0 devuelve null', () async {
      final client = MockClient((_) async => _json({'status': 0}));
      final api = FoodApiService(client: client);

      expect(await api.getByBarcode('7501234567890'), isNull);
    });

    test('HTTP 404 devuelve null', () async {
      final client = MockClient((_) async => _json({}, status: 404));
      final api = FoodApiService(client: client);

      expect(await api.getByBarcode('7501234567890'), isNull);
    });
  });
}
