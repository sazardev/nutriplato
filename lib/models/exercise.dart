import 'package:flutter/material.dart';

class Exercise {
  String name;
  String description;
  int quantity;
  List<Image> images;

  Exercise({
    required this.name,
    required this.description,
    required this.quantity,
    required this.images,
  });
}
