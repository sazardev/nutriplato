import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/data/data.dart';

import 'food.dart';

class Animal extends Food {
  String alimento;
  String colesterol;
  String vitaminaA;
  String calcio;
  String hierro;
  String sodio;
  String selenio;

  Animal({
    required this.alimento,
    required super.cantidadSugerida,
    required super.unidad,
    required super.pesoRedondeado,
    required super.pesoNeto,
    required super.energia,
    required super.proteina,
    required super.lipidos,
    required super.hidratosDeCarbono,
    required this.colesterol,
    required this.vitaminaA,
    required this.calcio,
    required this.hierro,
    required this.sodio,
    required this.selenio,
    super.image,
  }) : super(
          name: alimento,
          category: 'animal',
          icon: const Icon(FontAwesomeIcons.cow),
          color: sectionColors[1],
        );
}
