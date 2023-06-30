import 'package:flutter/material.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:provider/provider.dart';

import '../../../infrastructure/entities/article/article.dart';
import 'read_articles_screen.dart';

class ArticlesScreen extends StatelessWidget {
  const ArticlesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Article> articles = context.watch<ArticleProvider>().articles;

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
            children: List.generate(articles.length, (index) {
              final Article article = articles[index];
              return CardArticleScreen(article: article);
            }),
          ),
        ),
      ],
    );
  }
}

class CardArticleScreen extends StatelessWidget {
  const CardArticleScreen({
    super.key,
    required this.article,
  });

  final Article article;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 250,
      height: 300,
      child: Card(
        elevation: 0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [article.color, article.color.withAlpha(180)],
              stops: const [
                0.0,
                1.0,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(
                    left: 16, top: 16, bottom: 4, right: 16),
                child: Text(
                  article.title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16),
                child: Text(
                  article.description,
                  style: const TextStyle(
                      fontSize: 16, color: Color.fromARGB(225, 255, 255, 255)),
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16,
                  bottom: 16,
                ),
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    backgroundColor: article.color,
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                      return const ReadArticleScreen();
                    }));
                  },
                  child: const Text('Ver más'),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
