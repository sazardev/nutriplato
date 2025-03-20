import 'package:flutter/material.dart';
import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
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
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      appBar: AppBar(
        title: const Text('Buscador de Alimentos'),
        actions: [
          IconButton(
            icon: const Icon(Icons.sort),
            onPressed: () => _showSortingDialog(),
          ),
          IconButton(
            icon: const Icon(Icons.filter_list),
            onPressed: () {
              setState(() {
                _showFilterPanel = !_showFilterPanel;
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: searchController,
              decoration: InputDecoration(
                hintText: 'Buscar alimentos...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: searchController.text.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                          _applyFilters();
                        },
                      )
                    : null,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              onChanged: (value) {
                _applyFilters();
              },
            ),
          ),
          SizedBox(
            height: 60,
            child: ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              children: _foodCategories.entries.map((entry) {
                bool isActive = _activeView == entry.key;
                return Padding(
                  padding: const EdgeInsets.only(right: 10),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _activeView = entry.key;
                        _applyFilters();
                      });
                    },
                    borderRadius: BorderRadius.circular(12),
                    child: Chip(
                      backgroundColor:
                          isActive ? Colors.purple : Colors.grey[200],
                      avatar: Icon(
                        entry.value,
                        color: isActive ? Colors.white : Colors.grey[700],
                        size: 16,
                      ),
                      label: Text(
                        entry.key,
                        style: TextStyle(
                          color: isActive ? Colors.white : Colors.grey[700],
                        ),
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          if (_hasActiveFilters()) _buildActiveFiltersBar(),
          if (_showFilterPanel) _buildFilterPanel(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              children: [
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.list_alt,
                        size: 16,
                        color: Theme.of(context).primaryColor,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${filteredFoods.length} resultados',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColor,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                InkWell(
                  onTap: () => _showSortingDialog(),
                  borderRadius: BorderRadius.circular(20),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.sort,
                          size: 16,
                          color: Colors.black87,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          _getSortMethodShortName(),
                          style: const TextStyle(
                              fontSize: 12, color: Colors.black87),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: filteredFoods.isEmpty
                ? const Center(child: Text('No se encontraron alimentos'))
                : GridView.builder(
                    padding: const EdgeInsets.all(16),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.75,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: filteredFoods.length,
                    itemBuilder: (context, index) {
                      return _buildFoodCard(filteredFoods[index]);
                    },
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildActiveFiltersBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      color: Colors.grey[200],
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
            const SizedBox(width: 8),
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
            const SizedBox(width: 8),
            if (_hasActiveFilters())
              _buildFilterChip(
                label: 'Limpiar todos',
                icon: Icons.clear_all,
                color: Colors.red,
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
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        decoration: BoxDecoration(
          color: color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: color.withOpacity(0.5)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 14, color: color),
            const SizedBox(width: 4),
            Text(
              label,
              style: TextStyle(
                  color: color, fontWeight: FontWeight.w500, fontSize: 12),
            ),
            const SizedBox(width: 4),
            Icon(Icons.close, size: 14, color: color),
          ],
        ),
      ),
    );
  }

  Widget _buildFilterPanel() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.white, Colors.grey.shade100],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(16),
          bottomRight: Radius.circular(16),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.tune, color: Theme.of(context).primaryColor),
              const SizedBox(width: 8),
              const Text(
                'Filtros Avanzados',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
            ],
          ),
          const Divider(),
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
          const SizedBox(height: 16),
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
            padding: const EdgeInsets.only(top: 20.0),
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
                  label: const Text('Restablecer'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.grey[700],
                  ),
                ),
                const SizedBox(width: 12),
                ElevatedButton.icon(
                  onPressed: () {
                    _applyFilters();
                    setState(() {
                      _showFilterPanel = false;
                    });
                  },
                  icon: const Icon(Icons.check),
                  label: const Text('Aplicar'),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor,
                    elevation: 2,
                    padding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            const SizedBox(width: 8),
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: iconColor.withOpacity(0.3)),
              ),
              child: Text(
                '${currentRange.start.round()} $unit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor.withOpacity(0.8),
                ),
              ),
            ),
            Text('hasta',
                style: TextStyle(color: Colors.grey[600], fontSize: 12)),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: iconColor.withOpacity(0.3)),
              ),
              child: Text(
                '${currentRange.end.round()} $unit',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: iconColor.withOpacity(0.8),
                ),
              ),
            ),
          ],
        ),
        SliderTheme(
          data: SliderThemeData(
            activeTrackColor: iconColor,
            inactiveTrackColor: iconColor.withOpacity(0.2),
            thumbColor: iconColor,
            overlayColor: iconColor.withOpacity(0.2),
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
              Text('0',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              Text('${(maxRange / 4).round()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              Text('${(maxRange / 2).round()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              Text('${(maxRange * 3 / 4).round()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
              Text('${maxRange.round()}',
                  style: TextStyle(fontSize: 10, color: Colors.grey[500])),
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
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(bottom: 16, left: 16, right: 16),
                  child: Row(
                    children: [
                      Icon(Icons.sort, color: Theme.of(context).primaryColor),
                      const SizedBox(width: 8),
                      const Text(
                        'Ordenar Alimentos',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
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
                            ? Theme.of(context).primaryColor.withOpacity(0.1)
                            : Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context);
                            setState(() {
                              _currentSortingMethod = method;
                              _applySorting();
                            });
                          },
                          borderRadius: BorderRadius.circular(8),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                vertical: 12, horizontal: 16),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: isSelected
                                        ? Theme.of(context)
                                            .primaryColor
                                            .withOpacity(0.2)
                                        : Colors.grey[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    sortIcons[method],
                                    color: isSelected
                                        ? Theme.of(context).primaryColor
                                        : Colors.grey[700],
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Text(
                                    method.replaceAll(' (', '\n('),
                                    style: TextStyle(
                                      fontWeight: isSelected
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                      color: isSelected
                                          ? Theme.of(context).primaryColor
                                          : null,
                                    ),
                                  ),
                                ),
                                sortDirections[method] ?? Container(),
                                const SizedBox(width: 8),
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
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Cancelar'),
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
        categoryColor = Colors.grey;
        categoryIcon = Icons.food_bank;
    }

    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          addToRecentFoods(food);

          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => SizedBox(
              height: MediaQuery.of(context).size.height * 0.7,
              child: FoodViewScreen(food: food),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: categoryColor.withOpacity(0.2),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              child: Row(
                children: [
                  Icon(categoryIcon, size: 14, color: categoryColor),
                  const SizedBox(width: 4),
                  Expanded(
                    child: Text(
                      food.category.substring(0, 1).toUpperCase() +
                          food.category.substring(1),
                      style: TextStyle(
                        fontSize: 12,
                        color: categoryColor,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(
                color: categoryColor.withOpacity(0.1),
                width: double.infinity,
                child: food.image ??
                    Icon(
                      categoryIcon,
                      size: 50,
                      color: categoryColor.withOpacity(0.5),
                    ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      food.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const Spacer(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        _buildNutrientBadge(
                          'Calorías',
                          '${double.tryParse(food.energia)?.round() ?? 0}',
                          'kcal',
                        ),
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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10,
            color: Colors.grey[600],
          ),
        ),
        Text(
          '$value $unit',
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 12,
          ),
        ),
      ],
    );
  }
}
