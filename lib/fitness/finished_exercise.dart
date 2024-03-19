import 'package:flutter/material.dart';
import 'package:nutriplato/fitness/fitness.model.dart';

class FinishedExerciseScreen extends StatelessWidget {
  const FinishedExerciseScreen({super.key, required this.selectedFitness});

  final Fitness selectedFitness;

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
              'Haz completado ${selectedFitness.name}',
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
