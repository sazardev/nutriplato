import 'package:flutter/material.dart';
import 'package:nutriplato/widgets/display_exercise.dart';

import '../../models/fitness.dart';

class RecommendedCard extends StatelessWidget {
  final Fitness fitness;
  const RecommendedCard({super.key, required this.fitness});

  @override
  Widget build(BuildContext context) {
    return Card(
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
                  Navigator.push(context, MaterialPageRoute(builder: (builder) {
                    return DisplayExercise(
                      fitness: fitness,
                    );
                  }));
                },
                child: const Text('Ver ejercicio'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
