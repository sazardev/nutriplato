import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:nutriplato/data/leguminosas.dart';

import '../data/animals.dart';
import '../data/cereales.dart';
import '../data/frutas.dart';
import '../data/verduras.dart';

class ProportionFood extends StatefulWidget {
  final Color color;
  final int section;
  final int index;

  const ProportionFood({
    super.key,
    required this.color,
    required this.section,
    required this.index,
  });

  @override
  State<ProportionFood> createState() => _ProportionFoodState();
}

class _ProportionFoodState extends State<ProportionFood> {
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
    switch (widget.section) {
      case 0:
        list = leguminosas;
        break;
      case 1:
        list = animals;
        break;
      case 2:
        list = cereales;
        break;
      case 3:
        list = verduras;
        break;
      case 4:
        list = frutas;
        break;
    }

    controller = TextEditingController(text: '1');

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.color,
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
                '${list[widget.index].alimento}',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 30, color: Colors.white),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 32, right: 32, top: 8),
              child: Row(
                children: [
                  Text(
                    '${(int.parse(list[widget.index].energia) * multiplicador)} kcal',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(list[widget.index].proteina) * multiplicador).toStringAsFixed(1)} g',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(list[widget.index].hidratosDeCarbono) * multiplicador).toStringAsFixed(1)} g',
                    textAlign: TextAlign.center,
                    style: styleData,
                  ),
                  const Spacer(),
                  Text(
                    '${(double.parse(list[widget.index].lipidos) * multiplicador).toStringAsFixed(1)} g',
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
                    'Porcion',
                    style: styleData,
                  ),
                  IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Card(
                    elevation: 1,
                    color: widget.color.withAlpha(10),
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 10,
                        right: 10,
                        top: 8,
                        bottom: 8,
                      ),
                      child: Text(
                        multiplicador == 1
                            ? '${list[widget.index].cantidadSugerida} ${list[widget.index].unidad} (${list[widget.index].pesoNeto} g)'
                            : '(${int.parse(list[widget.index].pesoNeto) * multiplicador} g)',
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
                      onPressed: () {},
                      icon: const Icon(
                        Icons.info_outline,
                        size: 20,
                        color: Colors.white,
                      )),
                  const Spacer(),
                  Card(
                    elevation: 1,
                    color: widget.color.withAlpha(10),
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
                  ((double.parse(list[widget.index].proteina) * 4) /
                                  (double.parse(list[widget.index].energia))) *
                              100 >
                          20
                      ? tagHealthy(
                          'Alto en proteinas', Colors.green, Icons.done)
                      : const Text(''),
                  ((double.parse(list[widget.index].energia) /
                                  double.parse(list[widget.index].pesoNeto)) *
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
    return Chip(
      avatar: CircleAvatar(
        backgroundColor: advertice,
        child: Icon(
          icon,
          color: Colors.white,
          size: 15,
        ),
      ),
      label: Text(text),
      shape: const StadiumBorder(),
    );
  }
}
