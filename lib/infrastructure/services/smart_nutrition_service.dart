import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/fruta.dart';
import 'package:nutriplato/infrastructure/entities/food/verdura.dart';
import 'package:nutriplato/infrastructure/entities/food/cereal.dart';
import 'package:nutriplato/infrastructure/entities/food/leguminosa.dart';
import 'package:nutriplato/infrastructure/entities/user/user_profile.dart';
import 'package:nutriplato/infrastructure/entities/health/health_condition.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/leguminosas.dart';

/// Helper para obtener fibra de diferentes tipos de alimentos
double getFibraFromFood(Food food) {
  if (food is Fruta) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Verdura) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Cereal) {
    return double.tryParse(food.fibra) ?? 0;
  } else if (food is Leguminosa) {
    return double.tryParse(food.fibra) ?? 0;
  }
  return 0;
}

/// Dato curioso sobre un alimento
class FoodFact {
  final String title;
  final String fact;
  final String? source;
  final IconData icon;
  final Color color;

  const FoodFact({
    required this.title,
    required this.fact,
    this.source,
    required this.icon,
    required this.color,
  });
}

/// Sugerencia de alimento
class FoodSuggestion {
  final Food food;
  final String reason;
  final double score; // 0-100
  final List<String> benefits;
  final SuggestionType type;

  const FoodSuggestion({
    required this.food,
    required this.reason,
    required this.score,
    required this.benefits,
    required this.type,
  });
}

enum SuggestionType {
  recommended,
  alternative,
  avoid,
  limitConsumption,
}

/// Plan de comidas diario
class DailyMealPlan {
  final DateTime date;
  final List<MealSuggestion> breakfast;
  final List<MealSuggestion> lunch;
  final List<MealSuggestion> dinner;
  final List<MealSuggestion> snacks;
  final double totalCalories;
  final Map<String, double> macros;

  const DailyMealPlan({
    required this.date,
    required this.breakfast,
    required this.lunch,
    required this.dinner,
    required this.snacks,
    required this.totalCalories,
    required this.macros,
  });
}

class MealSuggestion {
  final Food food;
  final double portions;
  final String preparationTip;
  final double calories;

  const MealSuggestion({
    required this.food,
    required this.portions,
    required this.preparationTip,
    required this.calories,
  });
}

/// Tip de nutrición
class NutritionTip {
  final String title;
  final String description;
  final String category;
  final IconData icon;
  final Color color;

  const NutritionTip({
    required this.title,
    required this.description,
    required this.category,
    required this.icon,
    required this.color,
  });
}

/// Servicio inteligente de nutricion
class SmartNutritionService {
  // Cache de todos los alimentos
  static List<Food>? _allFoods;

  /// Obtiene todos los alimentos disponibles
  static List<Food> getAllFoods() {
    if (_allFoods != null) return _allFoods!;

    _allFoods = [
      ...frutas.cast<Food>(),
      ...verduras.cast<Food>(),
      ...cereales.cast<Food>(),
      ...animals.cast<Food>(),
      ...leguminosas.cast<Food>(),
    ];

    return _allFoods!;
  }

