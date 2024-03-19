import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articles = [];
  Article? selectedArticle;

  void getArticles() async {
    notifyListeners();
  }
}
