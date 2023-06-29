import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:provider/provider.dart';

import 'focus_card_screen.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text(
            'Articulos interesantes',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(
                context.watch<ArticleProvider>().articles.length, (index) {
              return SizedBox(
                width: 250,
                height: 300,
                child: FocusCardScreen(
                  article: context.watch<ArticleProvider>().articles[index],
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
