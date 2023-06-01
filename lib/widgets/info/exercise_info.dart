import 'package:flutter/material.dart';

import '../../models/fitness.dart';

class Exercise extends StatelessWidget {
  final Fitness fitness;

  const Exercise({
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
