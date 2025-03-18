import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/screens/article_detail_screen.dart';
import 'package:nutriplato/presentation/screens/article_list_screen.dart';
import 'package:nutriplato/presentation/screens/widgets/article_card.dart';
import 'package:provider/provider.dart';

class FeaturedArticlesWidget extends StatelessWidget {
  const FeaturedArticlesWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final articleProvider = context.watch<ArticleProvider>();
    final articles = articleProvider.articles;

    if (articleProvider.isLoading) {
      return const SizedBox(
        height: 200,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (articles.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header with reduced padding
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Artículos destacados',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              TextButton(
                onPressed: () => Get.to(() => const ArticleListScreen()),
                child: const Text('Ver todos'),
              ),
            ],
          ),
        ),

        // Wrap the list in Expanded to use remaining space
        Expanded(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: articles.length > 5 ? 5 : articles.length,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemBuilder: (context, index) {
              final article = articles[index];
              return ArticleCard(
                article: article,
                onTap: () {
                  articleProvider.setSelectedArticle(article);
                  Get.to(() => const ArticleDetailScreen());
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
