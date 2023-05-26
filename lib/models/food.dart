import 'package:flutter/material.dart';

class Food {
  String name;
  Image? image;
  String? description;

  Food({
    required this.name,
    this.image,
    this.description,
  });
}
