import 'package:flutter/material.dart';
import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../presentation/screens/food/food.view.dart';
import '../data/data.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<StatefulWidget> createState() => _SearchScreen();
}

class _SearchScreen extends State<SearchScreen> {
  late List<Food> allFoods;
  late List<Food> filteredFoods;
  final TextEditingController searchController = TextEditingController();
  List<Food> recentFoods = [];
  bool showList = false;

  String _currentSortingMethod = "Alfabético (A-Z)";
  RangeValues _caloriesRange = const RangeValues(0, 1000);
  RangeValues _proteinRange = const RangeValues(0, 100);
  bool _showFilterPanel = false;
  String _activeView = "Todos";

  final List<String> _sortingMethods = [
    "Alfabético (A-Z)",
    "Alfabético (Z-A)",
    "Calorías (menor a mayor)",
    "Calorías (mayor a menor)",
    "Proteínas (menor a mayor)",
    "Proteínas (mayor a menor)",
    "Recientes primero"
  ];

  final Map<String, IconData> _foodCategories = {
    "Todos": Icons.all_inclusive,
    "Cereales": FontAwesomeIcons.wheatAwn,
    "Leguminosas": FontAwesomeIcons.seedling,
    "Animal": FontAwesomeIcons.cow,
    "Verduras": FontAwesomeIcons.carrot,
    "Frutas": FontAwesomeIcons.appleWhole,
    "Recientes": Icons.history,
  };

  @override
  void initState() {
    super.initState();
    allFoods = [];
    allFoods.addAll(animals);
    allFoods.addAll(verduras);
    allFoods.addAll(frutas);
    allFoods.addAll(leguminosas);
    allFoods.addAll(cereales);

    _updateRanges();
    loadRecentFoods();

    filteredFoods = List.from(allFoods);
    _applySorting();
  }

  void _updateRanges() {
    double maxCalories = 0;
    double maxProtein = 0;

    for (var food in allFoods) {
      double calories = double.tryParse(food.energia) ?? 0;
      double protein = double.tryParse(food.proteina) ?? 0;

      if (calories > maxCalories) maxCalories = calories;
      if (protein > maxProtein) maxProtein = protein;
    }

    maxCalories = (maxCalories / 100).ceil() * 100;
    maxProtein = (maxProtein / 10).ceil() * 10;

    setState(() {
      _caloriesRange = RangeValues(0, maxCalories);
      _proteinRange = RangeValues(0, maxProtein);
    });
  }

