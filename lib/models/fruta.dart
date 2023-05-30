import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../data/data.dart';
import 'food.dart';

class Fruta extends Food {
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
  String vitaminaA;
  String acidoAscorbico;
  String acidoFolico;
  String hierro;
  String potasio;
  String indiceGlicemico;
  String cargaGlicemica;

  Fruta({
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
    required this.vitaminaA,
    required this.acidoAscorbico,
    required this.acidoFolico,
    required this.hierro,
    required this.potasio,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
  }) : super(
          name: alimento,
          category: 'fruta',
          icon: const Icon(FontAwesomeIcons.appleWhole),
          color: sectionColors[4],
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
