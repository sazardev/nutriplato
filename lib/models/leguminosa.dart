import 'food.dart';

class Leguminosa extends Food {
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
  String hierro;
  String selenio;
  String fosforo;
  String potasio;
  String azucarEquivalente;
  String indiceGlicemico;
  String cargaGlicemica;

  Leguminosa({
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
    required this.hierro,
    required this.selenio,
    required this.fosforo,
    required this.potasio,
    required this.azucarEquivalente,
    required this.indiceGlicemico,
    required this.cargaGlicemica,
  }) : super(name: alimento);
}
