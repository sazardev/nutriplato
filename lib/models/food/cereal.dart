import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/data.dart';
import 'food.dart';

class Cereal extends Food {
  String alimento;
  String cantidadSugerida;
  String unidad;
  String pesoRedondeado;
  String pesoNeto;
  String energia;
  String proteina;
  String lipidos;
  String hidratosDeCarbono;
  String fibra;
  String acidoFolico;
  String calcio;
  String hierro;
  String sodio;
  String azucarEquivalente;
  String indiceGlicemico;
  String cargaGlicemica;
  Image? image;
  String? description;

  Cereal({
    required this.alimento,
    required this.cantidadSugerida,
    required this.unidad,
    required this.pesoRedondeado,
    required this.pesoNeto,
    required this.energia,
    required this.proteina,
    required this.lipidos,
    required this.hidratosDeCarbono,
    required this.fibra,
    required this.acidoFolico,
    required this.calcio,
    required this.hierro,
    required this.sodio,
    required this.azucarEquivalente,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
    this.image,
    this.description,
  }) : super(
          name: alimento,
          category: 'cereal',
          icon: const Icon(FontAwesomeIcons.wheatAwn),
          color: sectionColors[0],
          cantidadSugerida: cantidadSugerida,
          unidad: unidad,
          image: image,
          description: description,
          pesoRedondeado: pesoRedondeado,
          pesoNeto: pesoNeto,
          energia: energia,
          proteina: proteina,
          lipidos: lipidos,
          hidratosDeCarbono: hidratosDeCarbono,
        );
}
