import 'package:flutter/foundation.dart';

/// Severidad de una condición médica
enum ConditionSeverity {
  mild('Leve'),
  moderate('Moderada'),
  severe('Severa');

  final String label;
  const ConditionSeverity(this.label);

  static ConditionSeverity fromString(String value) {
    return ConditionSeverity.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ConditionSeverity.mild,
    );
  }
}

/// Tipo de condición médica
enum ConditionType {
  metabolic('Metabólica'),
  cardiovascular('Cardiovascular'),
  digestive('Digestiva'),
  renal('Renal'),
  hormonal('Hormonal'),
  autoimmune('Autoinmune'),
  allergy('Alergia'),
  other('Otra');

  final String label;
  const ConditionType(this.label);

  static ConditionType fromString(String value) {
    return ConditionType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => ConditionType.other,
    );
  }
}

/// Modelo de condición médica del usuario
@immutable
class HealthCondition {
  final String id;
  final String name;
  final String description;
  final ConditionType type;
  final ConditionSeverity severity;
  final DateTime? diagnosisDate;
  final bool isControlled;
  final String? medication;
  final String? doctorNotes;

  // Restricciones dietéticas específicas
  final List<String> avoidFoods;
  final List<String> limitFoods;
  final List<String> recommendedFoods;
  final Map<String, double> nutrientLimits; // ej: {'sodium': 2000, 'sugar': 25}

  // Alertas
  final bool alertOnHighGlycemicIndex;
  final bool alertOnHighSodium;
  final bool alertOnHighSugar;
  final bool alertOnHighFat;
  final bool alertOnHighCholesterol;

  const HealthCondition({
    required this.id,
    required this.name,
    required this.description,
    required this.type,
    this.severity = ConditionSeverity.mild,
    this.diagnosisDate,
    this.isControlled = false,
    this.medication,
    this.doctorNotes,
    this.avoidFoods = const [],
    this.limitFoods = const [],
    this.recommendedFoods = const [],
    this.nutrientLimits = const {},
    this.alertOnHighGlycemicIndex = false,
    this.alertOnHighSodium = false,
    this.alertOnHighSugar = false,
    this.alertOnHighFat = false,
    this.alertOnHighCholesterol = false,
  });

  HealthCondition copyWith({
    String? id,
    String? name,
    String? description,
    ConditionType? type,
    ConditionSeverity? severity,
    DateTime? diagnosisDate,
    bool? isControlled,
    String? medication,
    String? doctorNotes,
    List<String>? avoidFoods,
    List<String>? limitFoods,
    List<String>? recommendedFoods,
    Map<String, double>? nutrientLimits,
    bool? alertOnHighGlycemicIndex,
    bool? alertOnHighSodium,
    bool? alertOnHighSugar,
    bool? alertOnHighFat,
    bool? alertOnHighCholesterol,
  }) {
    return HealthCondition(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      type: type ?? this.type,
      severity: severity ?? this.severity,
      diagnosisDate: diagnosisDate ?? this.diagnosisDate,
      isControlled: isControlled ?? this.isControlled,
      medication: medication ?? this.medication,
      doctorNotes: doctorNotes ?? this.doctorNotes,
      avoidFoods: avoidFoods ?? this.avoidFoods,
      limitFoods: limitFoods ?? this.limitFoods,
      recommendedFoods: recommendedFoods ?? this.recommendedFoods,
      nutrientLimits: nutrientLimits ?? this.nutrientLimits,
      alertOnHighGlycemicIndex:
          alertOnHighGlycemicIndex ?? this.alertOnHighGlycemicIndex,
      alertOnHighSodium: alertOnHighSodium ?? this.alertOnHighSodium,
      alertOnHighSugar: alertOnHighSugar ?? this.alertOnHighSugar,
      alertOnHighFat: alertOnHighFat ?? this.alertOnHighFat,
      alertOnHighCholesterol:
          alertOnHighCholesterol ?? this.alertOnHighCholesterol,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.name,
      'severity': severity.name,
      'diagnosisDate': diagnosisDate?.toIso8601String(),
      'isControlled': isControlled,
      'medication': medication,
      'doctorNotes': doctorNotes,
      'avoidFoods': avoidFoods,
      'limitFoods': limitFoods,
      'recommendedFoods': recommendedFoods,
      'nutrientLimits': nutrientLimits,
      'alertOnHighGlycemicIndex': alertOnHighGlycemicIndex,
      'alertOnHighSodium': alertOnHighSodium,
      'alertOnHighSugar': alertOnHighSugar,
      'alertOnHighFat': alertOnHighFat,
      'alertOnHighCholesterol': alertOnHighCholesterol,
    };
  }

