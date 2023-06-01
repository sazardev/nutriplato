import 'package:flutter/material.dart';

import '../../models/fitness.dart';
import '../../screens/exercise.dart';

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
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Icon(
                  fitness.icon,
                  color: Colors.white,
                  size: 30,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fitness.name,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  fitness.description,
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 32.0),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                      backgroundColor: Colors.pink.shade900),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (builder) {
                      return ExerciseState(
                        fitness: fitness,
                      );
                    }));
                  },
                  child: const Text('Comenzar ejercicio'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
