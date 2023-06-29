import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:provider/provider.dart';

import 'focus_card.dart';

class Articles extends StatelessWidget {
  const Articles({super.key});

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
                child: FocusCard(
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