  /// Genera datos curiosos sobre alimentos
  static List<FoodFact> getFoodFacts() {
    return const [
      // ============ FRUTAS ============
      FoodFact(
        title: 'Aguacate: La fruta del corazón',
        fact:
            'El aguacate contiene más potasio que el plátano y es rico en grasas monoinsaturadas que ayudan a reducir el colesterol malo. México produce el 30% del aguacate mundial.',
        icon: Icons.favorite,
        color: Colors.green,
        source: 'SAGARPA México',
      ),
      FoodFact(
        title: 'Plátano: Energía instantánea',
        fact:
            'Un plátano mediano proporciona aproximadamente 105 calorías y es una excelente fuente de vitamina B6, esencial para el metabolismo. Los atletas lo prefieren antes de competir.',
        icon: Icons.bolt,
        color: Colors.yellow,
        source: 'USDA',
      ),
      FoodFact(
        title: 'Manzana: El cepillo natural',
        fact:
            'Comer una manzana estimula la producción de saliva, reduciendo las bacterias bucales. Contiene pectina, una fibra que alimenta las bacterias buenas del intestino.',
        icon: Icons.apple,
        color: Colors.red,
        source: 'Journal of Dental Research',
      ),
      FoodFact(
        title: 'Limón: Vitamina C concentrada',
        fact:
            'Un limón contiene aproximadamente el 51% de la vitamina C diaria recomendada. Los marineros británicos comían cítricos para prevenir el escorbuto, de ahí el apodo "limeys".',
        icon: Icons.local_drink,
        color: Colors.amber,
        source: 'Historia de la nutrición',
      ),
      FoodFact(
        title: 'Papaya: Digestión natural',
        fact:
            'La papaya contiene papaína, una enzima que ayuda a digerir las proteínas. Una taza aporta el 224% de la vitamina C diaria. México es el 5to productor mundial.',
        icon: Icons.spa,
        color: Colors.orange,
        source: 'FAO',
      ),
      FoodFact(
        title: 'Mango: Rey de las frutas',
        fact:
            'El mango es la fruta nacional de India, Pakistán y Filipinas. Un mango mediano contiene 3g de fibra y el 100% de la vitamina C diaria. México es el principal exportador.',
        icon: Icons.local_florist,
        color: Colors.orange,
        source: 'SAGARPA',
      ),
      FoodFact(
        title: 'Sandía: Hidratación natural',
        fact:
            'La sandía es 92% agua, perfecta para hidratarse. Contiene licopeno (más que el jitomate) y citrulina, un aminoácido que mejora el flujo sanguíneo.',
        icon: Icons.water_drop,
        color: Colors.red,
        source: 'Journal of Agricultural and Food Chemistry',
      ),
      FoodFact(
        title: 'Piña: Antiinflamatorio natural',
        fact:
            'La piña contiene bromelina, una enzima con propiedades antiinflamatorias usada en suplementos deportivos. También ayuda a ablandar carnes cuando se usa como marinada.',
        icon: Icons.local_florist,
        color: Colors.yellow,
        source: 'NCBI',
      ),
      FoodFact(
        title: 'Guayaba: Campeona de vitamina C',
        fact:
            'La guayaba contiene 4 veces más vitamina C que la naranja. Una sola guayaba aporta el 628% de tu requerimiento diario de esta vitamina.',
        icon: Icons.emoji_nature,
        color: Colors.pink,
        source: 'USDA',
      ),
      FoodFact(
        title: 'Naranja: Más que vitamina C',
        fact:
            'Además de vitamina C, las naranjas contienen hesperidina, un flavonoide que mejora la circulación sanguínea y reduce la presión arterial.',
        icon: Icons.brightness_5,
        color: Colors.orange,
        source: 'American Heart Association',
      ),
      FoodFact(
        title: 'Fresas: Antioxidantes rojos',
        fact:
            'Las fresas tienen más vitamina C que las naranjas por porción. Su color rojo viene de antocianinas, potentes antioxidantes que protegen el corazón.',
        icon: Icons.favorite_border,
        color: Colors.red,
        source: 'Journal of Nutrition',
      ),
      FoodFact(
        title: 'Kiwi: Pequeño pero poderoso',
        fact:
            'El kiwi tiene más vitamina C que la naranja y más potasio que el plátano. Estudios muestran que comer 2 kiwis antes de dormir mejora la calidad del sueño.',
        icon: Icons.nights_stay,
        color: Colors.green,
        source: 'Asia Pacific Journal of Clinical Nutrition',
      ),

      // ============ VERDURAS ============
      FoodFact(
        title: 'Espinaca: El secreto de Popeye',
        fact:
            'La espinaca es rica en hierro, pero también contiene oxalatos que pueden inhibir su absorción. Combínala con vitamina C (limón) para maximizar beneficios.',
        icon: Icons.eco,
        color: Colors.green,
        source: 'INSP México',
      ),
      FoodFact(
        title: 'Zanahoria: Visión nocturna',
        fact:
            'Las zanahorias son ricas en beta-caroteno, que el cuerpo convierte en vitamina A. Esta vitamina es esencial para la visión, especialmente en condiciones de poca luz.',
        icon: Icons.visibility,
        color: Colors.orange,
        source: 'American Optometric Association',
      ),
      FoodFact(
        title: 'Brócoli: El superalimento',
        fact:
            'El brócoli contiene sulforafano, un compuesto con propiedades anticancerígenas. Cocerlo al vapor por 3-4 minutos maximiza estos beneficios sin destruir los nutrientes.',
        icon: Icons.spa,
        color: Colors.green,
        source: 'Journal of Cancer Prevention',
      ),
      FoodFact(
        title: 'Nopal: Tesoro mexicano',
        fact:
            'El nopal es bajo en calorías (16 kcal/100g), alto en fibra y estudios del IPN demuestran que ayuda a controlar la glucosa en diabéticos hasta en un 17%.',
        icon: Icons.local_florist,
        color: Colors.green,
        source: 'Instituto Politécnico Nacional',
      ),
      FoodFact(
        title: 'Jitomate: Licopeno poderoso',
        fact:
            'El jitomate cocido tiene más licopeno disponible que el crudo. Este antioxidante reduce el riesgo de cáncer de próstata y enfermedades cardiovasculares.',
        icon: Icons.brightness_1,
        color: Colors.red,
        source: 'Harvard Health',
      ),
      FoodFact(
        title: 'Ajo: Antibiótico natural',
        fact:
            'El ajo contiene alicina, un compuesto con propiedades antibacterianas y antivirales. Machacar el ajo y dejarlo reposar 10 min maximiza sus beneficios.',
        icon: Icons.healing,
        color: Colors.white,
        source: 'Journal of Antimicrobial Chemotherapy',
      ),
      FoodFact(
        title: 'Cebolla: Prebiótico natural',
        fact:
            'Las cebollas contienen inulina, un prebiótico que alimenta las bacterias buenas del intestino. También contienen quercetina, un antiinflamatorio natural.',
        icon: Icons.circle_outlined,
        color: Colors.purple,
        source: 'Gut Microbes Journal',
      ),
      FoodFact(
        title: 'Calabaza: Versatilidad nutritiva',
        fact:
            'Las semillas de calabaza (pepitas) contienen 19g de proteína por 100g y son ricas en zinc, esencial para el sistema inmune. Un snack perfecto.',
        icon: Icons.circle,
        color: Colors.orange,
        source: 'USDA',
      ),
      FoodFact(
        title: 'Chayote: El vegetal olvidado',
        fact:
            'El chayote es 95% agua, tiene solo 19 calorías por 100g y es rico en folato. Originario de México, su nombre viene del náhuatl "chayotli".',
        icon: Icons.grass,
        color: Colors.lightGreen,
        source: 'UNAM',
      ),
      FoodFact(
        title: 'Betabel: Rendimiento deportivo',
        fact:
            'El betabel es rico en nitratos que el cuerpo convierte en óxido nítrico, mejorando el flujo sanguíneo. Los atletas lo usan para mejorar rendimiento hasta un 3%.',
        icon: Icons.sports,
        color: Colors.purple,
        source: 'Journal of Applied Physiology',
      ),
      FoodFact(
        title: 'Apio: Calorías negativas',
        fact:
            'El apio tiene tan pocas calorías (6 kcal/tallo) que la energía para masticarlo y digerirlo es similar a lo que aporta. Es 95% agua y rico en vitamina K.',
        icon: Icons.grass,
        color: Colors.lightGreen,
        source: 'USDA',
      ),

      // ============ PROTEÍNAS ============
      FoodFact(
        title: 'Huevo: Proteína completa',
        fact:
            'El huevo es uno de los pocos alimentos que contiene todos los aminoácidos esenciales. La yema contiene colina, vital para el cerebro y la memoria.',
        icon: Icons.egg,
        color: Colors.amber,
        source: 'American Journal of Clinical Nutrition',
      ),
      FoodFact(
        title: 'Salmón: Omega-3 natural',
        fact:
            'El salmón es una de las mejores fuentes de ácidos grasos omega-3, que reducen la inflamación y apoyan la salud cardiovascular y cerebral.',
        icon: Icons.water,
        color: Colors.pink,
        source: 'American Heart Association',
      ),
      FoodFact(
        title: 'Frijoles: Proteína vegetal',
        fact:
            'Los frijoles negros contienen hasta 15g de proteína por taza y son ricos en antocianinas, los mismos antioxidantes de los arándanos.',
        icon: Icons.circle,
        color: Colors.brown,
        source: 'INSP México',
      ),
      FoodFact(
        title: 'Pollo: Proteína magra eficiente',
        fact:
            '100g de pechuga de pollo aportan 31g de proteína con solo 3g de grasa. Es la proteína favorita de los atletas por su relación proteína/grasa.',
        icon: Icons.restaurant,
        color: Colors.amber,
        source: 'USDA',
      ),
      FoodFact(
        title: 'Atún: Economía proteica',
        fact:
            'El atún en lata es una de las fuentes más económicas de proteína de alta calidad. 100g aportan 26g de proteína y solo 1g de grasa.',
        icon: Icons.waves,
        color: Colors.blue,
        source: 'FDA',
      ),
      FoodFact(
        title: 'Lentejas: Hierro vegetal',
        fact:
            'Las lentejas contienen más hierro que la carne de res por porción (6.6mg vs 2.6mg por 100g). Combínalas con vitamina C para mejor absorción.',
        icon: Icons.brightness_1,
        color: Colors.brown,
        source: 'USDA',
      ),
      FoodFact(
        title: 'Yogurt griego: Probióticos vivos',
        fact:
            'El yogurt griego tiene el doble de proteína que el regular (17g vs 8g por porción) y contiene probióticos que mejoran la salud digestiva.',
        icon: Icons.breakfast_dining,
        color: Colors.white,
        source: 'Journal of Dairy Science',
      ),

      // ============ CEREALES ============
      FoodFact(
        title: 'Avena: Fibra soluble',
        fact:
            'La avena contiene beta-glucano, una fibra soluble que puede reducir el colesterol LDL hasta en un 10% cuando se consumen 3g diarios.',
        icon: Icons.grain,
        color: Colors.brown,
        source: 'FDA (Health Claim)',
      ),
      FoodFact(
        title: 'Quinoa: El grano dorado',
        fact:
            'La quinoa es uno de los pocos granos que es una proteína completa con los 9 aminoácidos esenciales. Fue considerada sagrada por los Incas.',
        icon: Icons.grass,
        color: Colors.amber,
        source: 'FAO',
      ),
      FoodFact(
        title: 'Tortilla de maíz nixtamalizada',
        fact:
            'El proceso de nixtamalización aumenta la biodisponibilidad de niacina y calcio en el maíz, previniendo la pelagra. Una tortilla aporta 60mg de calcio.',
        icon: Icons.breakfast_dining,
        color: Colors.yellow,
        source: 'UNAM',
      ),
      FoodFact(
        title: 'Amaranto: Superfood ancestral',
        fact:
            'El amaranto tiene más proteína que el arroz y el maíz (16% vs 7%), fue sagrado para los aztecas y la NASA lo considera ideal para misiones espaciales.',
        icon: Icons.stars,
        color: Colors.purple,
        source: 'NASA/UNAM',
      ),
      FoodFact(
        title: 'Arroz integral: Fibra y magnesio',
        fact:
            'El arroz integral conserva la cáscara (salvado) que contiene fibra, magnesio y vitaminas B. El arroz blanco pierde el 67% de estos nutrientes.',
        icon: Icons.grass,
        color: Colors.brown,
        source: 'Whole Grains Council',
      ),

      // ============ ESPECIAS Y OTROS ============
      FoodFact(
        title: 'Chile: Capsaicina benéfica',
        fact:
            'La capsaicina del chile puede acelerar el metabolismo hasta un 8% y tiene propiedades analgésicas naturales. México tiene más de 60 variedades de chiles.',
        icon: Icons.local_fire_department,
        color: Colors.red,
        source: 'Journal of Nutritional Science',
      ),
      FoodFact(
        title: 'Canela: Regulador de glucosa',
        fact:
            'Medio gramo de canela al día puede mejorar la sensibilidad a la insulina. Los compuestos de la canela imitan la insulina a nivel celular.',
        icon: Icons.spa,
        color: Colors.brown,
        source: 'Diabetes Care Journal',
      ),
      FoodFact(
        title: 'Cúrcuma: Antiinflamatorio milenario',
        fact:
            'La curcumina de la cúrcuma es un potente antiinflamatorio. Combínala con pimienta negra (piperina) para aumentar su absorción en un 2000%.',
        icon: Icons.local_florist,
        color: Colors.orange,
        source: 'Journal of Medicinal Food',
      ),
      FoodFact(
        title: 'Jengibre: Alivio natural',
        fact:
            'El jengibre es tan efectivo como algunos medicamentos para las náuseas. También tiene propiedades antiinflamatorias comparables al ibuprofeno.',
        icon: Icons.healing,
        color: Colors.amber,
        source: 'Journal of Pain',
      ),
      FoodFact(
        title: 'Miel: Antibacteriano natural',
        fact:
            'La miel tiene propiedades antibacterianas naturales y nunca se echa a perder. Se ha encontrado miel comestible en tumbas egipcias de 3000 años.',
        icon: Icons.emoji_nature,
        color: Colors.amber,
        source: 'Journal of Food Science',
      ),
      FoodFact(
        title: 'Chocolate oscuro: Placer saludable',
        fact:
            'El chocolate con >70% cacao tiene más antioxidantes que el té verde. Los flavonoides del cacao mejoran el flujo sanguíneo cerebral y la memoria.',
        icon: Icons.favorite,
        color: Colors.brown,
        source: 'Frontiers in Nutrition',
      ),
      FoodFact(
        title: 'Chía: Omega-3 vegetal',
        fact:
            'La chía es la mayor fuente vegetal de omega-3 (más que el salmón por gramo). Absorbe 10 veces su peso en agua, excelente para hidratación prolongada.',
        icon: Icons.grain,
        color: Colors.grey,
        source: 'Journal of Food Science and Technology',
      ),
      FoodFact(
        title: 'Nuez de Castilla: Cerebro saludable',
        fact:
            'Las nueces de Castilla tienen la mayor cantidad de omega-3 entre los frutos secos. Su forma incluso parece un cerebro, órgano al que más benefician.',
        icon: Icons.psychology,
        color: Colors.brown,
        source: 'British Journal of Nutrition',
      ),
      FoodFact(
        title: 'Aceite de oliva: Oro líquido',
        fact:
            'El aceite de oliva extra virgen contiene oleocanthal, un antiinflamatorio con efectos similares al ibuprofeno. 3-4 cucharadas tienen el efecto de 200mg.',
        icon: Icons.water_drop,
        color: Colors.green,
        source: 'Nature',
      ),
      FoodFact(
        title: 'Café: Más que cafeína',
        fact:
            'El café es la mayor fuente de antioxidantes en la dieta occidental. Estudios muestran que 3-4 tazas al día reducen el riesgo de Parkinson y diabetes tipo 2.',
        icon: Icons.coffee,
        color: Colors.brown,
        source: 'New England Journal of Medicine',
      ),
    ];
  }

