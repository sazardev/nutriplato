import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';

class ArticleCard extends StatelessWidget {
  final Article article;
  final VoidCallback onTap;

  const ArticleCard({
    super.key,
    required this.article,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 280,
        height: 230,
        margin: const EdgeInsets.only(right: 16),
        child: Card(
          elevation: 3,
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image area with fixed height
              SizedBox(
                height: 120,
                width: double.infinity,
                child: article.imageUrl != null
                    ? Image.asset(
                        article.imageUrl!,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) => Container(
                          color: article.color.withValues(alpha: .2),
                          child: Icon(Icons.image_not_supported,
                              color: article.color),
                        ),
                      )
                    : Container(
                        color: article.color.withValues(alpha: .2),
                        child: Icon(Icons.article, color: article.color),
                      ),
              ),

              // Content area with remaining space
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title with max 2 lines
                      Text(
                        article.title,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          height: 1.2,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 1),

                      // Description with flexible space
                      Flexible(
                        child: Text(
                          article.description,
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[700],
                            height: 1.2,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      if (article.tags.isNotEmpty) ...[
                        const SizedBox(height: 1),
                        SizedBox(
                          height: 14,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: article.tags
                                  .take(2)
                                  .map((tag) => Container(
                                        margin: const EdgeInsets.only(right: 2),
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 4, vertical: 1),
                                        decoration: BoxDecoration(
                                          color: article.color
                                              .withValues(alpha: .1),
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        child: Text(
                                          tag,
                                          style: TextStyle(
                                            fontSize: 7,
                                            color: article.color,
                                          ),
                                        ),
                                      ))
                                  .toList(),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