  factory HealthCondition.fromJson(Map<String, dynamic> json) {
    return HealthCondition(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      type: ConditionType.fromString(json['type']),
      severity: ConditionSeverity.fromString(json['severity']),
      diagnosisDate: json['diagnosisDate'] != null
          ? DateTime.parse(json['diagnosisDate'])
          : null,
      isControlled: json['isControlled'] ?? false,
      medication: json['medication'],
      doctorNotes: json['doctorNotes'],
      avoidFoods: List<String>.from(json['avoidFoods'] ?? []),
      limitFoods: List<String>.from(json['limitFoods'] ?? []),
      recommendedFoods: List<String>.from(json['recommendedFoods'] ?? []),
      nutrientLimits: Map<String, double>.from(json['nutrientLimits'] ?? {}),
      alertOnHighGlycemicIndex: json['alertOnHighGlycemicIndex'] ?? false,
      alertOnHighSodium: json['alertOnHighSodium'] ?? false,
      alertOnHighSugar: json['alertOnHighSugar'] ?? false,
      alertOnHighFat: json['alertOnHighFat'] ?? false,
      alertOnHighCholesterol: json['alertOnHighCholesterol'] ?? false,
    );
  }
}

/// Condiciones médicas predefinidas comunes en México
class MexicanHealthConditions {
  static final diabetes = HealthCondition(
    id: 'diabetes_type_2',
    name: 'Diabetes Tipo 2',
    description:
        'Condición metabólica donde el cuerpo no produce suficiente insulina o no la usa eficientemente.',
    type: ConditionType.metabolic,
    avoidFoods: [
      'Refrescos',
      'Jugos industrializados',
      'Dulces',
      'Pan blanco',
      'Arroz blanco',
      'Papas fritas',
      'Galletas',
      'Pasteles',
      'Helado',
      'Miel',
      'Azúcar',
      'Cereales azucarados',
    ],
    limitFoods: [
      'Frutas muy dulces (uva, mango, plátano)',
      'Tortillas de harina',
      'Pan integral',
      'Pasta',
      'Arroz integral',
      'Papa',
      'Camote',
      'Maíz',
    ],
    recommendedFoods: [
      'Verduras de hoja verde',
      'Nopales',
      'Chayote',
      'Calabaza',
      'Brócoli',
      'Aguacate',
      'Nueces',
      'Almendras',
      'Pescado',
      'Pollo sin piel',
      'Frijoles',
      'Lentejas',
      'Chía',
      'Linaza',
    ],
    nutrientLimits: {
      'sugar': 25, // gramos por día
      'carbs': 130, // gramos por día (mínimo recomendado)
    },
    alertOnHighGlycemicIndex: true,
    alertOnHighSugar: true,
  );

  static final prediabetes = HealthCondition(
    id: 'prediabetes',
    name: 'Prediabetes',
    description:
        'Nivel de azúcar en sangre más alto de lo normal, pero no lo suficientemente alto para ser diabetes tipo 2.',
    type: ConditionType.metabolic,
    avoidFoods: [
      'Refrescos',
      'Jugos industrializados',
      'Dulces',
      'Pan blanco excesivo',
    ],
    limitFoods: [
      'Frutas muy dulces',
      'Pan blanco',
      'Arroz blanco',
      'Azúcar',
    ],
    recommendedFoods: [
      'Verduras',
      'Frutas con bajo índice glucémico',
      'Granos integrales',
      'Proteínas magras',
      'Nopales',
      'Chía',
    ],
    nutrientLimits: {
      'sugar': 35,
    },
    alertOnHighGlycemicIndex: true,
    alertOnHighSugar: true,
  );