  /// Obtiene tips de nutrición
  static List<NutritionTip> getNutritionTips() {
    return const [
      NutritionTip(
        title: 'Desayuna en la primera hora',
        description:
            'Desayunar dentro de la primera hora de despertar activa tu metabolismo y mejora tu concentración durante el día.',
        category: 'Hábitos',
        icon: Icons.wb_sunny,
        color: Colors.orange,
      ),
      NutritionTip(
        title: 'Agua antes de cada comida',
        description:
            'Beber un vaso de agua 30 minutos antes de comer mejora la digestión y ayuda a controlar las porciones.',
        category: 'Hidratación',
        icon: Icons.water_drop,
        color: Colors.blue,
      ),
      NutritionTip(
        title: 'Colorea tu plato',
        description:
            'Entre más colores naturales tenga tu plato, más variedad de nutrientes estás consumiendo.',
        category: 'Variedad',
        icon: Icons.palette,
        color: Colors.purple,
      ),
      NutritionTip(
        title: 'Proteína en cada comida',
        description:
            'Incluir proteína te mantiene satisfecho por más tiempo y ayuda a mantener la masa muscular.',
        category: 'Macronutrientes',
        icon: Icons.fitness_center,
        color: Colors.red,
      ),
      NutritionTip(
        title: 'Cena ligero',
        description:
            'Cena al menos 2-3 horas antes de dormir y prefiere comidas ligeras para mejor digestión y sueño.',
        category: 'Horarios',
        icon: Icons.nights_stay,
        color: Colors.indigo,
      ),
      NutritionTip(
        title: 'Mastica bien',
        description:
            'Masticar cada bocado 20-30 veces mejora la digestión y te ayuda a comer menos al dar tiempo a las señales de saciedad.',
        category: 'Digestión',
        icon: Icons.restaurant,
        color: Colors.teal,
      ),
      NutritionTip(
        title: 'Snacks inteligentes',
        description:
            'Ten siempre a mano snacks saludables: frutas, nueces, verduras con hummus. Así evitas opciones poco saludables.',
        category: 'Planificación',
        icon: Icons.apple,
        color: Colors.green,
      ),
      NutritionTip(
        title: 'Lee las etiquetas',
        description:
            'Revisa los sellos de advertencia y la lista de ingredientes. Si el azúcar está entre los primeros 3, reconsidera.',
        category: 'Compras',
        icon: Icons.label,
        color: Colors.amber,
      ),
      NutritionTip(
        title: 'Cocina en casa',
        description:
            'Cocinar en casa te da control total sobre los ingredientes y las porciones. Además ahorras dinero.',
        category: 'Hábitos',
        icon: Icons.home,
        color: Colors.brown,
      ),
      NutritionTip(
        title: 'Fibra para todo',
        description:
            'La fibra mejora la digestión, controla el azúcar en sangre y te mantiene satisfecho. Objetivo: 25-30g diarios.',
        category: 'Nutrientes',
        icon: Icons.grass,
        color: Colors.lightGreen,
      ),
      NutritionTip(
        title: 'Limita los procesados',
        description:
            'Los alimentos ultraprocesados suelen tener exceso de sodio, azúcar y grasas. Opta por alimentos lo más naturales posible.',
        category: 'Calidad',
        icon: Icons.no_food,
        color: Colors.red,
      ),
      NutritionTip(
        title: 'Plato del bien comer',
        description:
            'Divide tu plato: 1/2 verduras, 1/4 proteína, 1/4 cereales. Así garantizas balance en cada comida.',
        category: 'Porciones',
        icon: Icons.pie_chart,
        color: Colors.cyan,
      ),
    ];
  }

