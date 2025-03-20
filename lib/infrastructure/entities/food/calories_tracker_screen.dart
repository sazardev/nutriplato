import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/infrastructure/entities/food/add_food_entry_screen.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class CaloriesTrackerScreen extends StatefulWidget {
  const CaloriesTrackerScreen({Key? key}) : super(key: key);

  @override
  State<CaloriesTrackerScreen> createState() => _CaloriesTrackerScreenState();
}

class _CaloriesTrackerScreenState extends State<CaloriesTrackerScreen> {
  DateTime _selectedDate = DateTime.now();

  // Meta diaria de calorías (en una app real esto sería configurable)
  final double _dailyCalorieGoal = 2000;

  @override
  void initState() {
    super.initState();
    // Cargar los registros cuando se inicie la pantalla
    Future.microtask(
        () => Provider.of<FoodLogProvider>(context, listen: false).loadLogs());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Seguimiento Nutricional'),
        centerTitle: true,
      ),
      body: Consumer<FoodLogProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          final dailyLog = provider.getDailyLog(_selectedDate);
          final totalCalories = dailyLog?.totalCalories ?? 0;
          final totalProtein = dailyLog?.totalProtein ?? 0;
          final totalCarbs = dailyLog?.totalCarbs ?? 0;
          final totalFat = dailyLog?.totalFat ?? 0;

          // Calcular el porcentaje de la meta diaria
          double progressPercentage = totalCalories / _dailyCalorieGoal;
          if (progressPercentage > 1) progressPercentage = 1;

          return Column(
            children: [
              _buildDateSelector(),
              _buildCalorieSummary(totalCalories, progressPercentage),
              _buildNutrientSummary(totalProtein, totalCarbs, totalFat),
              Expanded(
                child: _buildFoodLogList(dailyLog),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddFoodEntryScreen(selectedDate: _selectedDate),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
          ),
          TextButton(
            onPressed: () async {
              final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: _selectedDate,
                firstDate: DateTime(2020),
                lastDate: DateTime.now(),
              );
              if (picked != null && picked != _selectedDate) {
                setState(() {
                  _selectedDate = picked;
                });
              }
            },
            child: Text(
              DateFormat.yMMMd().format(_selectedDate),
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: _selectedDate.isBefore(DateTime.now())
                ? () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.add(const Duration(days: 1));
                    });
                  }
                : null,
          ),
        ],
      ),
    );
  }

  Widget _buildCalorieSummary(double totalCalories, double progressPercentage) {
    final Color progressColor = progressPercentage < 0.7
        ? Colors.green
        : (progressPercentage < 0.9 ? Colors.orange : Colors.red);

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          CircularPercentIndicator(
            radius: 80.0,
            lineWidth: 15.0,
            percent: progressPercentage,
            center: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${totalCalories.toStringAsFixed(0)}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Text(
                  'calorías',
                  style: TextStyle(
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            footer: Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${totalCalories.toStringAsFixed(0)} / $_dailyCalorieGoal kcal',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            progressColor: progressColor,
            backgroundColor: Colors.grey.shade200,
            animationDuration: 1000,
            animation: true,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientSummary(double protein, double carbs, double fat) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _buildNutrientItem(
            label: 'Proteínas',
            value: protein.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.dna,
            color: Colors.green,
          ),
          _buildNutrientItem(
            label: 'Carbos',
            value: carbs.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.breadSlice,
            color: Colors.amber,
          ),
          _buildNutrientItem(
            label: 'Grasas',
            value: fat.toStringAsFixed(1),
            unit: 'g',
            icon: FontAwesomeIcons.oilWell,
            color: Colors.orange,
          ),
        ],
      ),
    );
  }

  Widget _buildNutrientItem({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
  }) {
    return Column(
      children: [
        Icon(icon, color: color),
        const SizedBox(height: 8),
        Text(
          '$value $unit',
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }

  Widget _buildFoodLogList(DailyFoodLog? dailyLog) {
    if (dailyLog == null || dailyLog.entries.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.utensils,
              size: 48,
              color: Colors.grey.shade400,
            ),
            const SizedBox(height: 16),
            Text(
              'No hay alimentos registrados para esta fecha',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddFoodEntryScreen(
                      selectedDate: _selectedDate,
                    ),
                  ),
                );
              },
              child: const Text('Agregar alimento'),
            ),
          ],
        ),
      );
    }

    // Agrupar entradas por tipo de comida
    Map<String, List<FoodLogEntry>> mealGroups = {};
    for (var entry in dailyLog.entries) {
      if (!mealGroups.containsKey(entry.mealType)) {
        mealGroups[entry.mealType] = [];
      }
      mealGroups[entry.mealType]!.add(entry);
    }

    // Ordenar tipos de comida en orden específico
    final mealOrder = ['Desayuno', 'Almuerzo', 'Cena', 'Snack'];
    List<String> sortedMealTypes = mealGroups.keys.toList()
      ..sort((a, b) {
        int aIndex = mealOrder.indexOf(a);
        int bIndex = mealOrder.indexOf(b);
        if (aIndex == -1) aIndex = 999;
        if (bIndex == -1) bIndex = 999;
        return aIndex.compareTo(bIndex);
      });

    return ListView.builder(
      itemCount: sortedMealTypes.length,
      itemBuilder: (context, index) {
        final mealType = sortedMealTypes[index];
        final entries = mealGroups[mealType]!;

        return _buildMealSection(mealType, entries);
      },
    );
  }

  Widget _buildMealSection(String mealType, List<FoodLogEntry> entries) {
    // Calcular calorías totales para esta comida
    double totalMealCalories =
        entries.fold(0, (sum, entry) => sum + entry.calories);

    return ExpansionTile(
      initiallyExpanded: true,
      title: Row(
        children: [
          _getMealIcon(mealType),
          const SizedBox(width: 8),
          Expanded(child: Text(mealType)),
          Text(
            '${totalMealCalories.toStringAsFixed(0)} kcal',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
      children: entries.asMap().entries.map((mapEntry) {
        final int entryIndex = mapEntry.key;
        final FoodLogEntry entry = mapEntry.value;

        return ListTile(
          title: Text(entry.food.name),
          subtitle: Text(
              '${entry.quantity} ${entry.food.unidad} · ${entry.calories.toStringAsFixed(0)} kcal'),
          trailing: IconButton(
            icon: const Icon(Icons.delete_outline, color: Colors.red),
            onPressed: () {
              _showDeleteConfirmation(entry, entryIndex);
            },
          ),
        );
      }).toList(),
    );
  }

  Widget _getMealIcon(String mealType) {
    switch (mealType) {
      case 'Desayuno':
        return const Icon(FontAwesomeIcons.mugSaucer, color: Colors.orange);
      case 'Almuerzo':
        return const Icon(FontAwesomeIcons.bowlFood, color: Colors.green);
      case 'Cena':
        return const Icon(FontAwesomeIcons.utensils, color: Colors.purple);
      case 'Snack':
        return const Icon(FontAwesomeIcons.apple, color: Colors.red);
      default:
        return const Icon(FontAwesomeIcons.solidCircle);
    }
  }

  void _showDeleteConfirmation(FoodLogEntry entry, int entryIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Eliminar alimento'),
        content: Text('¿Deseas eliminar ${entry.food.name} de tu registro?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          TextButton(
            onPressed: () {
              Provider.of<FoodLogProvider>(context, listen: false)
                  .removeFoodEntry(_selectedDate, entryIndex);
              Navigator.pop(context);
            },
            child: const Text('Eliminar'),
            style: TextButton.styleFrom(foregroundColor: Colors.red),
          ),
        ],
      ),
    );
  }
}
