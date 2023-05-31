import 'package:flutter/material.dart';
import 'package:nutriplato/models/blog.dart';

List<Blog> blogs = [
  Blog(
    title: 'Beneficios de una dieta rica en proteínas',
    description:
        'Aprende cómo las proteínas pueden mejorar tu salud y bienestar.',
    content: '''
Las proteínas son uno de los tres macronutrientes esenciales en nuestra dieta, junto con los carbohidratos y las grasas. Las proteínas son los bloques de construcción del cuerpo humano y son necesarias para el crecimiento celular y la realización de los procesos metabólicos .

Una dieta equilibrada requiere una ingesta suficiente de proteínas y ofrece numerosos beneficios. Una dieta rica en proteínas puede ayudar a la pérdida de peso, permitir la ganancia muscular y mejorar la composición corporal, así como la salud metabólica . Por el contrario, una deficiencia en la dieta conduce a la atrofia muscular y al deterioro del funcionamiento del organismo en general .

Hay muchos alimentos ricos en proteínas que podemos incluir en nuestra dieta para mejorar nuestra salud general. Algunos ejemplos son: pechuga de pollo, huevos, requesón, yogur griego, leche, lentejas y alubias negras . Estos alimentos no solo son ricos en proteínas, sino que también proporcionan otros nutrientes esenciales para mantenerse en un buen estado de salud.

Es importante tener en cuenta que no todas las fuentes de proteína son iguales. Algunas dietas altas en proteínas permiten el consumo de carne roja y carnes procesadas que son ricas en grasas saturadas. Estos alimentos pueden aumentar el riesgo de sufrir enfermedades cardíacas . Por lo tanto, es importante elegir fuentes de proteína saludables como las mencionadas anteriormente.

En resumen, una dieta rica en proteínas ofrece muchos beneficios para nuestra salud y bienestar. Al incluir alimentos ricos en proteínas en nuestra dieta diaria, podemos mejorar nuestra composición corporal, aumentar nuestra masa muscular y mejorar nuestra salud metabólica.
''',
    gradientColors: [
      Colors.red.shade400,
      Colors.pink.shade400,
    ],
    buttonColor: Colors.pink,
    buttonText: 'Ver más',
  ),
  Blog(
    title: 'Grasas malas y buenas',
    description:
        'Descubre cómo elegir grasas saludables y mejorar tu bienestar.',
    content: '''
La grasa es una parte importante de nuestra dieta, pero no todas las grasas son iguales. Hay grasas saludables y grasas no saludables, y es importante saber elegir las fuentes de grasa adecuadas para mantener una dieta equilibrada y saludable.

Los alimentos bajos en grasas pueden ser beneficiosos para nuestra salud ya que pueden ayudar a reducir el riesgo de enfermedades cardiovasculares y controlar los niveles de colesterol. Algunos ejemplos de alimentos bajos en grasas son las verduras verdes, frutas, legumbres y champiñones. Estos alimentos no solo son bajos en grasas, sino que también proporcionan otros nutrientes esenciales para mantenerse en un buen estado de salud.

Por otro lado, los alimentos altos en grasas saturadas, como las carnes rojas y los productos lácteos, pueden aumentar el riesgo de enfermedades cardíacas. Las grasas saturadas pueden acumularse rápidamente en los alimentos que combinan ingredientes, como los sándwiches, las hamburguesas y los tacos. Por lo tanto, es importante limitar el consumo de grasas saturadas y elegir fuentes de grasas saludables.

En resumen, consumir alimentos bajos en grasas puede ofrecer muchos beneficios para nuestra salud y bienestar. Al elegir fuentes de grasas saludables y limitar el consumo de grasas saturadas, podemos mejorar nuestra salud cardiovascular y reducir el riesgo de enfermedades.
''',
    gradientColors: [
      Colors.deepOrange.shade600,
      Colors.amber.shade600,
    ],
    buttonColor: Colors.orange,
    buttonText: 'Ver más',
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
    buttonText: 'Ver más',
  ),
];
