import 'package:flutter/material.dart';

class FocusCard extends StatelessWidget {
  final List<Color> gradientColors;
  final String title;
  final String content;
  final String promptButton;
  final Color colorButton;

  const FocusCard({
    super.key,
    required this.gradientColors,
    required this.title,
    required this.content,
    required this.promptButton,
    required this.colorButton,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradientColors,
            stops: const [
              0.0,
              1.0,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 16, bottom: 4),
                  child: Text(
                    title,
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
                    content,
                    style: const TextStyle(
                        fontSize: 16,
                        color: Color.fromARGB(225, 255, 255, 255)),
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
                      backgroundColor: colorButton,
                    ),
                    onPressed: () {},
                    child: Text(promptButton),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
