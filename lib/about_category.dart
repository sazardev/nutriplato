import 'package:flutter/material.dart';
import 'package:nutriplato/data.dart';

class AboutCategory extends StatelessWidget {
  final int category;
  final Color color;

  const AboutCategory({
    super.key,
    required this.category,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      title: Text(
        categories[category],
        style: const TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
