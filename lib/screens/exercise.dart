import 'package:flutter/material.dart';
import 'package:nutriplato/models/fitness.dart';

class ExerciseState extends StatefulWidget {
  final Fitness fitness;
  const ExerciseState({
    super.key,
    required this.fitness,
  });

  @override
  State<ExerciseState> createState() => _ExerciseState();
}

class _ExerciseState extends State<ExerciseState> {
  int indexExercise = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: ListView(children: [
        Center(
          child: Text(
            widget.fitness.exercises[indexExercise].name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'x${widget.fitness.exercises[indexExercise].quantity}',
              style: const TextStyle(
                fontSize: 42,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 42, right: 42),
          child: FilledButton(
              onPressed: () {
                setState(() {
                  indexExercise += 1;
                });
              },
              child: const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  'Siguiente',
                  style: TextStyle(fontSize: 18),
                ),
              )),
        )
      ]),
    );
  }
}
