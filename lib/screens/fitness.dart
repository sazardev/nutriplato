import 'package:flutter/material.dart';
import 'package:nutriplato/data/fitness/exercises.dart';
import 'package:nutriplato/widgets/dashboard/fitness/exercise_card.dart';
import 'package:nutriplato/widgets/dashboard/fitness/recommended_card.dart';

class Fitness extends StatefulWidget {
  const Fitness({super.key});

  @override
  State<Fitness> createState() => _FitnessState();
}

class _FitnessState extends State<Fitness> {
  @override
  Widget build(BuildContext context) {
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
                height: 220,
                child: RecommendedCard(
                  fitness: fitness[1],
                ),
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
                  children: List.generate(fitness.length, (index) {
                    return ExerciseCard(fitness: fitness[index]);
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
