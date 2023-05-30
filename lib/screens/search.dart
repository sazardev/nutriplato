import 'package:flutter/material.dart';
import 'package:nutriplato/data/cereales.dart';
import 'package:nutriplato/data/frutas.dart';
import 'package:nutriplato/data/leguminosas.dart';
import 'package:nutriplato/data/verduras.dart';
import '../data/animals.dart';
import '../models/food.dart';
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

  @override
  void initState() {
    super.initState();
    allFoods = [];
    allFoods.addAll(animals);
    allFoods.addAll(verduras);
    allFoods.addAll(frutas);
    allFoods.addAll(leguminosas);
    allFoods.addAll(cereales);
    filteredFoods = allFoods;
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
                      return allFoods.where((Food food) {
                        return food.name
                            .toLowerCase()
                            .startsWith(textEditingValue.text.toLowerCase());
                      });
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
                            },
                          ),
                        ),
                        onChanged: (String value) {
                          searchController.text = value;
                        },
                        onSubmitted: (String value) {
                          setState(() {
                            filteredFoods = allFoods.where((Food food) {
                              return food.name
                                  .toLowerCase()
                                  .contains(value.toLowerCase());
                            }).toList();
                          });
                        },
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListView.builder(
                itemCount: 20,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    onTap: () {
                      showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return SizedBox(
                              height: MediaQuery.of(context).size.height * 0.7,
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
              ),
            ),
          ),
        ],
      ),
    );
  }
}
