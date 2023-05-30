import 'package:flutter/material.dart';

class Blog {
  String title;
  String description;
  String content;
  List<Color> gradientColors;
  Color buttonColor;
  String buttonText;
  List<String> foods = [];

  Blog({
    required this.title,
    required this.description,
    required this.content,
    required this.gradientColors,
    required this.buttonColor,
    required this.buttonText,
  });
}
