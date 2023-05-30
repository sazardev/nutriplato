import 'package:flutter/material.dart';

import '../models/blog.dart';

class BlogState extends StatefulWidget {
  final Blog blog;

  const BlogState({
    super.key,
    required this.blog,
  });

  @override
  State<BlogState> createState() => _BlogState();
}

class _BlogState extends State<BlogState> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.blog.title),
      ),
    );
  }
}
