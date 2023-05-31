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
      appBar: AppBar(
        title: Text(widget.fitness.name),
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(children: [
        const Spacer(),
        Center(
          child: Text(
            widget.fitness.exercises[indexExercise].name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: Text(
              'x${widget.fitness.exercises[indexExercise].quantity}',
              style: const TextStyle(
                fontSize: 48,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 42, right: 42, bottom: 32),
          child: indexExercise < widget.fitness.exercises.length - 1
              ? FilledButton(
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
                  ),
                )
              : FilledButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Terminar',
                      style: TextStyle(fontSize: 18),
                    ),
                  ),
                ),
        )
      ]),
    );
  }
}
