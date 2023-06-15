import 'package:flutter/material.dart';

class Article {
  String title;
  String description;
  String content;
  Color color;

  Article({
    required this.title,
    required this.description,
    required this.content,
    this.color = Colors.purple,
  });

  factory Article.fromJson(Map<dynamic, dynamic> json) {
    return Article(
      title: json['title'],
      description: json['description'],
      content: json['content'],
      color: Colors.purple,
    );
  }
}
