import 'package:flutter/material.dart';

class User {
  String username;
  String name;
  String lastname;
  int age;
  Image? image;

  User({
    required this.username,
    this.name = "default",
    this.lastname = "",
    this.age = 0,
    this.image,
  });
}
