import 'package:nutriplato/infrastructure/entities/food/nutri_food.dart';

/// Contrato de búsqueda remota de alimentos.
///
/// Los consumidores dependen de esta abstracción (no de `FoodApiService`),
/// lo que permite inyectar implementaciones falsas en tests.
abstract interface class FoodSearchApi {
  /// Busca alimentos por nombre. Devuelve lista vacía si la red falla.
  Future<List<NutriFood>> searchFoods(String query, {int pageSize});

  /// Busca un producto por código de barras. Devuelve `null` si no existe
  /// o si la red falla.
  Future<NutriFood?> getByBarcode(String barcode);

  /// Libera los recursos del cliente (conexiones HTTP).
  void dispose();
}
