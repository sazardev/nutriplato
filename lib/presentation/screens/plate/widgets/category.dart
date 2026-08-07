import 'package:flutter/material.dart';
import 'package:nutriplato/data/data.dart';

class AboutCategory extends StatelessWidget {
  final int category;
  final Color color;

  const AboutCategory({super.key, required this.category, required this.color});

  @override
  Widget build(BuildContext context) {
    final textColor = color.computeLuminance() > 0.3
        ? Colors.black87
        : Colors.white;
    return AlertDialog(
      backgroundColor: color,
      title: Text(categories[category], style: TextStyle(color: textColor)),
      content: Text(
        categoriesDescription[category],
        style: TextStyle(color: textColor),
      ),
    );
  }
}