  static final hipertension = HealthCondition(
    id: 'hipertension',
    name: 'Hipertensión Arterial',
    description:
        'Presión arterial elevada que aumenta el riesgo de enfermedades cardíacas.',
    type: ConditionType.cardiovascular,
    avoidFoods: [
      'Sal de mesa en exceso',
      'Embutidos',
      'Carnes procesadas',
      'Sopas instantáneas',
      'Botanas saladas',
      'Quesos muy salados',
      'Encurtidos',
      'Salsas comerciales',
      'Comida rápida',
    ],
    limitFoods: [
      'Carnes rojas',
      'Queso',
      'Pan comercial',
      'Cereales procesados',
    ],
    recommendedFoods: [
      'Plátano',
      'Aguacate',
      'Espinacas',
      'Jitomate',
      'Betabel',
      'Ajo',
      'Cebolla',
      'Pescado',
      'Avena',
      'Nueces',
      'Frijoles',
      'Lentejas',
      'Jamaica (sin azúcar)',
    ],
    nutrientLimits: {
      'sodium': 1500, // mg por día
    },
    alertOnHighSodium: true,
  );

  static final colesterolAlto = HealthCondition(
    id: 'colesterol_alto',
    name: 'Colesterol Alto',
    description:
        'Niveles elevados de colesterol en sangre que aumentan el riesgo cardiovascular.',
    type: ConditionType.cardiovascular,
    avoidFoods: [
      'Manteca de cerdo',
      'Chicharrón',
      'Vísceras',
      'Yema de huevo en exceso',
      'Mantequilla',
      'Crema',
      'Embutidos',
      'Carnes grasas',
      'Comida frita',
      'Mariscos con cáscara en exceso',
    ],
    limitFoods: [
      'Huevo entero',
      'Carnes rojas',
      'Queso',
      'Leche entera',
    ],
    recommendedFoods: [
      'Avena',
      'Manzana',
      'Frijoles',
      'Lentejas',
      'Nueces',
      'Almendras',
      'Aguacate',
      'Aceite de oliva',
      'Pescado (salmón, sardina)',
      'Ajo',
      'Cebolla',
      'Alcachofa',
      'Nopal',
    ],
    nutrientLimits: {
      'cholesterol': 200, // mg por día
      'saturatedFat': 15, // gramos
    },
    alertOnHighCholesterol: true,
    alertOnHighFat: true,
  );

  static final obesidad = HealthCondition(
    id: 'obesidad',
    name: 'Obesidad',
    description:
        'Acumulación excesiva de grasa corporal que puede afectar la salud.',
    type: ConditionType.metabolic,
    avoidFoods: [
      'Refrescos',
      'Comida rápida',
      'Frituras',
      'Dulces',
      'Galletas',
      'Pan dulce',
      'Helados',
      'Botanas empaquetadas',
    ],
    limitFoods: [
      'Tortillas (máximo 3 al día)',
      'Pan',
      'Arroz',
      'Pasta',
      'Frutas muy dulces',
    ],
    recommendedFoods: [
      'Verduras en general',
      'Frutas con bajo índice glucémico',
      'Proteínas magras',
      'Agua natural',
      'Té sin azúcar',
      'Nopal',
      'Chayote',
      'Pepino',
    ],
    alertOnHighSugar: true,
    alertOnHighFat: true,
  );

