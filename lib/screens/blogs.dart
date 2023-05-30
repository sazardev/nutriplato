import 'package:flutter/material.dart';

import '../models/blog.dart';

class BlogState extends StatefulWidget {
  final Blog blog;

  const BlogState({
    Key? key,
    required this.blog,
  }) : super(key: key);

  @override
  _BlogStateState createState() => _BlogStateState();
}

class _BlogStateState extends State<BlogState> {
  final ScrollController _scrollController = ScrollController();
  bool _showButton = false;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
          _scrollController.position.maxScrollExtent) {
        setState(() {
          _showButton = true;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.white,
        backgroundColor: widget.blog.gradientColors[0],
        title: Text(
          widget.blog.title,
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Center(
                child: Text(
                  widget.blog.description,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                widget.blog.content,
                style: const TextStyle(fontSize: 21),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton(
              backgroundColor: widget.blog.gradientColors[0],
              onPressed: () => Navigator.pop(context),
              child: const Icon(
                Icons.done,
                color: Colors.white,
              ),
            )
          : null,
    );
  }
}
