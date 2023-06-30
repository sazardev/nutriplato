import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nutriplato/presentation/provider/fitness_provider.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/entities/fitness/fitness.dart';
import 'widgets/display_exercise_screen.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  static const appRouterName = "FitnessScreen";

  @override
  Widget build(BuildContext context) {
    final listedExercises = context.watch<FitnessProvider>().listedExercises;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Recomendado para ti',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(
                width: constraints.maxWidth,
                child: const PopularExercisesScreen(),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Para principiantes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: List.generate(listedExercises.length, (index) {
                    final Fitness fitness = listedExercises[index];

                    return CardExerciseScreen(fitness: fitness);
                  }),
                ),
              )
            ]),
          ),
        ),
      );
    });
  }
}

class PopularExercisesScreen extends StatelessWidget {
  const PopularExercisesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<Fitness> listFitness =
        context.watch<FitnessProvider>().listedExercises;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ejercicios destacados',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(3, (index) {
              final Fitness fitness = listFitness[index];

              return SizedBox(
                width: 220,
                height: 300,
                child: Card(
                  elevation: 0,
                  clipBehavior: Clip.antiAlias,
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.purple,
                          Colors.pink,
                        ],
                        stops: [
                          0.0,
                          1.0,
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            fitness.icon,
                            color: Colors.white,
                            size: 30,
                          ),
                          Text(
                            fitness.name,
                            style: const TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            fitness.description,
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                          const Spacer(),
                          FilledButton(
                            style: FilledButton.styleFrom(
                                backgroundColor: Colors.pink.shade900),
                            onPressed: () {
                              context.read<FitnessProvider>().selectedExercise =
                                  fitness;
                              context.pushNamed(
                                  DisplayExerciseScreen.appRouterName);
                            },
                            child: const Text('Ver ejercicio'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}

class CardExerciseScreen extends StatelessWidget {
  const CardExerciseScreen({
    super.key,
    required this.fitness,
  });

  final Fitness fitness;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 150,
      child: Card(
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: () {
            context.read<FitnessProvider>().selectedExercise = fitness;
            context.pushNamed(DisplayExerciseScreen.appRouterName);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: Icon(fitness.icon),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  top: 8,
                ),
                child: Text(
                  fitness.name,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5),
                child: Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(
                      width: 10,
                    ),
                    Text('${fitness.exercises.length ~/ 2} minutos'),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
