import 'package:flutter/material.dart';
import 'package:nutriplato/data/food/animals.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../presentation/screens/food/food.view.dart';

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

  @override
  void initState() {
    super.initState();
    allFoods = [];
    allFoods.addAll(animals);
    allFoods.addAll(verduras);
    allFoods.addAll(frutas);
    allFoods.addAll(leguminosas);
    allFoods.addAll(cereales);
    loadRecentFoods();
    filteredFoods = allFoods;
    filteredFoods.sort((a, b) => a.name.compareTo(b.name));
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
      recentFoods = foodNames
          .map((name) => allFoods.firstWhere((food) => food.name == name))
          .toList();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 245, 245, 245),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 8,
            ),
            child: SearchAnchor.bar(
              barElevation: const MaterialStatePropertyAll(2),
              viewElevation: 2,
              isFullScreen: true,
              barHintText: 'Buscar alimentos',
              barShape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              viewShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              suggestionsBuilder: (context, controller) {
                var textEditingValue = controller.text;
                var startsWith = allFoods.where((Food food) {
                  return food.name
                      .toLowerCase()
                      .startsWith(textEditingValue.toLowerCase());
                }).toList();
                var contains = allFoods.where((Food food) {
                  return food.name
                      .toLowerCase()
                      .contains(textEditingValue.toLowerCase());
                }).toList();
                contains.removeWhere((element) => startsWith.contains(element));
                startsWith.addAll(contains);

                return startsWith
                    .map(
                      (food) => ListTile(
                        title: Text(food.name),
                        onTap: () => showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) => SizedBox(
                            height: MediaQuery.of(context).size.height * 0.6,
                            child: FoodViewScreen(food: food),
                          ),
                        ),
                      ),
                    )
                    .toList();
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                style: FilledButton.styleFrom(
                    backgroundColor: Colors.purple.withAlpha(30)),
                onPressed: () {
                  setState(() {
                    showList = true;
                    filteredFoods = recentFoods;
                  });
                },
                child: const Row(
                  children: [
                    Icon(Icons.history, color: Colors.purple),
                    SizedBox(
                      width: 5,
                    ),
                    Text('Recientes', style: TextStyle(color: Colors.black))
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
