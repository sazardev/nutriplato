import 'package:flutter/material.dart';

const String name = "Jacqueline Juarez";
const String developer = "Omar Flores";

final List<Color> sectionColors = [
  Colors.amber, // Cereales (22%)
  Colors.orange, // Leguminosas (15%)
  Colors.red, // Animal (8%)
  Colors.purple, // Grasas (5%)
  Color.fromARGB(255, 50, 147, 54), // Verduras & Frutas (50%)
];

List<String> shortCategories = [
  'Granos & Cereales',
  'Leguminosas',
  'Animal',
  'Grasas',
  'Verduras & Frutas',
];

List<String> categories = [
  'Granos & Cereales',
  'Leguminosas',
  'Alimentos de Origen Animal',
  'Grasas saludables',
  'Verduras & Frutas',
];

List<String> categoriesDescription = [
  'Los cereales son una opción saludable para incluir en una dieta equilibrada y su consumo puede ayudar a proporcionar energía y nutrientes esenciales para el cuerpo.',
  'Los alimentos de origen animal ofrecen diversos beneficios nutricionales. Son una fuente importante de proteínas de alta calidad que contienen una mayor variedad de aminoácidos esenciales 1. Estos aminoácidos son necesarios para el crecimiento y desarrollo de los niños, así como para la formación y reparación de tejidos en el cuerpo humano.',
  'Las leguminosas son una opción saludable para incluir en una dieta equilibrada y su consumo puede ayudar a reducir el riesgo de enfermedades relacionadas con la alimentación, como la diabetes tipo 2 y la obesidad.',
  'Las verduras son bajas en calorías y ricas en nutrientes esenciales para el buen funcionamiento del cuerpo humano. Su consumo puede ayudar a mejorar la digestión, prevenir enfermedades crónicas y mantener un peso saludable.',
  'Las frutas son bajas en calorías y ricas en nutrientes esenciales para el buen funcionamiento del cuerpo humano. Su consumo puede ayudar a mejorar la digestión, prevenir enfermedades crónicas y mantener un peso saludable.',
];

final List<IconData> sectionIcons = [
  Icons.fastfood,
  Icons.local_drink,
  Icons.directions_run,
  Icons.local_hospital,
  Icons.sentiment_satisfied_alt
];
