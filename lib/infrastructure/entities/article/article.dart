import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

class Article {
  String title;
  String description;
  String content;
  Color color;
  String? imageUrl;
  DateTime? publishDate;
  List<String> tags;
  List<ArticleSection> sections;

  Article({
    required this.title,
    required this.description,
    required this.content,
    this.color = Colors.purple,
    this.imageUrl,
    this.publishDate,
    this.tags = const [],
    this.sections = const [],
  });

  factory Article.fromJson(Map<dynamic, dynamic> json) {
    return Article(
      title: json['title'] ?? '',
      description: json['descripcion'] ?? '',
      content: json['contenido'] ?? '',
      color: Colors.purple,
      imageUrl: json['imageUrl'],
      publishDate: json['publishDate'] != null
          ? DateTime.parse(json['publishDate'])
          : null,
      tags: json['tags'] != null ? List<String>.from(json['tags']) : [],
      sections: json['sections'] != null
          ? List<ArticleSection>.from(
              json['sections'].map((x) => ArticleSection.fromJson(x)))
          : [],
    );
  }
}
