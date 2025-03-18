class ArticleSection {
  final String title;
  final String content;
  final List<String>? images;

  ArticleSection({
    required this.title,
    required this.content,
    this.images,
  });

  factory ArticleSection.fromJson(Map<dynamic, dynamic> json) {
    return ArticleSection(
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      images: json['images'] != null ? List<String>.from(json['images']) : null,
    );
  }
}
