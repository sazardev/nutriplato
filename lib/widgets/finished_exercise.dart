import 'package:flutter/material.dart';
import 'package:nutriplato/models/fitness.dart';

class FinishedExercise extends StatelessWidget {
  final Fitness fitness;

  const FinishedExercise({
    super.key,
    required this.fitness,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          FilledButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Completar'))
        ],
      ),
    );
  }
}
