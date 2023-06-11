import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';

class ExampleHand extends StatelessWidget {
  const ExampleHand({super.key});

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        PageViewModel(
          title: 'Porción',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('lib/data/img/porciones_mano/palma.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'La palma de tu mano es el equivalente a una porcion de carne blanca o roja.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: 'Taza',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('lib/data/img/porciones_mano/taza.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Tu puño es igual a una taza, puede ser de cereales, verduras, frutas o cualquier alimento que quieras medir referente a una taza.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: 'Cuchara',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset('lib/data/img/porciones_mano/cuchara.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Es el equivalente a una cuchara, ya sea una cuchara de semillas, quesos, etc.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: 'Cucharadita',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child: Image.asset(
                      'lib/data/img/porciones_mano/cucharadita.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'La yema de tu dedo índice es igual a una cucharadita, puede ser de aceite, crema de cacahuate, etc.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: 'Taza',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                      Image.asset('lib/data/img/porciones_mano/mediataza.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'El puño de tu mano equivale a media taza, el cual puede ser representado por cualquier cosa que sea a una media taza.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
        ),
        PageViewModel(
          title: 'Dos tazas',
          bodyWidget: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Center(
                  child:
                      Image.asset('lib/data/img/porciones_mano/2_palmas.png'),
                ),
                const SizedBox(
                  height: 20,
                ),
                const Text(
                  'Para verduras, frutas o cereales, juntar tus dos palmas es el equivalente a dos tazas del alimento.',
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 24),
                )
              ],
            ),
          ),
          decoration: const PageDecoration(bodyAlignment: Alignment.center),
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
