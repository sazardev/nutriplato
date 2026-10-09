import 'dart:convert';
import 'dart:developer' as dev;

import 'package:flutter/services.dart';
import 'package:nutriplato/infrastructure/repositories/preferences_repository.dart';
import 'package:share_plus/share_plus.dart';

/// Servicio de respaldo (backup) y restauración de datos.
///
/// Exporta todas las claves persistidas a un JSON, permitiendo compartirlo o
/// copiarlo al portapapeles. La restauración se hace desde el texto del
/// backup y pide reiniciar la app para recargar los providers.
class BackupService {
  static const _tag = 'NutriPlato|BackupService';

  /// Recopila todas las claves persistidas en un mapa JSON.
  static Future<Map<String, dynamic>> exportData(
    PreferencesRepository preferences,
  ) async {
    final data = <String, dynamic>{...preferences.exportAll()};

    data['_exportedAt'] = DateTime.now().toIso8601String();
    data['_app'] = 'NutriPlato';
    data['_version'] = '3.0.0';
    dev.log('exportData → ${data.length} claves exportadas', name: _tag);
    return data;
  }

  static String _toJson(Map<String, dynamic> data) =>
      const JsonEncoder.withIndent('  ').convert(data);

  /// Abre el diálogo de compartir con el JSON como texto.
  static Future<void> shareBackup(PreferencesRepository preferences) async {
    final json = _toJson(await exportData(preferences));
    try {
      await SharePlus.instance.share(
        ShareParams(text: json, subject: 'Respaldo de mis datos NutriPlato'),
      );
      dev.log('shareBackup → compartido', name: _tag);
    } on MissingPluginException {
      dev.log(
        'shareBackup → share no disponible, copiando al portapapeles',
        name: _tag,
      );
      await copyToClipboard(preferences);
    }
  }

  /// Copia el respaldo al portapapeles.
  static Future<String> copyToClipboard(
    PreferencesRepository preferences,
  ) async {
    final json = _toJson(await exportData(preferences));
    await Clipboard.setData(ClipboardData(text: json));
    dev.log('copyToClipboard → ${json.length} caracteres', name: _tag);
    return json;
  }

  /// Restaura todas las claves a partir de un JSON.
  /// Devuelve la cantidad de claves restauradas, o -1 en error.
  static Future<int> restoreFromJson(
    PreferencesRepository preferences,
    String json,
  ) async {
    try {
      final map = jsonDecode(json) as Map<String, dynamic>;
      var restored = 0;

      for (final entry in map.entries) {
        if (entry.key.startsWith('_')) continue; // metadatos
        await preferences.restoreValue(entry.key, entry.value);
        restored++;
      }

      dev.log('restoreFromJson → $restored claves restauradas', name: _tag);
      return restored;
    } catch (e, st) {
      dev.log(
        'restoreFromJson → ERROR: $e',
        name: _tag,
        error: e,
        stackTrace: st,
      );
      return -1;
    }
  }
}
