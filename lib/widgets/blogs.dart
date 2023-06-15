import 'package:flutter/material.dart';
import 'package:nutriplato/models/article.dart';

class BlogState extends StatefulWidget {
  final Article article;

  const BlogState({
    Key? key,
    required this.article,
  }) : super(key: key);

  @override
  State<BlogState> createState() => _BlogStateState();
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
        backgroundColor: widget.article.color,
        title: Text(
          widget.article.title,
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
                  widget.article.description,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                    color: widget.article.color,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(22.0),
              child: Text(
                widget.article.content,
                style: const TextStyle(fontSize: 21),
                textAlign: TextAlign.justify,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: _showButton
          ? FloatingActionButton(
              backgroundColor: widget.article.color,
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
