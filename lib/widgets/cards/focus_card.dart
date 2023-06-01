import 'package:flutter/material.dart';

import '../../models/blog.dart';
import '../blogs.dart';

class FocusCard extends StatelessWidget {
  final Blog blog;

  const FocusCard({
    super.key,
    required this.blog,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: blog.gradientColors,
            stops: const [
              0.0,
              1.0,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
              child: Text(
                blog.title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 16.0),
              child: Text(
                blog.description,
                style: const TextStyle(
                    fontSize: 16, color: Color.fromARGB(225, 255, 255, 255)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 16,
                top: 32,
                bottom: 16,
              ),
              child: FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: blog.buttonColor,
                ),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return BlogState(
                      blog: blog,
                    );
                  }));
                },
                child: Text(blog.buttonText),
              ),
            )
          ],
        ),
      ),
    );
  }
}
