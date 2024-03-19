import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../home.screen.dart';

class PresentationScreen extends StatelessWidget {
  const PresentationScreen({super.key});

  static const appRouterName = "PresentationScreen";

  PageViewModel buildPageViewModel(String title, String body) {
    return PageViewModel(
      title: title,
      body: body,
      decoration: const PageDecoration(
        bodyAlignment: Alignment.center,
        titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
        bodyTextStyle: TextStyle(fontSize: 19.0),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return IntroductionScreen(
      pages: [
        buildPageViewModel("Noticias sobre alimentos",
            "Mantente informado sobre los últimos avances en nutrición y alimentación."),
        buildPageViewModel("Plato del bien comer",
            "Aprende cómo servir un plato adecuadamente siguiendo las recomendaciones del plato del bien comer de México."),
        buildPageViewModel("Buscador inteligente",
            "Encuentra información sobre más de 2000 alimentos con nuestro buscador inteligente."),
        buildPageViewModel(
          "Ejercicios para todos",
          "Encuentra ejercicios adaptados a tus necesidades y nivel de condición física.",
        ),
      ],
      onDone: () async {
        final prefs = await SharedPreferences.getInstance();
        prefs.setBool('presentation', false);

        // TODO: context.pushReplacementNamed('home');
      },
      onSkip: () {
        Navigator.of(context).push(
          MaterialPageRoute(builder: (_) => const HomeScreen()),
        );
      },
      next: const Icon(Icons.arrow_forward),
      done: const Icon(Icons.done),
      skip: const Text('Skip'),
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
