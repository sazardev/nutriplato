import 'package:flutter/material.dart';

import '../../models/fitness.dart';

class FinishedExercise extends StatefulWidget {
  final Fitness fitness;

  const FinishedExercise({Key? key, required this.fitness}) : super(key: key);

  @override
  State<FinishedExercise> createState() => _FinishedExercise();
}

class _FinishedExercise extends State<FinishedExercise> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple,
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Center(
              child: Text(
                '¡Felicidades!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 56,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              'Haz completado ${widget.fitness.name}',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white.withAlpha(200),
                fontSize: 28,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            FilledButton(
                style: TextButton.styleFrom(
                  backgroundColor: Colors.white.withAlpha(100),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  'Completar',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
