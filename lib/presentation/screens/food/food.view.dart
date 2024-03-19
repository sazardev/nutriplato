import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriplato/data/food/leguminosas.dart';
import 'package:nutriplato/infrastructure/entities/food/food.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/example_hands_screen.dart';
import 'package:nutriplato/presentation/screens/plate/widgets/advertice_food.dart';

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
                            : '(${int.parse(widget.food.pesoNeto) * multiplicador} g)',
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
          ],
        ),
      ),
    );
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
