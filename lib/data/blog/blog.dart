import 'package:flutter/material.dart';
import 'package:nutriplato/models/blog.dart';

List<Blog> blogs = [
  Blog(
    title: 'Alto en proteinas',
    description: 'Mejora tu fuerza y energia.',
    content: 'content',
    gradientColors: [
      Colors.deepPurple.shade400,
      Colors.purple.shade400,
    ],
    buttonColor: Colors.purple,
    buttonText: 'Ver alimentos',
  ),
  Blog(
    title: 'Bajo en grasas',
    description: 'Reduce las grasas.',
    content: 'content',
    gradientColors: [
      Colors.deepOrange.shade600,
      Colors.amber.shade600,
    ],
    buttonColor: Colors.orange,
    buttonText: 'Ver alimentos',
  ),
];
