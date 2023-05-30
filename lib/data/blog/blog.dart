import 'package:flutter/material.dart';
import 'package:nutriplato/models/blog.dart';

List<Blog> blogs = [
  Blog(
    title: 'Alto en proteinas',
    description: 'Mejora tu fuerza y energia.',
    content: 'content',
    gradientColors: [
      Colors.deepPurple.shade400,
      Colors.purple.shade400,
    ],
    buttonColor: Colors.purple,
    buttonText: 'Ver alimentos',
  ),
  Blog(
    title: 'Bajo en grasas',
    description: 'Reduce las grasas.',
    content: 'content',
    gradientColors: [
      Colors.deepOrange.shade600,
      Colors.amber.shade600,
    ],
    buttonColor: Colors.orange,
    buttonText: 'Ver alimentos',
  ),
  Blog(
    title: 'Las 5 verduras más saludables para incluir en tu dieta',
    description: 'Descubre las 5 verduras más nutritivas.',
    content: '''
Según el portal médico anglosajón Medical News Today, las 5 verduras más saludables que puedes comer son: espinacas, kale, brócoli, guisantes y boniato1. Estas verduras son ricas en vitaminas, minerales y fibra y tienen beneficios especiales para la salud.
            
Las espinacas son una gran fuente de calcio, vitaminas, hierro y antioxidantes. Debido a su contenido en calcio y hierro, son muy recomendables para las dietas sin carne o sin lácteos1. El kale tiene vitamina A, C y K y ayuda a controlar el colesterol malo y la hipertensión1. El brócoli contiene todas las necesidades diarias de vitamina K y dos veces la cantidad de vitamina C que se aconseja diariamente1. Los guisantes contienen fibra, proteína, vitaminas A, C y K y algunas del grupo B, con muy pocas calorías1. El boniato tiene potasio, vitamina C, betacaroteno y vitamina A1.
            
Incluir estas verduras en tu dieta diaria puede ayudarte a mejorar tu salud y bienestar. ¡No dudes en incorporarlas en tus comidas!
              ''',
    gradientColors: [
      Colors.indigo,
      Colors.cyan,
    ],
    buttonColor: Colors.cyan,
    buttonText: 'Ver mas',
  ),
];
