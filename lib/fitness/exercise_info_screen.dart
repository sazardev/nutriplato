import 'package:flutter/material.dart';
import 'package:nutriplato/fitness/fitness.model.dart';

class ExerciseInfoScreen extends StatelessWidget {
  final Fitness fitness;

  const ExerciseInfoScreen({
    super.key,
    required this.fitness,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(fitness.name),
      content: Text(fitness.description),
    );
  }
}
