import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:developer' as dev;

class FoodLogProvider with ChangeNotifier {
  List<DailyFoodLog> _logs = [];
  bool _isLoading = false;

  List<DailyFoodLog> get logs => _logs;
  bool get isLoading => _isLoading;

  // Obtener registro de un día específico
  DailyFoodLog? getDailyLog(DateTime date) {
    final formattedDate = DateTime(date.year, date.month, date.day);
    try {
      return _logs.firstWhere((log) =>
          log.date.year == formattedDate.year &&
          log.date.month == formattedDate.month &&
          log.date.day == formattedDate.day);
    } catch (e) {
      return null;
    }
  }

  // Agregar un alimento al registro
  Future<void> addFoodEntry(FoodLogEntry entry) async {
    _isLoading = true;
    notifyListeners();

    final formattedDate = DateTime(
        entry.timestamp.year, entry.timestamp.month, entry.timestamp.day);

    // Buscar si ya existe un registro para este día
    DailyFoodLog? dailyLog = getDailyLog(formattedDate);

    if (dailyLog != null) {
      // Si existe, agregar la entrada al día existente
      final index = _logs.indexOf(dailyLog);
      final updatedEntries = List<FoodLogEntry>.from(dailyLog.entries)
        ..add(entry);
      _logs[index] = DailyFoodLog(date: dailyLog.date, entries: updatedEntries);
    } else {
      // Si no existe, crear un nuevo registro para este día
      _logs.add(DailyFoodLog(
        date: formattedDate,
        entries: [entry],
      ));
    }

    await _saveLogs();

    _isLoading = false;
    notifyListeners();
  }

  // Eliminar un alimento del registro
  Future<void> removeFoodEntry(DateTime date, int entryIndex) async {
    _isLoading = true;
    notifyListeners();

    DailyFoodLog? dailyLog = getDailyLog(date);

    if (dailyLog != null) {
      final index = _logs.indexOf(dailyLog);
      final updatedEntries = List<FoodLogEntry>.from(dailyLog.entries);

      if (entryIndex >= 0 && entryIndex < updatedEntries.length) {
        updatedEntries.removeAt(entryIndex);

        if (updatedEntries.isEmpty) {
          _logs.removeAt(index);
        } else {
          _logs[index] =
              DailyFoodLog(date: dailyLog.date, entries: updatedEntries);
        }

        await _saveLogs();
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  // Cargar registros guardados
  Future<void> loadLogs() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();

      // Obtener los datos guardados de los días
      final days = prefs.getStringList('food_log_days') ?? [];

      _logs = []; // Limpiar los logs actuales

      // Para cada día guardado, cargar las entradas de ese día
      for (var dayStr in days) {
        // Convertir la cadena de fecha a DateTime
        final date = DateTime.parse(dayStr);

        // Obtener las entradas guardadas para ese día
        final entriesJson = prefs.getStringList('food_log_$dayStr') ?? [];
        List<FoodLogEntry> entries = [];

        // Convertir cada entrada JSON a un objeto FoodLogEntry
        for (var entryJson in entriesJson) {
          try {
            final entryMap = json.decode(entryJson);
            final foodMap = entryMap['food'];

            // Crear el objeto Food
            final food = Food(
              name: foodMap['name'],
              category: foodMap['category'],
              icon: Icon(IconData(foodMap['iconCodePoint'],
                  fontFamily: foodMap['iconFontFamily'])),
              color: Color(foodMap['color']),
              cantidadSugerida: foodMap['cantidadSugerida'],
              unidad: foodMap['unidad'],
              pesoRedondeado: foodMap['pesoRedondeado'],
              pesoNeto: foodMap['pesoNeto'],
              energia: foodMap['energia'],
              proteina: foodMap['proteina'],
              lipidos: foodMap['lipidos'],
              hidratosDeCarbono: foodMap['hidratosDeCarbono'],
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
            dev.log('Error al deserializar entrada: $e');
          }
        }

        // Agregar el registro diario si hay entradas
        if (entries.isNotEmpty) {
          _logs.add(DailyFoodLog(date: date, entries: entries));
        }
      }

      _isLoading = false;
      notifyListeners();
    } catch (e) {
      dev.log('Error al cargar registros: $e');
      _isLoading = false;
      notifyListeners();
    }
  }

  // Guardar registros
  Future<void> _saveLogs() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Guardar lista de fechas
      List<String> days = [];

      for (var dailyLog in _logs) {
        // Formato de fecha para usar como clave
        final dayStr = dailyLog.date.toIso8601String();
        days.add(dayStr);

        // Convertir las entradas a JSON
        List<String> entriesJson = [];

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
        await prefs.setStringList('food_log_$dayStr', entriesJson);
      }

      // Guardar la lista de días
      await prefs.setStringList('food_log_days', days);
    } catch (e) {
      dev.log('Error al guardar registros: $e');
    }
  }
}
