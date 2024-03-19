import 'package:flutter/material.dart';

class Exercise {
  String name;
  String description;
  int quantity;
  int time;
  List<Image> images;

  Exercise({
    required this.name,
    required this.description,
    this.quantity = 0,
    required this.images,
    this.time = 0,
  });
}
