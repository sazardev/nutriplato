import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/route_manager.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_entry.dart';
import 'package:nutriplato/infrastructure/entities/food/food_log_provider.dart';
import 'package:nutriplato/presentation/home.screen.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/example_hands_screen.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/advertice_food.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../data/food/animals.dart';
import '../../../data/food/cereales.dart';
import '../../../data/food/frutas.dart';
import '../../../data/food/verduras.dart';

class FoodViewScreen extends StatefulWidget {
  final Food food;

  const FoodViewScreen({
    super.key,
    required this.food,
  });

  @override
  State<FoodViewScreen> createState() => _DisplayFoodScreen();
}

class _DisplayFoodScreen extends State<FoodViewScreen> {
  final TextStyle styleData = const TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.w500,
  );

  final TextStyle styleDataNames = const TextStyle(
    color: Colors.white,
    fontSize: 16,
  );

  int multiplicador = 1;
  String _selectedMealType = 'Desayuno';
  final List<String> _mealTypes = ['Desayuno', 'Almuerzo', 'Cena', 'Snack'];

  List<dynamic> list = [];
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    switch (widget.food.category) {
      case "leguminosa":
        list = leguminosas;
        break;
      case "animal":
        list = animals;
        break;
      case "cereal":
        list = cereales;
        break;
      case "verdura":
        list = verduras;
        break;
      case "fruta":
        list = frutas;
        break;
    }

    controller = TextEditingController(text: '1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.food.color,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 40,
              child: Divider(
                height: 20,
                thickness: 5,
                color: Colors.white.withAlpha(100),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 8.0,
                right: 8.0,
                top: 8,
                bottom: 8,
              ),
              child: Text(
                widget.food.name,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
              child: Row(
                children: [
                  Text(
                    '${(int.parse(widget.food.energia) * multiplicador)} kcal',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(widget.food.proteina) * multiplicador).toStringAsFixed(1)} g',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(widget.food.hidratosDeCarbono) * multiplicador).toStringAsFixed(1)} g',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(widget.food.lipidos) * multiplicador).toStringAsFixed(1)} g',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Row(
                children: [
                  Text(
                    'calorias',
                    textAlign: TextAlign.center,
                    style: styleDataNames,
                  ),
                  const Spacer(),
                  Text(
                    'proteinas',
                    textAlign: TextAlign.center,
                    style: styleDataNames,
                  ),
                  const Spacer(),
                  Text(
                    'carbs',
                    textAlign: TextAlign.center,
                    style: styleDataNames,
                  ),
                  const Spacer(),
                  Text(
                    'grasas',
                    textAlign: TextAlign.center,
                    style: styleDataNames,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
                top: 16,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Porción',
                    style: styleData,
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return const ExampleHandScreen();
                        }));
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Card(
                    elevation: 1,
                    color: widget.food.color.withAlpha(10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Text(
                        multiplicador == 1
                            ? '${widget.food.cantidadSugerida} ${widget.food.unidad} (${widget.food.pesoNeto} g)'
                            : '(${(double.tryParse(widget.food.pesoNeto) ?? 0) * multiplicador} g)',
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Porciones',
                    style: styleData,
                  ),
                  IconButton(
                      onPressed: () {
                        showDialog(
                            context: context,
                            builder: (builder) {
                              return const AlertDialog(
                                title: Text('Porciones'),
                                content: Text(
                                    'Cantidad recomendada por el Sistema Mexicano de Equivalencias. \n\nPuedes modificar la cantidad que es la equivalencia a una porcion del alimento.'),
                              );
                            });
                      },
                      icon: const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Card(
                    elevation: 1,
                    color: widget.food.color.withAlpha(10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 8,
                        bottom: 8,
                      ),
                      child: SizedBox(
                        width: 50,
                        height: 30,
                        child: TextField(
                          cursorColor: Colors.white,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          controller: controller,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                            FilteringTextInputFormatter.allow(
                                RegExp(r'^[1-9]$|^1[0-9]$|^20$')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isNotEmpty) {
                                if (int.parse(value) > 0 &&
                                    int.parse(value) <= 20) {
                                  multiplicador = int.parse(value);
                                }
                              }
                            });
                          },
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            // Selector de tipo de comida
            Padding(
              padding: const EdgeInsets.only(
                left: 32.0,
                right: 32.0,
                top: 16.0,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Tipo de comida',
                    style: styleData,
                  ),
                  IconButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return const AlertDialog(
                              title: Text('Tipo de comida'),
                              content: Text(
                                  'Selecciona en qué momento del día consumiste este alimento.'),
                            );
                          });
                    },
                    icon: const Icon(
                      Icons.info_outline,
                      size: 20,
                      color: Colors.white,
                    ),
                  ),
                  const Spacer(),
                  Card(
                    elevation: 1,
                    color: widget.food.color.withAlpha(10),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 0,
                      ),
                      child: DropdownButton<String>(
                        value: _selectedMealType,
                        dropdownColor: widget.food.color,
                        underline: const SizedBox(),
                        icon: const Icon(Icons.arrow_drop_down,
                            color: Colors.white),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            setState(() {
                              _selectedMealType = newValue;
                            });
                          }
                        },
                        items: _mealTypes
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 18,
                right: 18,
              ),
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  ((double.parse(widget.food.proteina) * 4) /
                                  (double.parse(widget.food.energia))) *
                              100 >
                          20
                      ? tagHealthy(
                          'Alto en proteinas', Colors.green, Icons.done)
                      : const Text(''),
                  ((double.parse(widget.food.energia) /
                                  double.parse(widget.food.pesoNeto)) *
                              100) >=
                          275
                      ? tagHealthy('Alto en calorias', Colors.red, Icons.cancel)
                      : const Text('')
                ],
              ),
            ),
            // Botón para agregar al registro de calorías
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 32.0, vertical: 24.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () => _addToCaloriesLog(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: widget.food.color,
                    backgroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  icon: const Icon(FontAwesomeIcons.plus),
                  label: const Text(
                    'Agregar al registro',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  void _addToCaloriesLog(BuildContext context) {
    // Crear una entrada para el registro de alimentos
    final entry = FoodLogEntry(
      food: widget.food,
      quantity: multiplicador.toDouble(),
      timestamp: DateTime.now(),
      mealType: _selectedMealType,
    );

    // Agregar la entrada al proveedor
    Provider.of<FoodLogProvider>(context, listen: false).addFoodEntry(entry);

    // Cerrar el modal actual
    Navigator.pop(context);

    // Detectar la fuente de la navegación
    bool fromAddFoodEntryScreen = false;
    try {
      if (Navigator.canPop(context)) {
        final route = ModalRoute.of(context);
        if (route?.settings.name == 'AddFoodEntryScreen') {
          fromAddFoodEntryScreen = true;
        }
      }
    } catch (e) {
      // Ignorar errores de navegación
      print('Error al detectar pantalla: $e');
    }

    if (fromAddFoodEntryScreen) {
      // Si venimos de la pantalla de agregar alimento, navegar directamente
      // Primero cerramos todas las ventanas modales
      Navigator.of(context).popUntil((route) => route.isFirst);
      // Luego navegamos a HomeScreen con el índice 1 (CaloriesTrackerScreen)
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAll(() => const HomeScreen(), arguments: 1);
      });
    } else {
      // Si no, mostrar snackbar con opción de ver registro
      final snackBar = SnackBar(
        content: Text(
          '${widget.food.name} (${multiplicador}x) añadido a tu registro de $_selectedMealType',
        ),
        backgroundColor: widget.food.color,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Ver registro',
          textColor: Colors.white,
          onPressed: () {
            // Use WidgetsBinding to run this after the current frame
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Get.offAll(() => const HomeScreen(), arguments: 1);
            });
          },
        ),
      );

      // Show SnackBar safely after the frame is built
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      });
    }
  }

  Widget tagHealthy(String text, Color advertice, IconData icon) {
    return FilledButton(
      onPressed: () {
        showDialog(
            context: context,
            builder: (builder) {
              return Advertice(
                  color: advertice, title: text, content: 'content');
            });
      },
      style: TextButton.styleFrom(
        foregroundColor: Colors.white,
        backgroundColor: Colors.black.withAlpha(70),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: advertice,
            child: Icon(
              icon,
              size: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
    );
  }
}