  Future<void> saveRecentFoods() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> foodNames = recentFoods.map((food) => food.name).toList();
    await prefs.setStringList('recentFoods', foodNames);
  }

  Future<void> loadRecentFoods() async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? foodNames = prefs.getStringList('recentFoods');
    if (foodNames != null) {
      recentFoods = [];
      for (var name in foodNames) {
        try {
          var found = allFoods.firstWhere((food) => food.name == name);
          recentFoods.add(found);
        } catch (e) {
          // Ignorar nombres que ya no existen
        }
      }
    }
  }

  void addToRecentFoods(Food food) {
    recentFoods.removeWhere((item) => item.name == food.name);
    recentFoods.insert(0, food);

    if (recentFoods.length > 10) {
      recentFoods = recentFoods.sublist(0, 10);
    }

    saveRecentFoods();
  }

  void _applyFilters() {
    setState(() {
      filteredFoods = List.from(allFoods);

      if (_activeView != "Todos" && _activeView != "Recientes") {
        filteredFoods = filteredFoods.where((food) {
          switch (_activeView) {
            case "Cereales":
              return food.category == 'cereal';
            case "Leguminosas":
              return food.category == 'leguminosa';
            case "Animal":
              return food.category == 'animal';
            case "Verduras":
              return food.category == 'verdura';
            case "Frutas":
              return food.category == 'fruta';
            default:
              return true;
          }
        }).toList();
      } else if (_activeView == "Recientes") {
        filteredFoods = List.from(recentFoods);
      }

      if (searchController.text.isNotEmpty) {
        String query = searchController.text.toLowerCase();
        filteredFoods = filteredFoods
            .where((food) => food.name.toLowerCase().contains(query))
            .toList();
      }

      filteredFoods = filteredFoods.where((food) {
        double calories = double.tryParse(food.energia) ?? 0;
        return calories >= _caloriesRange.start &&
            calories <= _caloriesRange.end;
      }).toList();

      filteredFoods = filteredFoods.where((food) {
        double protein = double.tryParse(food.proteina) ?? 0;
        return protein >= _proteinRange.start && protein <= _proteinRange.end;
      }).toList();

      _applySorting();
    });
  }

  void _applySorting() {
    switch (_currentSortingMethod) {
      case "Alfabético (A-Z)":
        filteredFoods.sort((a, b) => a.name.compareTo(b.name));
        break;
      case "Alfabético (Z-A)":
        filteredFoods.sort((a, b) => b.name.compareTo(a.name));
        break;
      case "Calorías (menor a mayor)":
        filteredFoods.sort((a, b) => (double.tryParse(a.energia) ?? 0)
            .compareTo(double.tryParse(b.energia) ?? 0));
        break;
      case "Calorías (mayor a menor)":
        filteredFoods.sort((a, b) => (double.tryParse(b.energia) ?? 0)
            .compareTo(double.tryParse(a.energia) ?? 0));
        break;
      case "Proteínas (menor a mayor)":
        filteredFoods.sort((a, b) => (double.tryParse(a.proteina) ?? 0)
            .compareTo(double.tryParse(b.proteina) ?? 0));
        break;
      case "Proteínas (mayor a menor)":
        filteredFoods.sort((a, b) => (double.tryParse(b.proteina) ?? 0)
            .compareTo(double.tryParse(a.proteina) ?? 0));
        break;
      case "Recientes primero":
        filteredFoods.sort((a, b) {
          int aIndex = recentFoods.indexWhere((food) => food.name == a.name);
          int bIndex = recentFoods.indexWhere((food) => food.name == b.name);
          if (aIndex == -1) aIndex = 999;
          if (bIndex == -1) bIndex = 999;
          return aIndex - bIndex;
        });
        break;
    }
  }

  bool _hasActiveFilters() {
    return _caloriesRange.start > 0 ||
        _caloriesRange.end < 1000 ||
        _proteinRange.start > 0 ||
        _proteinRange.end < 100;
  }

  String _getSortMethodShortName() {
    switch (_currentSortingMethod) {
      case "Alfabético (A-Z)":
        return "A→Z";
      case "Alfabético (Z-A)":
        return "Z→A";
      case "Calorías (menor a mayor)":
        return "Cal ↑";
      case "Calorías (mayor a menor)":
        return "Cal ↓";
      case "Proteínas (menor a mayor)":
        return "Prot ↑";
      case "Proteínas (mayor a menor)":
        return "Prot ↓";
      case "Recientes primero":
        return "Recientes";
      default:
        return _currentSortingMethod;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header con gradiente unificado
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: AppGradients.primary,
              ),
              child: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  'Buscador de Alimentos',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.primary,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(Icons.restaurant_menu,
                              color: Colors.white.withValues(alpha: .3),
                              size: 80),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.sort, color: Colors.white),
                onPressed: () => _showSortingDialog(),
              ),
              IconButton(
                icon: Icon(
                  _showFilterPanel ? Icons.filter_list_off : Icons.filter_list,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _showFilterPanel = !_showFilterPanel;
                  });
                },
              ),
            ],
          ),

          // Contenido principal
          SliverToBoxAdapter(
            child: Column(
              children: [
                // Barra de búsqueda
                Padding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  child: Container(
                    decoration: BoxDecoration(
                      color: AppColors.surface,
                      borderRadius: BorderRadius.circular(AppRadius.lg),
                      boxShadow: [AppShadows.subtle],
                    ),
                    child: TextField(
                      controller: searchController,
                      style: AppTypography.bodyMedium,
                      decoration: InputDecoration(
                        hintText: 'Buscar alimentos...',
                        hintStyle: AppTypography.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                        prefixIcon:
                            Icon(Icons.search, color: AppColors.textSecondary),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(Icons.clear,
                                    color: AppColors.textSecondary),
                                onPressed: () {
                                  searchController.clear();
                                  _applyFilters();
                                },
                              )
                            : null,
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.md,
                        ),
                      ),
                      onChanged: (value) {
                        _applyFilters();
                      },
                    ),
                  ),
                ),

                // Chips de categorías
                SizedBox(
                  height: 50,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    padding:
                        const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                    children: _foodCategories.entries.map((entry) {
                      bool isActive = _activeView == entry.key;
                      return Padding(
                        padding: const EdgeInsets.only(right: AppSpacing.sm),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _activeView = entry.key;
                              _applyFilters();
                            });
                          },
                          borderRadius: BorderRadius.circular(AppRadius.full),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: AppSpacing.md,
                              vertical: AppSpacing.sm,
                            ),
                            decoration: BoxDecoration(
                              gradient: isActive ? AppGradients.primary : null,
                              color: isActive ? null : AppColors.surface,
                              borderRadius:
                                  BorderRadius.circular(AppRadius.full),
                              boxShadow: [AppShadows.subtle],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  entry.value,
                                  color: isActive
                                      ? Colors.white
                                      : AppColors.textSecondary,
                                  size: 16,
                                ),
                                const SizedBox(width: AppSpacing.xs),
                                Text(
                                  entry.key,
                                  style: AppTypography.labelLarge.copyWith(
                                    color: isActive
                                        ? Colors.white
                                        : AppColors.textSecondary,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // Barra de filtros activos
                if (_hasActiveFilters()) _buildActiveFiltersBar(),

                // Panel de filtros
                if (_showFilterPanel) _buildFilterPanel(),

                // Contador de resultados y ordenamiento
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.md,
                          vertical: AppSpacing.xs,
                        ),
                        decoration: BoxDecoration(
                          color: Theme.of(context)
                              .primaryColor
                              .withValues(alpha: .1),
                          borderRadius: BorderRadius.circular(AppRadius.full),
                        ),
                        child: Row(
                          children: [
                            Icon(
                              Icons.list_alt,
                              size: 16,
                              color: Theme.of(context).primaryColor,
                            ),
                            const SizedBox(width: AppSpacing.xs),
                            Text(
                              '${filteredFoods.length} resultados',
                              style: AppTypography.labelLarge.copyWith(
                                color: Theme.of(context).primaryColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Spacer(),
                      InkWell(
                        onTap: () => _showSortingDialog(),
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.xs,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            boxShadow: [AppShadows.subtle],
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.sort,
                                size: 16,
                                color: AppColors.textSecondary,
                              ),
                              const SizedBox(width: AppSpacing.xs),
                              Text(
                                _getSortMethodShortName(),
                                style: AppTypography.labelSmall.copyWith(
                                  color: AppColors.textSecondary,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          // Grid de alimentos
          filteredFoods.isEmpty
              ? SliverFillRemaining(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: AppColors.textSecondary.withValues(alpha: .5),
                        ),
                        const SizedBox(height: AppSpacing.md),
                        Text(
                          'No se encontraron alimentos',
                          style: AppTypography.bodyLarge.copyWith(
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : SliverPadding(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  sliver: SliverGrid(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: AppSpacing.sm,
                      mainAxisSpacing: AppSpacing.sm,
                    ),
                    delegate: SliverChildBuilderDelegate(
                      (context, index) => _buildFoodCard(filteredFoods[index]),
                      childCount: filteredFoods.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersBar() {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      margin: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.md),
        boxShadow: [AppShadows.subtle],
      ),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            if (_caloriesRange.start > 0 || _caloriesRange.end < 1000)
              _buildFilterChip(
                label:
                    'Calorías: ${_caloriesRange.start.round()}-${_caloriesRange.end.round()} kcal',
                icon: Icons.local_fire_department,
                color: Colors.orange,
                onTap: () {
                  setState(() {
                    _caloriesRange = const RangeValues(0, 1000);
                    _applyFilters();
                  });
                },
              ),
            const SizedBox(width: AppSpacing.sm),
            if (_proteinRange.start > 0 || _proteinRange.end < 100)
              _buildFilterChip(
                label:
                    'Proteínas: ${_proteinRange.start.round()}-${_proteinRange.end.round()} g',
                icon: FontAwesomeIcons.dna,
                color: Colors.green,
                onTap: () {
                  setState(() {
                    _proteinRange = const RangeValues(0, 100);
                    _applyFilters();
                  });
                },
              ),
            const SizedBox(width: AppSpacing.sm),
            if (_hasActiveFilters())
              _buildFilterChip(
                label: 'Limpiar todos',
                icon: Icons.clear_all,
                color: AppColors.error,
                onTap: () {
                  setState(() {
                    _caloriesRange = const RangeValues(0, 1000);
                    _proteinRange = const RangeValues(0, 100);
                    _applyFilters();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterChip({
    required String label,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.full),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.xs,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: .1),
          borderRadius: BorderRadius.circular(AppRadius.full),
          border: Border.all(color: color.withValues(alpha: .5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: AppSpacing.xs),
            Text(
              label,
              style: AppTypography.labelSmall.copyWith(
                color: color,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(width: AppSpacing.xs),
            Icon(Icons.close, size: 14, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      margin: const EdgeInsets.all(AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [AppShadows.card],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: Theme.of(context).primaryColor),
              const SizedBox(width: AppSpacing.sm),
              Text(
                'Filtros Avanzados',
                style: AppTypography.titleMedium,
              ),
            ],
          ),
          const Divider(height: AppSpacing.lg),
          _buildRangeFilterSection(
            title: 'Calorías',
            icon: Icons.local_fire_department,
            iconColor: Colors.orange,
            currentRange: _caloriesRange,
            maxRange: 1000,
            unit: 'kcal',
            onChanged: (values) {
              setState(() {
                _caloriesRange = values;
                _applyFilters();
              });
            },
          ),
          const SizedBox(height: AppSpacing.md),
          _buildRangeFilterSection(
            title: 'Proteínas',
            icon: FontAwesomeIcons.dna,
            iconColor: Colors.green,
            currentRange: _proteinRange,
            maxRange: 100,
            unit: 'g',
            onChanged: (values) {
              setState(() {
                _proteinRange = values;
                _applyFilters();
              });
            },
          ),
          Padding(
            padding: const EdgeInsets.only(top: AppSpacing.lg),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton.icon(
                  onPressed: () {
                    setState(() {
                      _caloriesRange = RangeValues(0, 1000);
                      _proteinRange = RangeValues(0, 100);
                      _applyFilters();
                    });
                  },
                  icon: const Icon(Icons.restore),
                  label: Text('Restablecer', style: AppTypography.labelLarge),
                  style: TextButton.styleFrom(
                    foregroundColor: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                ElevatedButton.icon(
                  onPressed: () {
                    _applyFilters();
                    setState(() {
                      _showFilterPanel = false;
                    });
                  },
                  icon: const Icon(Icons.check),
                  label: Text('Aplicar',
                      style: AppTypography.labelLarge
                          .copyWith(color: Colors.white)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                      vertical: AppSpacing.sm,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRangeFilterSection({
    required String title,
    required IconData icon,
    required Color iconColor,
    required RangeValues currentRange,
    required double maxRange,
    required String unit,
    required Function(RangeValues) onChanged,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, size: 18, color: iconColor),
            const SizedBox(width: AppSpacing.sm),
            Text(
              title,
              style: AppTypography.titleSmall,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: iconColor.withValues(alpha: .3)),
              ),
              child: Text(
                '${currentRange.start.round()} $unit',
                style: AppTypography.labelLarge.copyWith(
                  color: iconColor.withValues(alpha: .8),
                ),
              ),
            ),
            Text('hasta', style: AppTypography.bodySmall),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              decoration: BoxDecoration(
                color: iconColor.withValues(alpha: .1),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: iconColor.withValues(alpha: .3)),
              ),
              child: Text(
                '${currentRange.end.round()} $unit',
                style: AppTypography.labelLarge.copyWith(
                  color: iconColor.withValues(alpha: .8),
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: iconColor,
            inactiveTrackColor: iconColor.withValues(alpha: .2),
            thumbColor: iconColor,
            overlayColor: iconColor.withValues(alpha: .2),
            trackHeight: 4.0,
            rangeThumbShape: const RoundRangeSliderThumbShape(
              enabledThumbRadius: 6.0,
              elevation: 4.0,
            ),
            overlayShape: const RoundSliderOverlayShape(overlayRadius: 16.0),
          ),
          child: RangeSlider(
            values: currentRange,
            min: 0,
            max: maxRange,
            divisions: 20,
            labels: RangeLabels(
              '${currentRange.start.round()} $unit',
              '${currentRange.end.round()} $unit',
            ),
            onChanged: onChanged,
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('0', style: AppTypography.bodySmall),
              Text('${(maxRange / 4).round()}', style: AppTypography.bodySmall),
              Text('${(maxRange / 2).round()}', style: AppTypography.bodySmall),
              Text('${(maxRange * 3 / 4).round()}',
                  style: AppTypography.bodySmall),
              Text('${maxRange.round()}', style: AppTypography.bodySmall),
            ],
          ),
        ),
      ],
    );
  }

  void _showSortingDialog() {
    final Map<String, IconData> sortIcons = {
      "Alfabético (A-Z)": Icons.sort_by_alpha,
      "Alfabético (Z-A)": Icons.sort,
      "Calorías (menor a mayor)": FontAwesomeIcons.fireFlameCurved,
      "Calorías (mayor a menor)": FontAwesomeIcons.fireFlameCurved,
      "Proteínas (menor a mayor)": FontAwesomeIcons.dna,
      "Proteínas (mayor a menor)": FontAwesomeIcons.dna,
      "Recientes primero": Icons.history,
    };

    final Map<String, Widget> sortDirections = {
      "Alfabético (A-Z)": const Icon(Icons.arrow_upward, size: 16),
      "Alfabético (Z-A)": const Icon(Icons.arrow_downward, size: 16),
      "Calorías (menor a mayor)": const Icon(Icons.arrow_upward, size: 16),
      "Calorías (mayor a menor)": const Icon(Icons.arrow_downward, size: 16),
      "Proteínas (menor a mayor)": const Icon(Icons.arrow_upward, size: 16),
      "Proteínas (mayor a menor)": const Icon(Icons.arrow_downward, size: 16),
      "Recientes primero":
          const Icon(Icons.star, size: 16, color: Colors.amber),
    };

    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppRadius.xl),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: AppSpacing.md,
              horizontal: AppSpacing.sm,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding: const EdgeInsets.only(
                    bottom: AppSpacing.md,
                    left: AppSpacing.md,
                    right: AppSpacing.md,
                  ),
                  child: Row(
                    children: [
                      Icon(Icons.sort, color: Theme.of(context).primaryColor),
                      const SizedBox(width: AppSpacing.sm),
                      Text(
                        'Ordenar Alimentos',
                        style: AppTypography.titleMedium,
                      ),
                    ],
                  ),
                ),
                const Divider(height: 1),
                SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: _sortingMethods.length,
                    itemBuilder: (context, index) {
                      final method = _sortingMethods[index];
                      final isSelected = _currentSortingMethod == method;

                      return Material(
                        color: isSelected
                            ? Theme.of(context)
                                .primaryColor
                                .withValues(alpha: .1)
                            : Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _currentSortingMethod = method;
                              _applySorting();
                            });
                          },
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: AppSpacing.md,
                              horizontal: AppSpacing.md,
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(AppSpacing.sm),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withValues(alpha: .2)
                                        : AppColors.background,
                                    borderRadius:
                                        BorderRadius.circular(AppRadius.sm),
                                  ),
                                  child: Icon(
                                    sortIcons[method],
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : AppColors.textSecondary,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: AppSpacing.md),
                                Expanded(
                                  child: Text(
                                    method.replaceAll(' (', '\n('),
                                    style: AppTypography.bodyMedium.copyWith(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : AppColors.textPrimary,
                                    ),
                                  ),
                                ),
                                sortDirections[method] ?? Container(),
                                const SizedBox(width: AppSpacing.sm),
                                if (isSelected)
                                  Icon(
                                    Icons.check_circle,
                                    color: Theme.of(context).primaryColor,
                                    size: 20,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text(
                    'Cancelar',
                    style: AppTypography.labelLarge.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildFoodCard(Food food) {
    Color categoryColor;
    IconData categoryIcon;

    switch (food.category) {
      case 'cereal':
        categoryColor = sectionColors[0];
        categoryIcon = FontAwesomeIcons.wheatAwn;
        break;
      case 'leguminosa':
        categoryColor = sectionColors[1];
        categoryIcon = FontAwesomeIcons.seedling;
        break;
      case 'animal':
        categoryColor = sectionColors[2];
        categoryIcon = FontAwesomeIcons.cow;
        break;
      case 'verdura':
        categoryColor = sectionColors[4];
        categoryIcon = FontAwesomeIcons.carrot;
        break;
      case 'fruta':
        categoryColor = sectionColors[4];
        categoryIcon = FontAwesomeIcons.appleWhole;
        break;
      default:
        categoryColor = AppColors.textSecondary;
        categoryIcon = Icons.food_bank;
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        boxShadow: [AppShadows.card],
      ),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {
          addToRecentFoods(food);

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            builder: (context) => Container(
              height: MediaQuery.of(context).size.height * 0.7,
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppRadius.xl),
                ),
              ),
              child: FoodViewScreen(food: food),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            Container(
              color: categoryColor.withValues(alpha: .15),
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: AppSpacing.xs,
              ),
              child: Row(
                children: [
                  Icon(categoryIcon, size: 14, color: categoryColor),
                  const SizedBox(width: AppSpacing.xs),
                  Expanded(
                    child: Text(
                      food.category.substring(0, 1).toUpperCase() +
                          food.category.substring(1),
                      style: AppTypography.labelSmall.copyWith(
                        color: categoryColor,
                        fontWeight: FontWeight.w600,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            // Image
            Expanded(
              flex: 3,
              child: Container(
                color: categoryColor.withValues(alpha: .08),
                width: double.infinity,
                child: food.image ??
                    Icon(
                      categoryIcon,
                      size: 50,
                      color: categoryColor.withValues(alpha: .4),
                    ),
              ),
            ),
            // Info
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: AppTypography.labelLarge.copyWith(
                        color: AppColors.textPrimary,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrientBadge(
                          'Calorías',
                          '${double.tryParse(food.energia)?.round() ?? 0}',
                          'kcal',
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        _buildNutrientBadge(
                          'Proteína',
                          food.proteina,
                          'g',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNutrientBadge(String label, String value, String unit) {
    return Flexible(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            label,
            style: AppTypography.bodySmall.copyWith(
              fontSize: 8,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            '$value $unit',
            style: AppTypography.labelSmall.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 10,
            ),
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}
