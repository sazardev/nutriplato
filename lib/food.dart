import 'package:flutter/material.dart';

class Food {
  String name;
  Image? image;
  String? description;
  double calories;
  double portions;

  Food({
    required this.name,
    this.image,
    this.description,
    required this.calories,
    required this.portions,
  });
}
