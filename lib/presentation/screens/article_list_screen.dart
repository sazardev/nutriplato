import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/presentation/provider/article_provider.dart';
import 'package:nutriplato/presentation/screens/article_detail_screen.dart';
import 'package:nutriplato/config/theme/design_system.dart';
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
      backgroundColor: AppColors.background,
      body: CustomScrollView(
        slivers: [
          // Header con gradiente
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: Colors.transparent,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: AppGradients.ocean,
              ),
              child: FlexibleSpaceBar(
                centerTitle: false,
                titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
                title: Text(
                  'Artículos',
                  style: AppTypography.titleLarge.copyWith(
                    color: Colors.white,
                    fontSize: 18,
                  ),
                ),
                background: Container(
                  decoration: BoxDecoration(
                    gradient: AppGradients.ocean,
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 50),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Icon(
                            Icons.article_outlined,
                            color: Colors.white.withValues(alpha: .3),
                            size: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),

          // Filtros de categorías
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
                child: Row(
                  children: _allTags.map((tag) {
                    final isActive = _activeFilter == tag;
                    return Padding(
                      padding: const EdgeInsets.only(right: AppSpacing.sm),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            _activeFilter = tag;
                          });
                        },
                        borderRadius: BorderRadius.circular(AppRadius.full),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: AppSpacing.md,
                            vertical: AppSpacing.sm,
                          ),
                          decoration: BoxDecoration(
                            gradient: isActive ? AppGradients.ocean : null,
                            color: isActive ? null : AppColors.surface,
                            borderRadius: BorderRadius.circular(AppRadius.full),
                            boxShadow: [AppShadows.subtle],
                          ),
                          child: Text(
                            tag,
                            style: AppTypography.labelLarge.copyWith(
                              color: isActive
                                  ? Colors.white
                                  : AppColors.textSecondary,
                            ),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          // Lista de artículos
          articleProvider.isLoading
              ? const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : filteredArticles.isEmpty
                  ? SliverFillRemaining(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.article_outlined,
                              size: 64,
                              color:
                                  AppColors.textSecondary.withValues(alpha: .5),
                            ),
                            const SizedBox(height: AppSpacing.md),
                            Text(
                              "No hay artículos disponibles",
                              style: AppTypography.bodyLarge.copyWith(
                                color: AppColors.textSecondary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  : SliverPadding(
                      padding: const EdgeInsets.all(AppSpacing.md),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (context, index) {
                            final article = filteredArticles[index];
                            return Container(
                              margin:
                                  const EdgeInsets.only(bottom: AppSpacing.md),
                              decoration: BoxDecoration(
                                color: AppColors.surface,
                                borderRadius:
                                    BorderRadius.circular(AppRadius.lg),
                                boxShadow: [AppShadows.card],
                              ),
                              clipBehavior: Clip.antiAlias,
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
                                      padding:
                                          const EdgeInsets.all(AppSpacing.md),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            article.title,
                                            style: AppTypography.titleMedium
                                                .copyWith(
                                              color: AppColors.textPrimary,
                                            ),
                                          ),
                                          const SizedBox(height: AppSpacing.sm),
                                          Text(
                                            article.description,
                                            style: AppTypography.bodyMedium
                                                .copyWith(
                                              color: AppColors.textSecondary,
                                            ),
                                          ),
                                          const SizedBox(height: AppSpacing.md),
                                          Wrap(
                                            spacing: AppSpacing.sm,
                                            runSpacing: AppSpacing.xs,
                                            children: article.tags
                                                .map((tag) => Container(
                                                      padding: const EdgeInsets
                                                          .symmetric(
                                                        horizontal:
                                                            AppSpacing.sm,
                                                        vertical: AppSpacing.xs,
                                                      ),
                                                      decoration: BoxDecoration(
                                                        color: article.color
                                                            .withValues(
                                                                alpha: .1),
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                    AppRadius
                                                                        .full),
                                                      ),
                                                      child: Text(
                                                        tag,
                                                        style: AppTypography
                                                            .labelSmall
                                                            .copyWith(
                                                          color: article.color,
                                                        ),
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
                          childCount: filteredArticles.length,
                        ),
                      ),
                    ),
        ],
      ),
    );
  }
}