  static final enfRenalCronica = HealthCondition(
    id: 'enfermedad_renal_cronica',
    name: 'Enfermedad Renal Crónica',
    description:
        'Pérdida gradual de la función renal que requiere ajustes dietéticos específicos.',
    type: ConditionType.renal,
    avoidFoods: [
      'Alimentos muy salados',
      'Embutidos',
      'Nueces y semillas en exceso',
      'Plátano',
      'Naranja',
      'Jitomate en exceso',
      'Papa',
      'Aguacate en exceso',
      'Chocolate',
      'Refrescos cola',
    ],
    limitFoods: [
      'Carnes rojas',
      'Lácteos',
      'Leguminosas',
      'Granos integrales',
    ],
    recommendedFoods: [
      'Clara de huevo',
      'Pescado blanco',
      'Pollo',
      'Manzana',
      'Pera',
      'Zanahoria cocida',
      'Chayote',
      'Calabaza',
      'Arroz blanco',
      'Pan blanco',
    ],
    nutrientLimits: {
      'sodium': 1500,
      'potassium': 2000,
      'phosphorus': 800,
      'protein': 0.8, // g/kg de peso corporal
    },
    alertOnHighSodium: true,
  );

  static final gastritis = HealthCondition(
    id: 'gastritis',
    name: 'Gastritis',
    description:
        'Inflamación del revestimiento del estómago que causa molestias digestivas.',
    type: ConditionType.digestive,
    avoidFoods: [
      'Chile',
      'Salsa picante',
      'Café',
      'Alcohol',
      'Cítricos',
      'Jitomate',
      'Vinagre',
      'Frituras',
      'Embutidos',
      'Refrescos',
      'Chocolate',
      'Menta',
    ],
    limitFoods: [
      'Cebolla cruda',
      'Ajo crudo',
      'Condimentos fuertes',
      'Grasas',
    ],
    recommendedFoods: [
      'Avena',
      'Manzana',
      'Papaya',
      'Plátano',
      'Pollo hervido',
      'Pescado',
      'Arroz',
      'Papa cocida',
      'Zanahoria cocida',
      'Calabaza',
      'Manzanilla',
      'Sábila',
    ],
  );

  static final celiaquia = HealthCondition(
    id: 'celiaquia',
    name: 'Enfermedad Celíaca',
    description: 'Intolerancia al gluten que daña el intestino delgado.',
    type: ConditionType.autoimmune,
    avoidFoods: [
      'Trigo',
      'Cebada',
      'Centeno',
      'Avena regular',
      'Pan tradicional',
      'Pasta',
      'Galletas',
      'Cerveza',
      'Salsas con gluten',
      'Empanizados',
    ],
    limitFoods: [],
    recommendedFoods: [
      'Maíz',
      'Tortilla de maíz',
      'Arroz',
      'Quinoa',
      'Amaranto',
      'Frijoles',
      'Frutas',
      'Verduras',
      'Carnes naturales',
      'Huevo',
      'Lácteos',
    ],
  );

  static final intoleranciaLactosa = HealthCondition(
    id: 'intolerancia_lactosa',
    name: 'Intolerancia a la Lactosa',
    description: 'Incapacidad para digerir el azúcar de la leche (lactosa).',
    type: ConditionType.digestive,
    avoidFoods: [
      'Leche',
      'Queso fresco',
      'Crema',
      'Helado',
      'Yogurt regular',
      'Mantequilla',
      'Postres con leche',
    ],
    limitFoods: [
      'Quesos añejos (tienen menos lactosa)',
    ],
    recommendedFoods: [
      'Leche deslactosada',
      'Leche de almendra',
      'Leche de soya',
      'Leche de avena',
      'Yogurt deslactosado',
      'Quesos duros',
      'Tofu',
    ],
  );

