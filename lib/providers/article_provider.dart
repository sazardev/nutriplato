import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

import '../models/article.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articles = [];

  void getArticles() async {
    DatabaseReference itemRef =
        FirebaseDatabase.instance.ref().child('noticias');

    itemRef.once().then((DatabaseEvent event) {
      if (event.snapshot.value is Map) {
        Map<dynamic, dynamic> values =
            event.snapshot.value as Map<dynamic, dynamic>;

        values.forEach((key, value) {
          articles.add(Article.fromJson(values));
        });
      }
    });

    notifyListeners();
  }
}
