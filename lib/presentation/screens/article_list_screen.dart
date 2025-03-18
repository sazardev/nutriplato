import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/screens/article_detail_screen.dart';
import 'package:provider/provider.dart';

class ArticleListScreen extends StatefulWidget {
  const ArticleListScreen({super.key});

  @override
  State<ArticleListScreen> createState() => _ArticleListScreenState();
}

class _ArticleListScreenState extends State<ArticleListScreen> {
  String _activeFilter = "Todos";
  final List<String> _allTags = ["Todos"];

  @override
  void initState() {
    super.initState();
    // Extraer todas las etiquetas únicas de los artículos
    Future.delayed(Duration.zero, () {
      final allArticles = context.read<ArticleProvider>().articles;
      final tags = <String>{};
      for (var article in allArticles) {
        tags.addAll(article.tags);
      }
      setState(() {
        _allTags.addAll(tags);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final articleProvider = context.watch<ArticleProvider>();
    final allArticles = articleProvider.articles;

    // Filtrar artículos según la etiqueta seleccionada
    final List<Article> filteredArticles = _activeFilter == "Todos"
        ? allArticles
        : allArticles
            .where((article) => article.tags.contains(_activeFilter))
            .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Artículos"),
        elevation: 0,
      ),
      body: Column(
        children: [
          // Filtros de categorías
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Row(
                children: _allTags.map((tag) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: FilterChip(
                      selected: _activeFilter == tag,
                      label: Text(tag),
                      onSelected: (selected) {
                        setState(() {
                          _activeFilter = tag;
                        });
                      },
                      selectedColor: Colors.purple.withOpacity(0.2),
                      checkmarkColor: Colors.purple,
                    ),
                  );
                }).toList(),
              ),
            ),
          ),

          // Lista de artículos
          Expanded(
            child: articleProvider.isLoading
                ? const Center(child: CircularProgressIndicator())
                : filteredArticles.isEmpty
                    ? const Center(child: Text("No hay artículos disponibles"))
                    : ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: filteredArticles.length,
                        itemBuilder: (context, index) {
                          final article = filteredArticles[index];
                          return Card(
                            clipBehavior: Clip.antiAlias,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: InkWell(
                              onTap: () {
                                articleProvider.setSelectedArticle(article);
                                Get.to(() => const ArticleDetailScreen());
                              },
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  if (article.imageUrl != null)
                                    Image.asset(
                                      article.imageUrl!,
                                      height: 180,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          article.title,
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          article.description,
                                          style: TextStyle(
                                            color: Colors.grey[700],
                                            fontSize: 14,
                                          ),
                                        ),
                                        const SizedBox(height: 12),
                                        Wrap(
                                          spacing: 8,
                                          children: article.tags
                                              .map((tag) => Chip(
                                                    label: Text(tag),
                                                    backgroundColor: article
                                                        .color
                                                        .withOpacity(0.1),
                                                    labelStyle: TextStyle(
                                                      color: article.color,
                                                      fontSize: 12,
                                                    ),
                                                  ))
                                              .toList(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
