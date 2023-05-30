import 'package:flutter/material.dart';

class Food {
  String name;
  String category;
  Icon icon;
  Color color;
  String cantidadSugerida;
  String unidad;
  String pesoRedondeado;
  String pesoNeto;
  String energia;
  String proteina;
  String lipidos;
  String hidratosDeCarbono;

  Image? image;
  String? description;

  Food({
    required this.name,
    required this.category,
    required this.icon,
    required this.color,
    required this.cantidadSugerida,
    required this.unidad,
    required this.pesoRedondeado,
    required this.pesoNeto,
    required this.energia,
    required this.proteina,
    required this.lipidos,
    required this.hidratosDeCarbono,
    this.image,
    this.description,
  });
}