  static final hipotiroidismo = HealthCondition(
    id: 'hipotiroidismo',
    name: 'Hipotiroidismo',
    description: 'Tiroides poco activa que ralentiza el metabolismo.',
    type: ConditionType.hormonal,
    avoidFoods: [
      'Soya en exceso',
      'Brócoli crudo en exceso',
      'Col cruda',
      'Coliflor cruda',
      'Gluten (si hay sensibilidad)',
    ],
    limitFoods: [
      'Crucíferas crudas',
      'Alimentos procesados',
    ],
    recommendedFoods: [
      'Mariscos',
      'Pescado',
      'Huevo',
      'Nueces de Brasil',
      'Semillas de calabaza',
      'Espinacas',
      'Lentejas',
      'Plátano',
      'Aguacate',
    ],
  );

  static final anemia = HealthCondition(
    id: 'anemia',
    name: 'Anemia',
    description: 'Deficiencia de glóbulos rojos o hemoglobina en la sangre.',
    type: ConditionType.other,
    avoidFoods: [
      'Café con las comidas',
      'Té negro con las comidas',
      'Lácteos con comidas ricas en hierro',
    ],
    limitFoods: [
      'Alimentos con fitatos en exceso',
    ],
    recommendedFoods: [
      'Hígado',
      'Carne roja magra',
      'Espinacas',
      'Lentejas',
      'Frijoles',
      'Garbanzos',
      'Betabel',
      'Huevo',
      'Cítricos (vitamina C)',
      'Guayaba',
      'Kiwi',
      'Brócoli',
    ],
  );

  /// Lista de todas las condiciones predefinidas
  static List<HealthCondition> get all => [
        diabetes,
        prediabetes,
        hipertension,
        colesterolAlto,
        obesidad,
        enfRenalCronica,
        gastritis,
        celiaquia,
        intoleranciaLactosa,
        hipotiroidismo,
        anemia,
      ];

  /// Busca una condición por ID
  static HealthCondition? getById(String id) {
    try {
      return all.firstWhere((c) => c.id == id);
    } catch (e) {
      return null;
    }
  }

  /// Obtiene condiciones por tipo
  static List<HealthCondition> getByType(ConditionType type) {
    return all.where((c) => c.type == type).toList();
  }
}

/// Modelo para el registro de métricas de salud del usuario
@immutable
class HealthMetric {
  final String id;
  final DateTime date;
  final HealthMetricType type;
  final double value;
  final String? unit;
  final String? notes;

  const HealthMetric({
    required this.id,
    required this.date,
    required this.type,
    required this.value,
    this.unit,
    this.notes,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date.toIso8601String(),
      'type': type.name,
      'value': value,
      'unit': unit,
      'notes': notes,
    };
  }

  factory HealthMetric.fromJson(Map<String, dynamic> json) {
    return HealthMetric(
      id: json['id'],
      date: DateTime.parse(json['date']),
      type: HealthMetricType.fromString(json['type']),
      value: json['value'].toDouble(),
      unit: json['unit'],
      notes: json['notes'],
    );
  }
}

/// Tipos de métricas de salud
enum HealthMetricType {
  weight('Peso', 'kg'),
  bloodGlucose('Glucosa en sangre', 'mg/dL'),
  bloodPressureSystolic('Presión sistólica', 'mmHg'),
  bloodPressureDiastolic('Presión diastólica', 'mmHg'),
  heartRate('Frecuencia cardíaca', 'bpm'),
  waistCircumference('Circunferencia de cintura', 'cm'),
  bodyFatPercentage('Porcentaje de grasa', '%'),
  cholesterolTotal('Colesterol total', 'mg/dL'),
  cholesterolLDL('Colesterol LDL', 'mg/dL'),
  cholesterolHDL('Colesterol HDL', 'mg/dL'),
  triglycerides('Triglicéridos', 'mg/dL'),
  hemoglobinA1c('Hemoglobina A1c', '%'),
  waterIntake('Consumo de agua', 'vasos'),
  sleepHours('Horas de sueño', 'hrs');

  final String label;
  final String unit;

  const HealthMetricType(this.label, this.unit);

  static HealthMetricType fromString(String value) {
    return HealthMetricType.values.firstWhere(
      (e) => e.name == value,
      orElse: () => HealthMetricType.weight,
    );
  }
}