  /// Obtiene alimentos recomendados basados en el perfil
  static List<FoodSuggestion> getRecommendedFoods({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 10,
  }) {
    final allFoods = getAllFoods();
    final suggestions = <FoodSuggestion>[];

    for (final food in allFoods) {
      double score = 50.0; // Base score
      final benefits = <String>[];
      var type = SuggestionType.recommended;

      // Evaluar por condiciones de salud
      for (final condition in conditions) {
        // Verificar si debe evitarse
        if (_matchesAny(food.name, condition.avoidFoods)) {
          score -= 50;
          type = SuggestionType.avoid;
        }

        // Verificar si debe limitarse
        if (_matchesAny(food.name, condition.limitFoods)) {
          score -= 25;
          type = SuggestionType.limitConsumption;
        }

        // Verificar si es recomendado
        if (_matchesAny(food.name, condition.recommendedFoods)) {
          score += 30;
          benefits.add('Recomendado para ${condition.name}');
        }
      }

      // Evaluar por objetivo nutricional
      final calorias = double.tryParse(food.energia) ?? 0;
      final proteinas = double.tryParse(food.proteina) ?? 0;
      final fibra = getFibraFromFood(food);

      switch (profile.nutritionGoal) {
        case NutritionGoal.loseWeight:
        case NutritionGoal.loseWeightFast:
          if (calorias < 80) {
            score += 15;
            benefits.add('Bajo en calorias');
          }
          if (fibra > 3) {
            score += 10;
            benefits.add('Alto en fibra');
          }
          break;

        case NutritionGoal.gainMuscle:
          if (proteinas > 10) {
            score += 20;
            benefits.add('Alto en proteinas');
          }
          break;

        case NutritionGoal.gainWeight:
          if (calorias > 150) {
            score += 15;
            benefits.add('Buena fuente de calorias');
          }
          break;

        case NutritionGoal.maintainWeight:
          // Balance general
          if (calorias >= 50 && calorias <= 150) {
            score += 10;
            benefits.add('Calorias balanceadas');
          }
          break;
      }

      // Bonus por categoria saludable
      if (food.category == 'verdura') {
        score += 10;
        benefits.add('Verdura nutritiva');
      } else if (food.category == 'fruta') {
        score += 8;
        benefits.add('Fruta natural');
      }

      // Verificar alergias
      if (_matchesAny(food.name, profile.allergies)) {
        score = 0;
        type = SuggestionType.avoid;
      }

      if (score > 0) {
        suggestions.add(FoodSuggestion(
          food: food,
          reason: _generateReason(food, profile, conditions),
          score: score.clamp(0, 100),
          benefits: benefits,
          type: type,
        ));
      }
    }

    // Ordenar por score y limitar
    suggestions.sort((a, b) => b.score.compareTo(a.score));
    return suggestions.take(limit).toList();
  }

