import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/fitness_provider.dart';
import 'package:provider/provider.dart';

import '../../../../infrastructure/entities/fitness/fitness.dart';

class FinishedExerciseScreen extends StatelessWidget {
  const FinishedExerciseScreen({Key? key}) : super(key: key);

  static const appRouterName = "FinishedExerciseScreen";

  @override
  Widget build(BuildContext context) {
    final Fitness? fitness = context.watch<FitnessProvider>().selectedExercise;

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
              'Haz completado ${fitness?.name}',
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
