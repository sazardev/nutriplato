import 'package:flutter/material.dart';

import 'food.dart';
import 'micronutrients.dart';

/// Alimento con información nutricional estándar (micronutrientes + IG).
///
/// Usado por categorías fuera del Plato del Bien Comer:
/// grasas, bebidas, lácteos, azúcares, botanas y condimentos.
class NutriFood extends Food {
  final String alimento;
  final String fibra;
  final String sodio;
  final String calcio;
  final String hierro;
  final String potasio;
  final String azucarEquivalente;
  final String indiceGlicemico;
  final String cargaGlicemica;

  NutriFood({
    required this.alimento,
    required super.category,
    required IconData categoryIcon,
    required Color categoryColor,
    required super.cantidadSugerida,
    required super.unidad,
    required super.pesoRedondeado,
    required super.pesoNeto,
    required super.energia,
    required super.proteina,
    required super.lipidos,
    required super.hidratosDeCarbono,
    this.fibra = 'ND',
    this.sodio = 'ND',
    this.calcio = 'ND',
    this.hierro = 'ND',
    this.potasio = 'ND',
    this.azucarEquivalente = 'ND',
    this.indiceGlicemico = 'ND',
    this.cargaGlicemica = 'ND',
    super.image,
  }) : super(
         name: alimento,
         icon: Icon(categoryIcon),
         color: categoryColor,
         micros: Micronutrients(
           fibra: fibra,
           sodio: sodio,
           calcio: calcio,
           hierro: hierro,
           potasio: potasio,
           azucarEquivalente: azucarEquivalente,
           indiceGlicemico: indiceGlicemico,
           cargaGlicemica: cargaGlicemica,
         ),
       );
}
