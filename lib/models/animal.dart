import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/data/data.dart';

import 'food.dart';

class Animal extends Food {
  String alimento;
  String cantidadSugerida;
  String unidad;
  String pesoRedondeado;
  String pesoNeto;
  String energia;
  String proteina;
  String lipidos;
  String hidratosDeCarbono;
  String colesterol;
  String vitaminaA;
  String calcio;
  String hierro;
  String sodio;
  String selenio;

  Animal({
    required this.alimento,
    required this.cantidadSugerida,
    required this.unidad,
    required this.pesoRedondeado,
    required this.pesoNeto,
    required this.energia,
    required this.proteina,
    required this.lipidos,
    required this.hidratosDeCarbono,
    required this.colesterol,
    required this.vitaminaA,
    required this.calcio,
    required this.hierro,
    required this.sodio,
    required this.selenio,
  }) : super(
          name: alimento,
          category: 'animal',
          icon: const Icon(FontAwesomeIcons.cow),
          color: sectionColors[1],
          cantidadSugerida: cantidadSugerida,
          unidad: unidad,
          pesoRedondeado: pesoRedondeado,
          pesoNeto: pesoNeto,
          energia: energia,
          proteina: proteina,
          lipidos: lipidos,
          hidratosDeCarbono: hidratosDeCarbono,
        );
}
