import 'package:flutter/material.dart';

import 'smart_nutrition_models.dart';

/// Tips de nutrición.
List<NutritionTip> buildNutritionTips() {
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
