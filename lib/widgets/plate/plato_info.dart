import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';

class Plato extends StatelessWidget {
  const Plato({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Plato del Buen Comer',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                    'lib/data/img/plato.png',
                    width: 350,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Es una guía visual que muestra cómo combinar alimentos para tener una dieta balanceada. Cada sección representa un grupo de alimentos que deben ser consumidos en proporciones adecuadas.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                  ),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          titleWidget: const Text(
            'Alimentos de Origen Animal',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
            ),
          ),
          bodyWidget: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.cow,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Incluye alimentos como carne, pescado, pollo, huevos y productos lácteos. Estos alimentos son una fuente importante de proteínas y otros nutrientes esenciales para el cuerpo.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(
            bodyAlignment: Alignment.center,
            pageColor: Colors.red,
          ),
        ),
        PageViewModel(
          titleWidget: const Text(
            'Leguminosas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
            ),
          ),
          bodyWidget: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.seedling,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Son alimentos ricos en nutrientes y ofrecen muchos beneficios a la salud. Ejemplos de leguminosas son lentejas, garbanzos, frijoles, habichuelas, judías, arvejas, habas, soja y cacahuete.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: PageDecoration(
            bodyAlignment: Alignment.center,
            pageColor: Colors.orange.shade700,
          ),
        ),
        PageViewModel(
          titleWidget: const Text(
            'Frutas',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
            ),
          ),
          bodyWidget: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.appleWhole,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Son fuente de vitaminas, minerales y fibra que ayudan al buen funcionamiento del cuerpo humano. Algunas frutas que puedes encontrar en este grupo son: guanábana, manzana, plátano, limón, guayaba, papaya, mango, mandarina y sandía.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(
            bodyAlignment: Alignment.center,
            pageColor: Colors.green,
          ),
        ),
        PageViewModel(
          titleWidget: const Text(
            'Verduras',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
            ),
          ),
          bodyWidget: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.carrot,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'Proporcionan vitaminas, minerales y fibra que son importantes para el funcionamiento adecuado del cuerpo humano. Algunas verduras que puedes encontrar en este grupo son: pepino, calabaza, pimiento morrón, nopal, brócoli, chayote, betabel, chile poblano y zanahoria.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: PageDecoration(
            bodyAlignment: Alignment.center,
            pageColor: Colors.green.shade800,
          ),
        ),
        PageViewModel(
          titleWidget: const Text(
            'Cereales',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 38,
              color: Colors.white,
            ),
          ),
          bodyWidget: const SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  FontAwesomeIcons.wheatAwn,
                  size: 150,
                  color: Colors.white,
                ),
                SizedBox(
                  height: 20,
                ),
                Text(
                  ' Son una fuente principal de energía que el organismo necesita para realizar actividades diarias y también son fuente importante de fibra cuando se consumen enteros. Los cereales más comunes que se incluyen en el plato del buen comer son el arroz, el maíz, el trigo, la cebada, el amaranto, la avena y el centeno.',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 24,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          decoration: PageDecoration(
            bodyAlignment: Alignment.center,
            pageColor: Colors.yellow.shade800,
          ),
        ),
      ],
      onDone: () async {
        Navigator.of(context).pop();
      },
      onSkip: () {
        Navigator.pop(context);
      },
      next: const Icon(Icons.arrow_forward),
      done: const Icon(Icons.done),
      skip: const Text('Cerrar'),
      showSkipButton: true,
      showDoneButton: true,
      nextFlex: 0,
      dotsDecorator: DotsDecorator(
        size: const Size.square(10.0),
        activeSize: const Size(20.0, 10.0),
        activeColor: Colors.purple,
        color: Colors.black26,
        spacing: const EdgeInsets.symmetric(horizontal: 3.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25.0),
        ),
      ),
    );
  }
}
