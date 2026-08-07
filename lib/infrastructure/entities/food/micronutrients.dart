/// Micronutrientes opcionales de un alimento.
///
/// Los valores se guardan como `String` para mantener el formato de la base
/// de datos. El valor `'ND'` (o vacío) significa "no disponible".
class Micronutrients {
  final String? fibra;
  final String? sodio;
  final String? calcio;
  final String? hierro;
  final String? potasio;
  final String? vitaminaA;
  final String? acidoAscorbico;
  final String? acidoFolico;
  final String? colesterol;
  final String? selenio;
  final String? fosforo;
  final String? azucarEquivalente;
  final String? indiceGlicemico;
  final String? cargaGlicemica;

  const Micronutrients({
    this.fibra,
    this.sodio,
    this.calcio,
    this.hierro,
    this.potasio,
    this.vitaminaA,
    this.acidoAscorbico,
    this.acidoFolico,
    this.colesterol,
    this.selenio,
    this.fosforo,
    this.azucarEquivalente,
    this.indiceGlicemico,
    this.cargaGlicemica,
  });

  static bool _available(String? v) =>
      v != null && v.trim().isNotEmpty && v.trim().toUpperCase() != 'ND';

  /// Valores numéricos disponibles (etiqueta, valor + unidad).
  List<MapEntry<String, String>> get availableItems {
    final items = <MapEntry<String, String>>[];
    void add(String label, String? v, String unit) {
      if (_available(v)) items.add(MapEntry(label, '${v!.trim()} $unit'));
    }

    add('Fibra', fibra, 'g');
    add('Sodio', sodio, 'mg');
    add('Calcio', calcio, 'mg');
    add('Hierro', hierro, 'mg');
    add('Potasio', potasio, 'mg');
    add('Vitamina A', vitaminaA, 'µg');
    add('Vitamina C', acidoAscorbico, 'mg');
    add('Ácido fólico', acidoFolico, 'µg');
    add('Colesterol', colesterol, 'mg');
    add('Selenio', selenio, 'µg');
    add('Fósforo', fosforo, 'mg');
    add('Azúcar equivalente', azucarEquivalente, 'g');
    return items;
  }

  /// Índice glucémico si está disponible (para badges).
  String? get indiceGlicemicoValue =>
      _available(indiceGlicemico) ? indiceGlicemico!.trim() : null;

  /// Carga glucémica si está disponible (para badges).
  String? get cargaGlicemicaValue =>
      _available(cargaGlicemica) ? cargaGlicemica!.trim() : null;

  Map<String, dynamic> toJson() => {
    'fibra': fibra,
    'sodio': sodio,
    'calcio': calcio,
    'hierro': hierro,
    'potasio': potasio,
    'vitaminaA': vitaminaA,
    'acidoAscorbico': acidoAscorbico,
    'acidoFolico': acidoFolico,
    'colesterol': colesterol,
    'selenio': selenio,
    'fosforo': fosforo,
    'azucarEquivalente': azucarEquivalente,
    'indiceGlicemico': indiceGlicemico,
    'cargaGlicemica': cargaGlicemica,
  };

  factory Micronutrients.fromJson(Map<String, dynamic> json) => Micronutrients(
    fibra: json['fibra'] as String?,
    sodio: json['sodio'] as String?,
    calcio: json['calcio'] as String?,
    hierro: json['hierro'] as String?,
    potasio: json['potasio'] as String?,
    vitaminaA: json['vitaminaA'] as String?,
    acidoAscorbico: json['acidoAscorbico'] as String?,
    acidoFolico: json['acidoFolico'] as String?,
    colesterol: json['colesterol'] as String?,
    selenio: json['selenio'] as String?,
    fosforo: json['fosforo'] as String?,
    azucarEquivalente: json['azucarEquivalente'] as String?,
    indiceGlicemico: json['indiceGlicemico'] as String?,
    cargaGlicemica: json['cargaGlicemica'] as String?,
  );
}
