import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/provider/user_provider.dart';

class ArticleDetailScreen extends StatefulWidget {
  const ArticleDetailScreen({super.key});

  @override
  State<ArticleDetailScreen> createState() => _ArticleDetailScreenState();
}

class _ArticleDetailScreenState extends State<ArticleDetailScreen> {
  @override
  void initState() {
    super.initState();
    // Incrementar contador de artículos leídos
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      userProvider.user.postReadIt += 1;
      userProvider.saveUser(userProvider.user);
    });
  }

  @override
  Widget build(BuildContext context) {
    final article = context.watch<ArticleProvider>().selectedArticle;

    if (article == null) {
      return const Scaffold(
        body: Center(child: Text('No se ha seleccionado ningún artículo')),
      );
    }

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // AppBar con imagen expandible
          SliverAppBar(
            expandedHeight: 250.0,
            floating: false,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                article.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  shadows: [Shadow(blurRadius: 5.0, color: Colors.black)],
                ),
              ),
              background: article.imageUrl != null
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          article.imageUrl!,
                          fit: BoxFit.cover,
                        ),
                        // Gradiente oscuro para legibilidad
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withOpacity(0.7),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : Container(color: article.color),
            ),
          ),

          // Contenido del artículo
          SliverPadding(
            padding: const EdgeInsets.all(16.0),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  // Descripción
                  Text(
                    article.description,
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey[700],
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // Etiquetas
                  Wrap(
                    spacing: 8,
                    children: article.tags
                        .map((tag) => Chip(
                              label: Text(tag),
                              backgroundColor: article.color.withOpacity(0.1),
                              labelStyle: TextStyle(color: article.color),
                            ))
                        .toList(),
                  ),
                  const SizedBox(height: 24),

                  // Contenido principal o secciones
                  if (article.sections.isEmpty)
                    Text(
                      article.content,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.6,
                      ),
                    )
                  else
                    ...article.sections.map(
                      (section) => Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Título de la sección
                          Container(
                            margin: const EdgeInsets.only(bottom: 12.0),
                            padding: const EdgeInsets.only(bottom: 8.0),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: article.color.withOpacity(0.3),
                                  width: 2.0,
                                ),
                              ),
                            ),
                            child: Text(
                              section.title,
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: article.color,
                              ),
                            ),
                          ),

                          // Contenido de la sección
                          Text(
                            section.content,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.6,
                            ),
                          ),

                          // Imágenes de la sección
                          if (section.images != null &&
                              section.images!.isNotEmpty)
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 16.0),
                              child: SizedBox(
                                height: 200,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: section.images!.length,
                                  itemBuilder: (context, index) {
                                    return Padding(
                                      padding:
                                          const EdgeInsets.only(right: 8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(8),
                                        child: Image.asset(
                                          section.images![index],
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                          const SizedBox(height: 24),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
      // Botón para compartir artículo
      floatingActionButton: FloatingActionButton(
        backgroundColor: article.color,
        child: const Icon(Icons.share),
        onPressed: () {
          // Implementar compartir artículo
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Compartiendo artículo...')),
          );
        },
      ),
    );
  }
}
