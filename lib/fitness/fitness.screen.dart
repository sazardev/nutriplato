import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/fitness/fitness.controller.dart';
import 'package:nutriplato/fitness/shared/fitness-popular.widget.dart';
import 'package:nutriplato/fitness/shared/simple-card.widget.dart';
import 'package:nutriplato/presentation/screens/screens.dart';

class FitnessScreen extends StatelessWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final listedExercises = Get.find<FitnessController>().listedExercises;

    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 238, 237, 237),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: constraints.maxWidth,
                  child: const PopularExercisesScreen(),
                ),
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Para principiantes',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      listedExercises.length,
                      (index) => SimpleCard(
                        title: listedExercises[index].name,
                        time:
                            '${listedExercises[index].exercises.length ~/ 2} minutos',
                        icon: listedExercises[index].icon,
                        onTap: () => Get.to(
                          () => ExerciseViewScreen(
                            selectedFitness: listedExercises[index],
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
