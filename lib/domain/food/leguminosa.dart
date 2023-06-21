import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/data.dart';
import 'food.dart';

class Leguminosa extends Food {
  String alimento;
  String fibra;
  String hierro;
  String selenio;
  String fosforo;
  String potasio;
  String azucarEquivalente;
  String indiceGlicemico;
  String cargaGlicemica;

  Leguminosa({
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
    required this.hierro,
    required this.selenio,
    required this.fosforo,
    required this.potasio,
    required this.azucarEquivalente,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
    super.image,
  }) : super(
          name: alimento,
          category: 'leguminosa',
          icon: const Icon(FontAwesomeIcons.seedling),
          color: sectionColors[2],
        );
}
