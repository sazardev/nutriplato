import 'package:flutter/material.dart';

import '../../models/fitness.dart';
import '../display_exercise.dart';

class ExerciseCard extends StatelessWidget {
  final Fitness fitness;

  const ExerciseCard({super.key, required this.fitness});

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
            Navigator.push(context, MaterialPageRoute(builder: (builder) {
              return DisplayExercise(
                fitness: fitness,
              );
            }));
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
