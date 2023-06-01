import 'package:flutter/material.dart';

class Advertice extends StatelessWidget {
  final Color color;
  final String title;
  final String content;

  const Advertice({
    super.key,
    required this.color,
    required this.title,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(content),
    );
  }
}
