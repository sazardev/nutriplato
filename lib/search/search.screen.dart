import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/config/theme/design_system.dart';
import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/azucares.dart';
import 'package:nutriplato/data/food/bebidas.dart';
import 'package:nutriplato/data/food/botanas.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/condimentos.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/grasas.dart';
import 'package:nutriplato/data/food/lacteos.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/infrastructure/entities/food/custom_food_provider.dart';
import 'package:nutriplato/infrastructure/entities/food/favorites_provider.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../presentation/screens/food/food.view.dart';
import 'dialogs/create_food_dialog.dart';
import 'dialogs/online_food_search_sheet.dart';
import 'dialogs/search_sorting_dialog.dart';
import 'widgets/search_active_filters_bar.dart';
import 'widgets/search_filter_panel.dart';
import 'widgets/search_food_card.dart';
import 'widgets/search_results_header.dart';

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

  String _currentSortingMethod = 'Alfabético (A-Z)';
  RangeValues _caloriesRange = const RangeValues(0, 1000);
  RangeValues _proteinRange = const RangeValues(0, 100);
  bool _showFilterPanel = false;
  String _activeView = 'Todos';

  final Map<String, IconData> _foodCategories = {
    'Todos': Icons.all_inclusive,
    'Cereales': FontAwesomeIcons.wheatAwn.data,
    'Leguminosas': FontAwesomeIcons.seedling.data,
    'Animal': FontAwesomeIcons.cow.data,
    'Verduras': FontAwesomeIcons.carrot.data,
    'Frutas': FontAwesomeIcons.appleWhole.data,
    'Grasas': FontAwesomeIcons.droplet.data,
    'Lácteos': FontAwesomeIcons.glassWater.data,
    'Bebidas': FontAwesomeIcons.mugHot.data,
    'Azúcares': FontAwesomeIcons.candyCane.data,
    'Botanas': FontAwesomeIcons.bagShopping.data,
    'Condimentos': FontAwesomeIcons.mortarPestle.data,
    'Favoritos': Icons.favorite,
    'Mis alimentos': Icons.add_box_outlined,
    'Recientes': Icons.history,
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
    allFoods.addAll(grasas);
    allFoods.addAll(lacteos);
    allFoods.addAll(bebidas);
    allFoods.addAll(azucares);
    allFoods.addAll(botanas);
    allFoods.addAll(condimentos);

    _updateRanges();
    loadRecentFoods();

    filteredFoods = List.from(allFoods);
    _applySorting();
  }

  void _updateRanges() {
    double maxCalories = 0;
    double maxProtein = 0;

    for (var food in allFoods) {
      final double calories = double.tryParse(food.energia) ?? 0;
      final double protein = double.tryParse(food.proteina) ?? 0;

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
    final List<String> foodNames = recentFoods
        .map((food) => food.name)
        .toList();
    await prefs.setStringList('recentFoods', foodNames);
  }

  Future<void> loadRecentFoods() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String>? foodNames = prefs.getStringList('recentFoods');
    if (foodNames != null) {
      recentFoods = [];
      for (var name in foodNames) {
        try {
          final found = allFoods.firstWhere((food) => food.name == name);
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

      if (_activeView != 'Todos' && _activeView != 'Recientes') {
        filteredFoods = filteredFoods.where((food) {
          switch (_activeView) {
            case 'Cereales':
              return food.category == 'cereal';
            case 'Leguminosas':
              return food.category == 'leguminosa';
            case 'Animal':
              return food.category == 'animal';
            case 'Verduras':
              return food.category == 'verdura';
            case 'Frutas':
              return food.category == 'fruta';
            case 'Grasas':
              return food.category == 'grasa';
            case 'Lácteos':
              return food.category == 'lacteo';
            case 'Bebidas':
              return food.category == 'bebida';
            case 'Azúcares':
              return food.category == 'azucar';
            case 'Botanas':
              return food.category == 'botana';
            case 'Condimentos':
              return food.category == 'condimento';
            default:
              return true;
          }
        }).toList();
      } else if (_activeView == 'Recientes') {
        filteredFoods = List.from(recentFoods);
      }

      if (searchController.text.isNotEmpty) {
        final String query = searchController.text.toLowerCase();
        filteredFoods = filteredFoods
            .where((food) => food.name.toLowerCase().contains(query))
            .toList();
      }

      filteredFoods = filteredFoods.where((food) {
        final double calories = double.tryParse(food.energia) ?? 0;
        return calories >= _caloriesRange.start &&
            calories <= _caloriesRange.end;
      }).toList();

      filteredFoods = filteredFoods.where((food) {
        final double protein = double.tryParse(food.proteina) ?? 0;
        return protein >= _proteinRange.start && protein <= _proteinRange.end;
      }).toList();

      _applySorting();
    });
  }

  void _applySorting() {
    _sortList(filteredFoods);
  }

  /// Ordena una lista según el método de ordenamiento actual.
  void _sortList(List<Food> list) {
    switch (_currentSortingMethod) {
      case 'Alfabético (A-Z)':
        list.sort((a, b) => a.name.compareTo(b.name));
        break;
      case 'Alfabético (Z-A)':
        list.sort((a, b) => b.name.compareTo(a.name));
        break;
      case 'Calorías (menor a mayor)':
        list.sort(
          (a, b) => (double.tryParse(a.energia) ?? 0).compareTo(
            double.tryParse(b.energia) ?? 0,
          ),
        );
        break;
      case 'Calorías (mayor a menor)':
        list.sort(
          (a, b) => (double.tryParse(b.energia) ?? 0).compareTo(
            double.tryParse(a.energia) ?? 0,
          ),
        );
        break;
      case 'Proteínas (menor a mayor)':
        list.sort(
          (a, b) => (double.tryParse(a.proteina) ?? 0).compareTo(
            double.tryParse(b.proteina) ?? 0,
          ),
        );
        break;
      case 'Proteínas (mayor a menor)':
        list.sort(
          (a, b) => (double.tryParse(b.proteina) ?? 0).compareTo(
            double.tryParse(a.proteina) ?? 0,
          ),
        );
        break;
      case 'Recientes primero':
        list.sort((a, b) {
          int aIndex = recentFoods.indexWhere((food) => food.name == a.name);
          int bIndex = recentFoods.indexWhere((food) => food.name == b.name);
          if (aIndex == -1) aIndex = 999;
          if (bIndex == -1) bIndex = 999;
          return aIndex - bIndex;
        });
        break;
    }
  }

  bool _categoryMatches(Food food) {
    switch (_activeView) {
      case 'Cereales':
        return food.category == 'cereal';
      case 'Leguminosas':
        return food.category == 'leguminosa';
      case 'Animal':
        return food.category == 'animal';
      case 'Verduras':
        return food.category == 'verdura';
      case 'Frutas':
        return food.category == 'fruta';
      case 'Grasas':
        return food.category == 'grasa';
      case 'Lácteos':
        return food.category == 'lacteo';
      case 'Bebidas':
        return food.category == 'bebida';
      case 'Azúcares':
        return food.category == 'azucar';
      case 'Botanas':
        return food.category == 'botana';
      case 'Condimentos':
        return food.category == 'condimento';
      default:
        return true;
    }
  }

  /// Calcula la lista visible en build combinando datos base, alimentos
  /// personalizados y favoritos, aplicando filtros y ordenamiento.
  List<Food> _freshList() {
    final customFoods = context.read<CustomFoodProvider>().foods;
    final favorites = context.read<FavoritesProvider>();
    final pool = [...allFoods, ...customFoods];

    List<Food> list;
    if (_activeView == 'Recientes') {
      list = List.from(recentFoods);
    } else if (_activeView == 'Favoritos') {
      list = pool.where((f) => favorites.isFavorite(f.name)).toList();
    } else if (_activeView == 'Mis alimentos') {
      list = List.from(customFoods);
    } else {
      list = List.from(pool);
      if (_activeView != 'Todos') {
        list = list.where(_categoryMatches).toList();
      }
    }

    if (searchController.text.isNotEmpty) {
      final query = searchController.text.toLowerCase();
      list = list.where((f) => f.name.toLowerCase().contains(query)).toList();
    }

    list = list.where((food) {
      final calories = double.tryParse(food.energia) ?? 0;
      return calories >= _caloriesRange.start && calories <= _caloriesRange.end;
    }).toList();

    list = list.where((food) {
      final protein = double.tryParse(food.proteina) ?? 0;
      return protein >= _proteinRange.start && protein <= _proteinRange.end;
    }).toList();

    _sortList(list);
    return list;
  }

  bool _hasActiveFilters() {
    return _caloriesRange.start > 0 ||
        _caloriesRange.end < 1000 ||
        _proteinRange.start > 0 ||
        _proteinRange.end < 100;
  }

  String _getSortMethodShortName() {
    switch (_currentSortingMethod) {
      case 'Alfabético (A-Z)':
        return 'A→Z';
      case 'Alfabético (Z-A)':
        return 'Z→A';
      case 'Calorías (menor a mayor)':
        return 'Cal ↑';
      case 'Calorías (mayor a menor)':
        return 'Cal ↓';
      case 'Proteínas (menor a mayor)':
        return 'Prot ↑';
      case 'Proteínas (mayor a menor)':
        return 'Prot ↓';
      case 'Recientes primero':
        return 'Recientes';
      default:
        return _currentSortingMethod;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CustomFoodProvider>(
      builder: (context, customFoodProvider, _) {
        return Consumer<FavoritesProvider>(
          builder: (context, favoritesProvider, _) {
            final displayFoods = _freshList();
            return _buildScaffold(context, displayFoods);
          },
        );
      },
    );
  }

  Widget _buildScaffold(BuildContext context, List<Food> displayFoods) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header con gradiente unificado
          SliverAppBar(
            expandedHeight: 140,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(gradient: AppGradients.primary),
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
                  decoration: BoxDecoration(gradient: AppGradients.primary),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.restaurant_menu,
                            color: Colors.white.withValues(alpha: .3),
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(Icons.cloud_outlined, color: Colors.white),
                tooltip: 'Buscar en OpenFoodFacts',
                onPressed: () => _showOnlineSearch(context),
              ),
              IconButton(
                icon: const Icon(Icons.add_box_outlined, color: Colors.white),
                tooltip: 'Crear alimento',
                onPressed: () => _showCreateFoodDialog(),
              ),
              IconButton(
                icon: const Icon(Icons.sort, color: Colors.white),
                tooltip: 'Ordenar',
                onPressed: () => _showSortingDialog(),
              ),
              IconButton(
                icon: Icon(
                  _showFilterPanel ? Icons.filter_list_off : Icons.filter_list,
                  color: Colors.white,
                ),
                tooltip: 'Filtros',
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
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textSecondary,
                        ),
                        suffixIcon: searchController.text.isNotEmpty
                            ? IconButton(
                                icon: Icon(
                                  Icons.clear,
                                  color: AppColors.textSecondary,
                                ),
                                tooltip: 'Limpiar búsqueda',
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
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.md,
                    ),
                    children: _foodCategories.entries.map((entry) {
                      final bool isActive = _activeView == entry.key;
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
                              borderRadius: BorderRadius.circular(
                                AppRadius.full,
                              ),
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
                if (_hasActiveFilters())
                  SearchActiveFiltersBar(
                    caloriesRange: _caloriesRange,
                    proteinRange: _proteinRange,
                    hasActiveFilters: _hasActiveFilters(),
                    onClearCalories: () {
                      setState(() {
                        _caloriesRange = const RangeValues(0, 1000);
                        _applyFilters();
                      });
                    },
                    onClearProtein: () {
                      setState(() {
                        _proteinRange = const RangeValues(0, 100);
                        _applyFilters();
                      });
                    },
                    onClearAll: () {
                      setState(() {
                        _caloriesRange = const RangeValues(0, 1000);
                        _proteinRange = const RangeValues(0, 100);
                        _applyFilters();
                      });
                    },
                  ),

                // Panel de filtros
                if (_showFilterPanel)
                  SearchFilterPanel(
                    caloriesRange: _caloriesRange,
                    proteinRange: _proteinRange,
                    onCaloriesChanged: (values) {
                      setState(() {
                        _caloriesRange = values;
                        _applyFilters();
                      });
                    },
                    onProteinChanged: (values) {
                      setState(() {
                        _proteinRange = values;
                        _applyFilters();
                      });
                    },
                    onReset: () {
                      setState(() {
                        _caloriesRange = const RangeValues(0, 1000);
                        _proteinRange = const RangeValues(0, 100);
                        _applyFilters();
                      });
                    },
                    onApply: () {
                      _applyFilters();
                      setState(() {
                        _showFilterPanel = false;
                      });
                    },
                  ),

                // Contador de resultados y ordenamiento
                SearchResultsHeader(
                  resultCount: displayFoods.length,
                  sortLabel: _getSortMethodShortName(),
                  onSortTap: _showSortingDialog,
                ),
              ],
            ),
          ),

          // Grid de alimentos
          displayFoods.isEmpty
              ? SliverFillRemaining(
                  hasScrollBody: false,
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: AppColors.textSecondary.withValues(
                              alpha: .5,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                          Text(
                            'No se encontraron alimentos en la base local',
                            textAlign: TextAlign.center,
                            style: AppTypography.bodyLarge.copyWith(
                              color: AppColors.textSecondary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          OutlinedButton.icon(
                            onPressed: () => _showOnlineSearch(context),
                            icon: const Icon(Icons.cloud_queue),
                            label: const Text('Buscar en OpenFoodFacts'),
                            style: OutlinedButton.styleFrom(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                          ),
                        ],
                      ),
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
                      (context, index) => SearchFoodCard(
                        food: displayFoods[index],
                        onTap: () => _openFoodDetails(displayFoods[index]),
                      ),
                      childCount: displayFoods.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _openFoodDetails(Food food) {
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
  }

  void _showOnlineSearch(BuildContext context) {
    showOnlineSearchSheet(context, initialQuery: searchController.text);
  }

  Future<void> _showCreateFoodDialog() {
    return showCreateFoodDialog(
      context,
      onCreated: () {
        setState(() {
          _activeView = 'Mis alimentos';
        });
      },
    );
  }

  void _showSortingDialog() {
    showSearchSortingDialog(context, _currentSortingMethod, (method) {
      setState(() {
        _currentSortingMethod = method;
        _applySorting();
      });
    });
  }
}
