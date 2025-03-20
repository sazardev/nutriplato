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

class _CaloriesTrackerScreenState extends State<CaloriesTrackerScreen>
    with SingleTickerProviderStateMixin {
  DateTime _selectedDate = DateTime.now();
  late TabController _tabController;
  final double _dailyCalorieGoal = 2000;
  final List<String> _mealTypes = ['Desayuno', 'Almuerzo', 'Cena', 'Snack'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _mealTypes.length, vsync: this);
    Future.microtask(
        () => Provider.of<FoodLogProvider>(context, listen: false).loadLogs());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;

    return Scaffold(
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

          double progressPercentage = totalCalories / _dailyCalorieGoal;
          if (progressPercentage > 1) progressPercentage = 1;

          // Organizar los registros por tipo de comida
          Map<String, List<FoodLogEntry>> mealGroups = {};
          if (dailyLog != null) {
            for (var entry in dailyLog.entries) {
              if (!mealGroups.containsKey(entry.mealType)) {
                mealGroups[entry.mealType] = [];
              }
              mealGroups[entry.mealType]!.add(entry);
            }
          }

          return CustomScrollView(
            slivers: [
              _buildSliverAppBar(primaryColor),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    _buildDateSelector(),
                    _buildNutritionCard(totalCalories, progressPercentage,
                        totalProtein, totalCarbs, totalFat),
                  ],
                ),
              ),
              SliverPersistentHeader(
                delegate: _SliverAppBarDelegate(
                  TabBar(
                    controller: _tabController,
                    isScrollable: true,
                    labelColor: primaryColor,
                    unselectedLabelColor: Colors.grey,
                    indicatorColor: primaryColor,
                    tabs: _mealTypes
                        .map((type) => Tab(
                              icon: _getMealIcon(type),
                              text: type,
                            ))
                        .toList(),
                  ),
                ),
                pinned: true,
              ),
              SliverFillRemaining(
                hasScrollBody: true,
                child: TabBarView(
                  controller: _tabController,
                  children: _mealTypes.map((mealType) {
                    final entries = mealGroups[mealType] ?? [];
                    return _buildMealContent(mealType, entries);
                  }).toList(),
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) =>
                  AddFoodEntryScreen(selectedDate: _selectedDate),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Añadir alimento'),
        elevation: 4,
      ),
    );
  }

  Widget _buildSliverAppBar(Color primaryColor) {
    return SliverAppBar(
      expandedHeight: 100.0,
      stretch: true,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding:
            const EdgeInsets.only(left: 16.0, bottom: 16.0, right: 16.0),
        title: const Row(
          children: [
            Icon(FontAwesomeIcons.chartPie, size: 20),
            SizedBox(width: 8),
            Text(
              'Mi Nutrición Diaria',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateSelector() {
    return Container(
      margin: const EdgeInsets.only(top: 16, bottom: 8, left: 16, right: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            spreadRadius: 1,
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back_ios, size: 18),
            onPressed: () {
              setState(() {
                _selectedDate = _selectedDate.subtract(const Duration(days: 1));
              });
            },
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
          ),
          Expanded(
            child: InkWell(
              onTap: () async {
                final DateTime? picked = await showDatePicker(
                  context: context,
                  initialDate: _selectedDate,
                  firstDate: DateTime(2020),
                  lastDate: DateTime.now(),
                  builder: (context, child) {
                    return Theme(
                      data: Theme.of(context).copyWith(
                        colorScheme: ColorScheme.light(
                          primary: Theme.of(context).colorScheme.primary,
                        ),
                      ),
                      child: child!,
                    );
                  },
                );
                if (picked != null && picked != _selectedDate) {
                  setState(() {
                    _selectedDate = picked;
                  });
                }
              },
              child: Column(
                children: [
                  Text(
                    DateFormat.EEEE().format(_selectedDate),
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        DateFormat.yMMMd().format(_selectedDate),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(width: 4),
                      const Icon(Icons.calendar_month, size: 16),
                    ],
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.arrow_forward_ios, size: 18),
            onPressed: _selectedDate.isBefore(DateTime.now())
                ? () {
                    setState(() {
                      _selectedDate =
                          _selectedDate.add(const Duration(days: 1));
                    });
                  }
                : null,
            color: _selectedDate.isBefore(DateTime.now())
                ? null
                : Colors.grey.shade300,
            constraints: const BoxConstraints(minWidth: 40, minHeight: 40),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
    );
  }

  Widget _buildNutritionCard(double totalCalories, double progressPercentage,
      double protein, double carbs, double fat) {
    final Color progressColor = _getProgressColor(progressPercentage);

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 8, 16, 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 2,
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                _buildCalorieHeaderRow(
                    totalCalories, progressPercentage, progressColor),
                const SizedBox(height: 4),
                Text(
                  'Meta diaria: $_dailyCalorieGoal kcal',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey.shade600,
                  ),
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                _buildDetailedNutrients(protein, carbs, fat),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget separado para la fila de calorías para mejor organización
  Widget _buildCalorieHeaderRow(
      double totalCalories, double progressPercentage, Color progressColor) {
    return LayoutBuilder(builder: (context, constraints) {
      // Determinar si estamos en un dispositivo pequeño
      final isSmallDevice = constraints.maxWidth < 300;

      if (isSmallDevice) {
        // Layout vertical para dispositivos pequeños
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _buildCalorieInfo(totalCalories),
            const SizedBox(height: 16),
            _buildProgressCircle(progressPercentage, progressColor),
          ],
        );
      } else {
        // Layout horizontal para dispositivos normales
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildCalorieInfo(totalCalories),
            _buildProgressCircle(progressPercentage, progressColor),
          ],
        );
      }
    });
  }

  // Widget para la información de calorías
  Widget _buildCalorieInfo(double totalCalories) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Calorías consumidas',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${totalCalories.toInt()}',
              style: const TextStyle(
                fontSize: 36,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(width: 4),
            Padding(
              padding: const EdgeInsets.only(bottom: 6),
              child: Text(
                'kcal',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey.shade600,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  // Widget para el círculo de progreso
  Widget _buildProgressCircle(double progressPercentage, Color progressColor) {
    return CircularPercentIndicator(
      radius: 40,
      lineWidth: 8,
      percent: progressPercentage,
      center: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '${(progressPercentage * 100).toInt()}%',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          Text(
            'Meta',
            style: TextStyle(
              fontSize: 10,
              color: Colors.grey.shade600,
            ),
          ),
        ],
      ),
      progressColor: progressColor,
      backgroundColor: Colors.grey.shade200,
      circularStrokeCap: CircularStrokeCap.round,
      animation: true,
      animationDuration: 1200,
    );
  }

  Widget _buildDetailedNutrients(double protein, double carbs, double fat) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Macronutrientes',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        LayoutBuilder(builder: (context, constraints) {
          // Determinar si estamos en un dispositivo pequeño
          final isSmallDevice = constraints.maxWidth < 300;

          if (isSmallDevice) {
            // Layout vertical para dispositivos pequeños
            return Column(
              children: [
                _buildNutrientColumn(
                  label: 'Proteínas',
                  value: protein.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.dna,
                  color: Colors.green,
                  percentage: protein / (protein + carbs + fat),
                  isSmallDevice: true,
                ),
                const SizedBox(height: 16),
                _buildNutrientColumn(
                  label: 'Carbohidratos',
                  value: carbs.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.breadSlice,
                  color: Colors.amber.shade700,
                  percentage: carbs / (protein + carbs + fat),
                  isSmallDevice: true,
                ),
                const SizedBox(height: 16),
                _buildNutrientColumn(
                  label: 'Grasas',
                  value: fat.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.oilWell,
                  color: Colors.orange.shade700,
                  percentage: fat / (protein + carbs + fat),
                  isSmallDevice: true,
                ),
              ],
            );
          } else {
            // Layout horizontal para dispositivos normales
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildNutrientColumn(
                  label: 'Proteínas',
                  value: protein.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.dna,
                  color: Colors.green,
                  percentage: protein / (protein + carbs + fat),
                  isSmallDevice: false,
                ),
                _buildNutrientColumn(
                  label: 'Carbohidratos',
                  value: carbs.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.breadSlice,
                  color: Colors.amber.shade700,
                  percentage: carbs / (protein + carbs + fat),
                  isSmallDevice: false,
                ),
                _buildNutrientColumn(
                  label: 'Grasas',
                  value: fat.toStringAsFixed(1),
                  unit: 'g',
                  icon: FontAwesomeIcons.oilWell,
                  color: Colors.orange.shade700,
                  percentage: fat / (protein + carbs + fat),
                  isSmallDevice: false,
                ),
              ],
            );
          }
        }),
      ],
    );
  }

  Widget _buildNutrientColumn({
    required String label,
    required String value,
    required String unit,
    required IconData icon,
    required Color color,
    required double percentage,
    required bool isSmallDevice,
  }) {
    // If total is 0, prevent division by zero by setting percentage to 0
    if (percentage.isNaN) percentage = 0;

    final content = Column(
      children: [
        Stack(
          alignment: Alignment.center,
          children: [
            CircularPercentIndicator(
              radius: 25,
              lineWidth: 4,
              percent: percentage,
              progressColor: color,
              backgroundColor: Colors.grey.shade200,
              circularStrokeCap: CircularStrokeCap.round,
            ),
            Icon(icon, color: color, size: 14),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          '$value $unit',
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: Colors.grey.shade600,
          ),
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 4),
        Text(
          '${(percentage * 100).toInt()}%',
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
      ],
    );

    if (isSmallDevice) {
      return content;
    } else {
      return Expanded(child: content);
    }
  }

  Widget _buildMealContent(String mealType, List<FoodLogEntry> entries) {
    if (entries.isEmpty) {
      return _buildEmptyMealView(mealType);
    }

    // Calcular calorías totales para esta comida
    double totalMealCalories =
        entries.fold(0, (sum, entry) => sum + entry.calories);

    return SafeArea(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '$mealType Total:',
                  style: const TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getMealColor(mealType).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    '${totalMealCalories.toInt()} kcal',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: _getMealColor(mealType),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Usar Expanded con ListView.builder para evitar desbordamientos
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.only(
                  bottom: 80), // Para evitar que el FAB tape el contenido
              itemCount: entries.length,
              itemBuilder: (context, index) {
                final entry = entries[index];
                return _buildFoodEntryCard(entry, index);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFoodEntryCard(FoodLogEntry entry, int index) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: LayoutBuilder(
          builder: (context, constraints) {
            // Layout adaptable según el ancho disponible
            final isNarrow = constraints.maxWidth < 350;

            if (isNarrow) {
              // Layout vertical para dispositivos estrechos
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Fila superior: icono y nombre
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: entry.food.color.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: entry.food.icon,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              entry.food.name,
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 15,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                            Text(
                              '${entry.quantity} ${entry.food.unidad}',
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Fila inferior: nutrientes y botón borrar
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            _buildMacroChip(
                              '${entry.calories.toInt()} kcal',
                              Colors.grey.shade100,
                              Colors.black87,
                              isBold: true,
                            ),
                            const SizedBox(width: 4),
                            _buildMacroChip(
                              'P: ${entry.protein.toStringAsFixed(1)}g',
                              Colors.green.shade50,
                              Colors.green,
                            ),
                            const SizedBox(width: 4),
                            _buildMacroChip(
                              'C: ${entry.carbs.toStringAsFixed(1)}g',
                              Colors.amber.shade50,
                              Colors.amber.shade800,
                            ),
                            const SizedBox(width: 4),
                            _buildMacroChip(
                              'G: ${entry.fat.toStringAsFixed(1)}g',
                              Colors.orange.shade50,
                              Colors.orange.shade800,
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: Icon(Icons.delete_outline,
                            color: Colors.red.shade400, size: 20),
                        onPressed: () => _showDeleteConfirmation(entry, index),
                        constraints:
                            const BoxConstraints(minHeight: 36, minWidth: 36),
                        padding: EdgeInsets.zero,
                      ),
                    ],
                  ),
                ],
              );
            } else {
              // Layout horizontal para dispositivos normales
              return Row(
                children: [
                  Container(
                    width: 50,
                    height: 50,
                    decoration: BoxDecoration(
                      color: entry.food.color.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    child: Center(
                      child: entry.food.icon,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          entry.food.name,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          '${entry.quantity} ${entry.food.unidad}',
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.grey.shade600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        '${entry.calories.toInt()} kcal',
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          _buildMacroChip(
                            'P: ${entry.protein.toStringAsFixed(1)}g',
                            Colors.green.shade50,
                            Colors.green,
                          ),
                          const SizedBox(width: 4),
                          _buildMacroChip(
                            'C: ${entry.carbs.toStringAsFixed(1)}g',
                            Colors.amber.shade50,
                            Colors.amber.shade800,
                          ),
                          const SizedBox(width: 4),
                          _buildMacroChip(
                            'G: ${entry.fat.toStringAsFixed(1)}g',
                            Colors.orange.shade50,
                            Colors.orange.shade800,
                          ),
                        ],
                      )
                    ],
                  ),
                  IconButton(
                    icon: Icon(Icons.delete_outline,
                        color: Colors.red.shade400, size: 20),
                    onPressed: () => _showDeleteConfirmation(entry, index),
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }

  Widget _buildMacroChip(String text, Color bgColor, Color textColor,
      {bool isBold = false}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        text,
        style: TextStyle(
          fontSize: 9,
          fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
          color: textColor,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }

  Widget _buildEmptyMealView(String mealType) {
    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: _getMealColor(mealType).withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                _getMealIconData(mealType),
                color: _getMealColor(mealType),
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'No hay alimentos en $mealType',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.grey.shade600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            OutlinedButton.icon(
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
              icon: const Icon(Icons.add, size: 16),
              label: Text(
                'Añadir a $mealType',
                textAlign: TextAlign.center,
              ),
              style: OutlinedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _getMealIcon(String mealType) {
    return Icon(
      _getMealIconData(mealType),
      color: _getMealColor(mealType),
      size: 20,
    );
  }

  IconData _getMealIconData(String mealType) {
    switch (mealType) {
      case 'Desayuno':
        return FontAwesomeIcons.mugSaucer;
      case 'Almuerzo':
        return FontAwesomeIcons.bowlFood;
      case 'Cena':
        return FontAwesomeIcons.utensils;
      case 'Snack':
        return FontAwesomeIcons.apple;
      default:
        return FontAwesomeIcons.solidCircle;
    }
  }

  Color _getMealColor(String mealType) {
    switch (mealType) {
      case 'Desayuno':
        return Colors.orange.shade600;
      case 'Almuerzo':
        return Colors.green.shade600;
      case 'Cena':
        return Colors.purple.shade600;
      case 'Snack':
        return Colors.red.shade600;
      default:
        return Colors.grey;
    }
  }

  Color _getProgressColor(double percentage) {
    if (percentage < 0.5) return Colors.green.shade400;
    if (percentage < 0.75) return Colors.green.shade600;
    if (percentage < 0.9) return Colors.orange.shade600;
    return Colors.red.shade500;
  }

  void _showDeleteConfirmation(FoodLogEntry entry, int entryIndex) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Row(
          children: [
            Icon(Icons.delete_outline, color: Colors.red.shade400),
            const SizedBox(width: 8),
            const Flexible(
              child: Text(
                'Eliminar alimento',
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        content: Text(
          '¿Deseas eliminar ${entry.food.name} de tu registro?',
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              Provider.of<FoodLogProvider>(context, listen: false)
                  .removeFoodEntry(_selectedDate, entryIndex);
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade400,
              foregroundColor: Colors.white,
            ),
            child: const Text('Eliminar'),
          ),
        ],
      ),
    );
  }
}

class _SliverAppBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar _tabBar;

  _SliverAppBarDelegate(this._tabBar);

  @override
  double get minExtent => _tabBar.preferredSize.height;
  @override
  double get maxExtent => _tabBar.preferredSize.height;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      child: _tabBar,
    );
  }

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}
