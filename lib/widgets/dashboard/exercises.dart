import 'package:flutter/material.dart';

import '../../data/fitness/exercises.dart';
import '../fitness/recommended_card.dart';

class ExercisesNews extends StatelessWidget {
  const ExercisesNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Ejercicios destacados',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(3, (index) {
              return SizedBox(
                  width: 300,
                  height: 200,
                  child: RecommendedCard(fitness: fitness[index]));
            }),
          ),
        ),
      ],
    );
  }
}
