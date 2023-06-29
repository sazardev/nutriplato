import 'package:flutter/material.dart';
import 'package:nutriplato/domain/article/article.dart';
import 'package:nutriplato/presentation/screens/dashboard/widgets/view_article.dart';

class FocusCard extends StatelessWidget {
  final Article article;

  const FocusCard({
    super.key,
    required this.article,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [article.color, article.color],
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
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return const ViewArticle();
                  }));
                },
                child: const Text('Ver más'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