  /// Obtiene alimentos a evitar
  static List<FoodSuggestion> getFoodsToAvoid({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 10,
  }) {
    final allFoods = getAllFoods();
    final suggestions = <FoodSuggestion>[];

    for (final food in allFoods) {
      final reasons = <String>[];

      // Verificar condiciones
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) {
          reasons.add('Evitar por ${condition.name}');
        }
      }

      // Verificar alergias
      if (_matchesAny(food.name, profile.allergies)) {
        reasons.add('Contiene alergeno');
      }

      if (reasons.isNotEmpty) {
        suggestions.add(FoodSuggestion(
          food: food,
          reason: reasons.join('. '),
          score: 0,
          benefits: [],
          type: SuggestionType.avoid,
        ));
      }
    }

    return suggestions.take(limit).toList();
  }

  /// Sugiere alternativas para un alimento
  static List<FoodSuggestion> suggestAlternatives({
    required Food originalFood,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    int limit = 5,
  }) {
    final allFoods = getAllFoods();
    final alternatives = <FoodSuggestion>[];

    // Buscar alimentos de la misma categoria
    final sameCategory =
        allFoods.where((f) => f.category == originalFood.category).toList();

    final originalCalories = double.tryParse(originalFood.energia) ?? 0;

    for (final food in sameCategory) {
      if (food.name == originalFood.name) continue;

      double score = 50;
      final benefits = <String>[];

      // Similar en calorias
      final calories = double.tryParse(food.energia) ?? 0;
      final calorieDiff = (calories - originalCalories).abs();
      if (calorieDiff < 30) {
        score += 20;
        benefits.add('Similar en calorias');
      }

      // Verificar que no este en la lista de evitar
      bool shouldAvoid = false;
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) {
          shouldAvoid = true;
          break;
        }
        if (_matchesAny(food.name, condition.recommendedFoods)) {
          score += 25;
          benefits.add('Recomendado para tu salud');
        }
      }

      if (!shouldAvoid && !_matchesAny(food.name, profile.allergies)) {
        alternatives.add(FoodSuggestion(
          food: food,
          reason: 'Alternativa a ${originalFood.name}',
          score: score,
          benefits: benefits,
          type: SuggestionType.alternative,
        ));
      }
    }

    alternatives.sort((a, b) => b.score.compareTo(a.score));
    return alternatives.take(limit).toList();
  }

  /// Genera un plan de comidas personalizado
  static DailyMealPlan generateMealPlan({
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required double targetCalories,
  }) {
    final allFoods = getAllFoods();

    // Distribucion de calorias por comida
    final breakfastCalories = targetCalories * 0.25;
    final lunchCalories = targetCalories * 0.35;
    final dinnerCalories = targetCalories * 0.25;
    final snackCalories = targetCalories * 0.15;

    return DailyMealPlan(
      date: DateTime.now(),
      breakfast: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: breakfastCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'breakfast',
      ),
      lunch: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: lunchCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'lunch',
      ),
      dinner: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: dinnerCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'dinner',
      ),
      snacks: _selectMealFoods(
        allFoods: allFoods,
        targetCalories: snackCalories,
        profile: profile,
        conditions: conditions,
        mealType: 'snack',
      ),
      totalCalories: targetCalories,
      macros: _calculateMacros(targetCalories, profile.nutritionGoal),
    );
  }

  static List<MealSuggestion> _selectMealFoods({
    required List<Food> allFoods,
    required double targetCalories,
    required UserProfile profile,
    required List<HealthCondition> conditions,
    required String mealType,
  }) {
    final suggestions = <MealSuggestion>[];
    double currentCalories = 0;

    // Filtrar alimentos seguros
    final safeFoods = allFoods.where((food) {
      for (final condition in conditions) {
        if (_matchesAny(food.name, condition.avoidFoods)) return false;
      }
      if (_matchesAny(food.name, profile.allergies)) return false;
      return true;
    }).toList();

    // Preferir ciertos tipos segun la comida
    List<String> preferredCategories;
    switch (mealType) {
      case 'breakfast':
        preferredCategories = ['fruta', 'cereal'];
        break;
      case 'lunch':
        preferredCategories = ['animal', 'verdura', 'leguminosa'];
        break;
      case 'dinner':
        preferredCategories = ['verdura', 'animal', 'leguminosa'];
        break;
      default:
        preferredCategories = ['fruta', 'verdura'];
    }

    // Seleccionar alimentos
    final shuffled = List<Food>.from(safeFoods)..shuffle();

    for (final food in shuffled) {
      if (currentCalories >= targetCalories) break;

      final calories = double.tryParse(food.energia) ?? 0;
      if (calories <= 0) continue;

      // Preferir categorias adecuadas
      if (!preferredCategories.contains(food.category)) continue;

      final portions = ((targetCalories - currentCalories) / calories)
          .clamp(0.5, 2.0)
          .toDouble();

      suggestions.add(MealSuggestion(
        food: food,
        portions: portions,
        preparationTip: _getPreparationTip(food, mealType),
        calories: calories * portions,
      ));

      currentCalories += calories * portions;

      if (suggestions.length >= 3) break;
    }

    return suggestions;
  }

  static String _getPreparationTip(Food food, String mealType) {
    final tips = {
      'fruta': [
        'Consumir fresca para mayor beneficio',
        'Combinar con yogurt natural',
        'Ideal como snack entre comidas',
      ],
      'verdura': [
        'Cocinar al vapor para conservar nutrientes',
        'Agregar un poco de aceite de oliva',
        'Combinar con proteina magra',
      ],
      'animal': [
        'Cocinar a la plancha o al horno',
        'Evitar freir para reducir grasas',
        'Acompanar con verduras frescas',
      ],
      'cereal': [
        'Preferir versiones integrales',
        'Combinar con frutas frescas',
        'Controlar el tamano de la porcion',
      ],
      'leguminosa': [
        'Remojar antes de cocinar',
        'Combinar con cereales para proteina completa',
        'Agregar hierbas para mejor digestion',
      ],
    };

    final categoryTips = tips[food.category] ?? ['Consumir con moderacion'];
    return categoryTips[DateTime.now().millisecond % categoryTips.length];
  }

  static Map<String, double> _calculateMacros(
      double calories, NutritionGoal goal) {
    double proteinPercent, carbPercent, fatPercent;

    switch (goal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        proteinPercent = 0.30;
        carbPercent = 0.40;
        fatPercent = 0.30;
        break;
      case NutritionGoal.gainMuscle:
        proteinPercent = 0.35;
        carbPercent = 0.40;
        fatPercent = 0.25;
        break;
      case NutritionGoal.gainWeight:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
        break;
      default:
        proteinPercent = 0.25;
        carbPercent = 0.50;
        fatPercent = 0.25;
    }

    return {
      'protein': (calories * proteinPercent) / 4,
      'carbs': (calories * carbPercent) / 4,
      'fat': (calories * fatPercent) / 9,
    };
  }

  static bool _matchesAny(String foodName, List<String> terms) {
    final normalizedFood = _normalize(foodName);
    for (final term in terms) {
      if (normalizedFood.contains(_normalize(term))) return true;
    }
    return false;
  }

  static String _normalize(String text) {
    return text
        .toLowerCase()
        .replaceAll('á', 'a')
        .replaceAll('é', 'e')
        .replaceAll('í', 'i')
        .replaceAll('ó', 'o')
        .replaceAll('ú', 'u')
        .replaceAll('ñ', 'n');
  }

  static String _generateReason(
    Food food,
    UserProfile profile,
    List<HealthCondition> conditions,
  ) {
    final reasons = <String>[];

    // Por categoria
    switch (food.category) {
      case 'fruta':
        reasons.add('Fuente natural de vitaminas y antioxidantes');
        break;
      case 'verdura':
        reasons.add('Rico en fibra y minerales esenciales');
        break;
      case 'animal':
        reasons.add('Excelente fuente de proteina de alta calidad');
        break;
      case 'cereal':
        reasons.add('Proporciona energia de liberacion lenta');
        break;
      case 'leguminosa':
        reasons.add('Proteina vegetal y fibra en abundancia');
        break;
    }

    // Por objetivo
    switch (profile.nutritionGoal) {
      case NutritionGoal.loseWeight:
      case NutritionGoal.loseWeightFast:
        final cal = double.tryParse(food.energia) ?? 0;
        if (cal < 80) reasons.add('Bajo aporte calorico');
        break;
      case NutritionGoal.gainMuscle:
        final prot = double.tryParse(food.proteina) ?? 0;
        if (prot > 10) reasons.add('Alto contenido proteico');
        break;
      default:
        break;
    }

    return reasons.isNotEmpty ? reasons.first : 'Alimento nutritivo';
  }

  /// Obtiene estadisticas de la base de datos de alimentos
  static Map<String, dynamic> getFoodDatabaseStats() {
    final allFoods = getAllFoods();

    int frutas = 0, verduras = 0, cereales = 0, animales = 0, leguminosas = 0;

    for (final food in allFoods) {
      switch (food.category) {
        case 'fruta':
          frutas++;
          break;
        case 'verdura':
          verduras++;
          break;
        case 'cereal':
          cereales++;
          break;
        case 'animal':
          animales++;
          break;
        case 'leguminosa':
          leguminosas++;
          break;
      }
    }

    return {
      'total': allFoods.length,
      'frutas': frutas,
      'verduras': verduras,
      'cereales': cereales,
      'animales': animales,
      'leguminosas': leguminosas,
    };
  }
}
