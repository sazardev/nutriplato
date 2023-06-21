import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../data/data.dart';
import 'food.dart';

class Fruta extends Food {
  String alimento;
  String fibra;
  String vitaminaA;
  String acidoAscorbico;
  String acidoFolico;
  String hierro;
  String potasio;
  String indiceGlicemico;
  String cargaGlicemica;

  Fruta({
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
    required this.vitaminaA,
    required this.acidoAscorbico,
    required this.acidoFolico,
    required this.hierro,
    required this.potasio,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
    super.image,
  }) : super(
          name: alimento,
          category: 'fruta',
          icon: const Icon(FontAwesomeIcons.appleWhole),
          color: sectionColors[4],
        );
}
