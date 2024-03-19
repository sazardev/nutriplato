import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/exercise/exercise.start.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/fitness/shared/gradient-card.widget.dart';

class PopularExercisesScreen extends StatelessWidget {
  const PopularExercisesScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final listedExercises = Get.find<FitnessController>().listedExercises;

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
            children: List.generate(
              3,
              (index) => GradientCard(
                title: listedExercises[index].name,
                description: listedExercises[index].description,
                icon: listedExercises[index].icon,
                onTap: () => Get.to(
                  () => ExerciseViewScreen(
                    selectedFitness: listedExercises[index],
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
