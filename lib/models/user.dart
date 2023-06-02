import 'package:flutter/material.dart';

class User {
  String username;
  String name;
  String lastname;
  int age;
  int exercisesCompleted;
  int viewedFoods;
  int blogsReaded;
  Image? image;

  User({
    required this.username,
    this.name = "default",
    this.lastname = "",
    this.age = 0,
    this.image,
    this.exercisesCompleted = 0,
    this.viewedFoods = 0,
    this.blogsReaded = 0,
  });
}
