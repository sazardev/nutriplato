import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/micronutrients.dart';
import 'package:nutriplato/infrastructure/entities/food/micros_helper.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';

const _tag = 'NutriPlato|FoodLogProvider';

const String _faPackage = 'font_awesome_flutter';
const String _faSolid = 'FontAwesomeSolid';
const String _faRegular = 'FontAwesomeRegular';

/// Iconos de alimentos reconstruidos desde JSON por codepoint.
///
/// Deben ser constantes: `IconData(...)` dinámico rompe el tree-shaking de
/// iconos en los builds de release (AOT). El codepoint se conserva en los
/// registros guardados; si no se reconoce, se usa un icono genérico.
const Map<int, IconData> _foodIconByCodePoint = {
  0xe2cd: IconData(0xe2cd, fontFamily: _faSolid, fontPackage: _faPackage),
  0xe4c6: IconData(0xe4c6, fontFamily: _faSolid, fontPackage: _faPackage),
  0xe4f4: IconData(0xe4f4, fontFamily: _faSolid, fontPackage: _faPackage),
  0xe516: IconData(0xe516, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf000: IconData(0xf000, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf043: IconData(0xf043, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf06c: IconData(0xf06c, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf094: IconData(0xf094, fontFamily: _faRegular, fontPackage: _faPackage),
  0xf0c3: IconData(0xf0c3, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf0f4: IconData(0xf0f4, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf0fc: IconData(0xf0fc, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf1b2: IconData(0xf1b2, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf290: IconData(0xf290, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf4d8: IconData(0xf4d8, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf4e3: IconData(0xf4e3, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf517: IconData(0xf517, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf564: IconData(0xf564, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf576: IconData(0xf576, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf578: IconData(0xf578, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf5a7: IconData(0xf5a7, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf5ce: IconData(0xf5ce, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf5d1: IconData(0xf5d1, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf6c8: IconData(0xf6c8, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf6d7: IconData(0xf6d7, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf786: IconData(0xf786, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf787: IconData(0xf787, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf7b6: IconData(0xf7b6, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf7e4: IconData(0xf7e4, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf7e5: IconData(0xf7e5, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf810: IconData(0xf810, fontFamily: _faSolid, fontPackage: _faPackage),
  0xf818: IconData(0xf818, fontFamily: _faSolid, fontPackage: _faPackage),
};

class FoodLogProvider with ChangeNotifier {
  FoodLogProvider(this._preferences);

  final PreferencesRepository _preferences;

  List<DailyFoodLog> _logs = [];
  bool _isLoading = false;

  List<DailyFoodLog> get logs => _logs;
  bool get isLoading => _isLoading;

  // Obtener registro de un día específico
  DailyFoodLog? getDailyLog(DateTime date) {
    final formattedDate = DateTime(date.year, date.month, date.day);
    try {
      return _logs.firstWhere(
        (log) =>
            log.date.year == formattedDate.year &&
            log.date.month == formattedDate.month &&
            log.date.day == formattedDate.day,
      );
    } catch (e) {
      return null;
    }
  }

  // Agregar un alimento al registro
  Future<void> addFoodEntry(FoodLogEntry entry) async {
    dev.log(
      'addFoodEntry → "${entry.food.name}" '
      'cat=${entry.food.category} '
      'qty=${entry.quantity} '
      'meal=${entry.mealType} '
      'kcal=${entry.food.energia} '
      'fecha=${entry.timestamp.toIso8601String().substring(0, 10)}',
      name: _tag,
    );
    _isLoading = true;
    notifyListeners();

    final formattedDate = DateTime(
      entry.timestamp.year,
      entry.timestamp.month,
      entry.timestamp.day,
    );

    // Buscar si ya existe un registro para este día
    final DailyFoodLog? dailyLog = getDailyLog(formattedDate);

    if (dailyLog != null) {
      // Si existe, agregar la entrada al día existente
      final index = _logs.indexOf(dailyLog);
      final updatedEntries = List<FoodLogEntry>.from(dailyLog.entries)
        ..add(entry);
      _logs[index] = DailyFoodLog(date: dailyLog.date, entries: updatedEntries);
      dev.log(
        'addFoodEntry → día existente actualizado (${updatedEntries.length} entradas)',
        name: _tag,
      );
    } else {
      // Si no existe, crear un nuevo registro para este día
      _logs.add(DailyFoodLog(date: formattedDate, entries: [entry]));
      dev.log(
        'addFoodEntry → nuevo día de registro creado (total días: ${_logs.length})',
        name: _tag,
      );
    }

    await _saveLogs();

    _isLoading = false;
    notifyListeners();
  }

  // Eliminar un alimento del registro
  Future<void> removeFoodEntry(DateTime date, int entryIndex) async {
    dev.log(
      'removeFoodEntry → fecha=${date.toIso8601String().substring(0, 10)} idx=$entryIndex',
      name: _tag,
    );
    _isLoading = true;
    notifyListeners();

    final DailyFoodLog? dailyLog = getDailyLog(date);

    if (dailyLog != null) {
      final index = _logs.indexOf(dailyLog);
      final updatedEntries = List<FoodLogEntry>.from(dailyLog.entries);

      if (entryIndex >= 0 && entryIndex < updatedEntries.length) {
        final removed = updatedEntries[entryIndex];
        updatedEntries.removeAt(entryIndex);
        dev.log(
          'removeFoodEntry → eliminado "${removed.food.name}" (${updatedEntries.length} entradas restantes)',
          name: _tag,
        );

        if (updatedEntries.isEmpty) {
          _logs.removeAt(index);
          dev.log('removeFoodEntry → día vacío eliminado', name: _tag);
        } else {
          _logs[index] = DailyFoodLog(
            date: dailyLog.date,
            entries: updatedEntries,
          );
        }

        await _saveLogs();
      } else {
        dev.log(
          'removeFoodEntry → índice $entryIndex inválido (max=${updatedEntries.length - 1})',
          name: _tag,
        );
      }
    } else {
      dev.log(
        'removeFoodEntry → no se encontró log para esa fecha',
        name: _tag,
      );
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar registros guardados
  Future<void> loadLogs() async {
    dev.log('loadLogs → iniciando carga de registros', name: _tag);
    _isLoading = true;
    notifyListeners();

    try {
      // Obtener los datos guardados de los días
      final days = _preferences.foodLogDays;
      dev.log(
        'loadLogs → ${days.length} días encontrados en storage',
        name: _tag,
      );

      _logs = []; // Limpiar los logs actuales

      // Para cada día guardado, cargar las entradas de ese día
      for (var dayStr in days) {
        // Convertir la cadena de fecha a DateTime
        final date = DateTime.parse(dayStr);

        // Obtener las entradas guardadas para ese día
        final entriesJson = _preferences.getFoodLogEntries(dayStr);
        final List<FoodLogEntry> entries = [];

        // Convertir cada entrada JSON a un objeto FoodLogEntry
        for (var entryJson in entriesJson) {
          try {
            final entryMap = json.decode(entryJson);
            final foodMap = entryMap['food'];

            // Resolver el icono guardado por codepoint (constantes) con
            // respaldo genérico para entradas desconocidas.
            final rawCodePoint = foodMap['iconCodePoint'];
            final codePoint = rawCodePoint is int
                ? rawCodePoint
                : int.tryParse('$rawCodePoint');

            // Crear el objeto Food
            final food = Food(
              name: foodMap['name'],
              category: foodMap['category'],
              icon: Icon(_foodIconByCodePoint[codePoint] ?? Icons.restaurant),
              color: Color(foodMap['color']),
              cantidadSugerida: foodMap['cantidadSugerida'],
              unidad: foodMap['unidad'],
              pesoRedondeado: foodMap['pesoRedondeado'],
              pesoNeto: foodMap['pesoNeto'],
              energia: foodMap['energia'],
              proteina: foodMap['proteina'],
              lipidos: foodMap['lipidos'],
              hidratosDeCarbono: foodMap['hidratosDeCarbono'],
              micros: foodMap['micros'] != null
                  ? Micronutrients.fromJson(
                      foodMap['micros'] as Map<String, dynamic>,
                    )
                  : null,
            );

            // Crear la entrada del registro
            final entry = FoodLogEntry(
              food: food,
              quantity: entryMap['quantity'],
              timestamp: DateTime.parse(entryMap['timestamp']),
              mealType: entryMap['mealType'],
            );

            entries.add(entry);
          } catch (e) {
            // Ignorar entradas mal formadas
            dev.log('loadLogs → ERROR deserializando entrada: $e', name: _tag);
          }
        }

        // Agregar el registro diario si hay entradas
        if (entries.isNotEmpty) {
          _logs.add(DailyFoodLog(date: date, entries: entries));
          dev.log(
            'loadLogs → día $dayStr cargado (${entries.length} entradas)',
            name: _tag,
          );
        }
      }

      _isLoading = false;
      final totalEntries = _logs.fold(
        0,
        (sum, log) => sum + log.entries.length,
      );
      dev.log(
        'loadLogs → completado. ${_logs.length} días, $totalEntries entradas en total',
        name: _tag,
      );
      notifyListeners();
    } catch (e, st) {
      dev.log('loadLogs → ERROR: $e', name: _tag, error: e, stackTrace: st);
      _isLoading = false;
      notifyListeners();
    }
  }

  // Guardar registros
  Future<void> _saveLogs() async {
    dev.log('_saveLogs → guardando ${_logs.length} días', name: _tag);
    try {
      // Guardar lista de fechas
      final List<String> days = [];

      for (var dailyLog in _logs) {
        // Formato de fecha para usar como clave
        final dayStr = dailyLog.date.toIso8601String();
        days.add(dayStr);

        // Convertir las entradas a JSON
        final List<String> entriesJson = [];

        for (var entry in dailyLog.entries) {
          // Convertir el objeto Food a un mapa
          final foodMap = {
            'name': entry.food.name,
            'category': entry.food.category,
            'iconCodePoint': entry.food.icon.icon!.codePoint,
            'iconFontFamily': entry.food.icon.icon!.fontFamily,
            'color': entry.food.color,
            'cantidadSugerida': entry.food.cantidadSugerida,
            'unidad': entry.food.unidad,
            'pesoRedondeado': entry.food.pesoRedondeado,
            'pesoNeto': entry.food.pesoNeto,
            'energia': entry.food.energia,
            'proteina': entry.food.proteina,
            'lipidos': entry.food.lipidos,
            'hidratosDeCarbono': entry.food.hidratosDeCarbono,
            if (microsOf(entry.food) != null)
              'micros': microsOf(entry.food)!.toJson(),
          };

          // Convertir la entrada a un mapa
          final entryMap = {
            'food': foodMap,
            'quantity': entry.quantity,
            'timestamp': entry.timestamp.toIso8601String(),
            'mealType': entry.mealType,
          };

          // Convertir el mapa a JSON
          entriesJson.add(json.encode(entryMap));
        }

        // Guardar las entradas de este día
        await _preferences.setFoodLogEntries(dayStr, entriesJson);
      }

      // Guardar la lista de días
      await _preferences.setFoodLogDays(days);
      dev.log('_saveLogs → guardado OK (${days.length} días)', name: _tag);
    } catch (e, st) {
      dev.log('_saveLogs → ERROR: $e', name: _tag, error: e, stackTrace: st);
    }
  }
}
