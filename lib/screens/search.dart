import 'package:flutter/material.dart';
import 'package:nutriplato/data/food/cereales.dart';
import 'package:nutriplato/data/food/frutas.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/data/food/verduras.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../data/food/animals.dart';
import '../models/food/food.dart';
import '../widgets/food.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<StatefulWidget> createState() => _Search();
}

class _Search extends State<Search> {
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
    // Convertir la lista de alimentos recientes a una lista de cadenas
    List<String> foodNames = recentFoods.map((food) => food.name).toList();
    // Guardar la lista de cadenas en SharedPreferences
    await prefs.setStringList('recentFoods', foodNames);
  }

  Future<void> loadRecentFoods() async {
    final prefs = await SharedPreferences.getInstance();
    // Cargar la lista de cadenas desde SharedPreferences
    List<String>? foodNames = prefs.getStringList('recentFoods');
    if (foodNames != null) {
      // Convertir la lista de cadenas a una lista de alimentos
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
            padding: const EdgeInsets.all(16.0),
            child: Card(
              elevation: 1,
              child: Padding(
                padding: const EdgeInsets.only(left: 8, right: 8),
                child: SizedBox(
                  child: Autocomplete<Food>(
                    optionsBuilder: (TextEditingValue textEditingValue) {
                      if (textEditingValue.text == '') {
                        return const Iterable<Food>.empty();
                      }
                      var startsWith = allFoods.where((Food food) {
                        return food.name
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      }).toList();
                      var contains = allFoods.where((Food food) {
                        return food.name
                            .toLowerCase()
                            .contains(textEditingValue.text.toLowerCase());
                      }).toList();
                      contains.removeWhere(
                          (element) => startsWith.contains(element));
                      startsWith.addAll(contains);
                      return startsWith;
                    },
                    displayStringForOption: (Food food) => food.name,
                    onSelected: (Food food) {
                      setState(() {
                        filteredFoods = [food];
                      });
                    },
                    fieldViewBuilder: (BuildContext context,
                        TextEditingController fieldTextEditingController,
                        FocusNode fieldFocusNode,
                        VoidCallback onFieldSubmitted) {
                      fieldTextEditingController.text = searchController.text;

                      return TextField(
                        style: const TextStyle(color: Colors.black),
                        cursorColor: Theme.of(context).primaryColor,
                        controller: fieldTextEditingController,
                        focusNode: fieldFocusNode,
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: 'Buscar alimentos o receta',
                          icon: Icon(Icons.search,
                              color: Theme.of(context).primaryColor),
                          suffixIcon: IconButton(
                            icon: const Icon(
                              Icons.clear,
                              color: Colors.purple,
                            ),
                            onPressed: () {
                              fieldTextEditingController.clear();
                              searchController.clear();
                              setState(() {
                                showList = false;
                              });
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          searchController.text = value;
                        },
                        onSubmitted: (String value) {
                          setState(() {
                            if (value.isEmpty) {
                              showList = false;
                            } else {
                              showList = true;
                              filteredFoods = allFoods.where((Food food) {
                                return food.name
                                    .toLowerCase()
                                    .startsWith(value.toLowerCase());
                              }).toList();
                            }
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
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
                  child: Row(
                    children: const [
                      Icon(Icons.history, color: Colors.purple),
                      SizedBox(
                        width: 5,
                      ),
                      Text('Recientes', style: TextStyle(color: Colors.black))
                    ],
                  )),
            ],
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: showList
                  ? ListView.builder(
                      itemCount: filteredFoods.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          onTap: () {
                            setState(() {
                              // Agregar el alimento seleccionado a la lista de alimentos recientes solo si no está ya en la lista
                              if (!recentFoods.contains(filteredFoods[index])) {
                                recentFoods.insert(0, filteredFoods[index]);
                                saveRecentFoods(); // Guardar la lista de alimentos recientes en SharedPreferences
                              }
                            });
                            showModalBottomSheet(
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.7,
                                    child: ProportionFood(
                                      food: filteredFoods[index],
                                    ),
                                  );
                                });
                          },
                          leading: filteredFoods[index].icon,
                          title: Text(filteredFoods[index].name),
                        );
                      },
                    )
                  : Container(),
            ),
          ),
        ],
      ),
    );
  }
}
