import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/data.dart';
import 'food.dart';

class Cereal extends Food {
  String alimento;
  String fibra;
  String acidoFolico;
  String calcio;
  String hierro;
  String sodio;
  String azucarEquivalente;
  String indiceGlicemico;
  String cargaGlicemica;

  Cereal({
    required this.alimento,
    required super.cantidadSugerida,
    required super.unidad,
    required super.pesoRedondeado,
    required super.pesoNeto,
    required super.energia,
    required super.proteina,
    required super.lipidos,
    required super.hidratosDeCarbono,
    required this.fibra,
    required this.acidoFolico,
    required this.calcio,
    required this.hierro,
    required this.sodio,
    required this.azucarEquivalente,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
    super.image,
    super.description,
  }) : super(
          name: alimento,
          category: 'cereal',
          icon: const Icon(FontAwesomeIcons.wheatAwn),
          color: sectionColors[0],
        );
}
