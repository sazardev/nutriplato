import 'package:get/get.dart';
import 'package:nutriplato/fitness/fitness.data.dart';
import 'package:nutriplato/fitness/fitness.model.dart';

class FitnessController extends GetxController {
  Rx<Fitness?> selectedExercise = Rx<Fitness?>(null);
  var listedExercises = <Fitness>[].obs;

  @override
  void onInit() {
    super.onInit();
    listedExercises.addAll(exercisesData);
  }
}
