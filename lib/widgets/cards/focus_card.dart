import 'package:flutter/material.dart';

class FocusCard extends StatelessWidget {
  const FocusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      clipBehavior: Clip.antiAlias,
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Colors.green.shade400,
              Colors.teal.shade400,
            ],
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
                const Padding(
                  padding: EdgeInsets.only(left: 16, top: 16, bottom: 4),
                  child: Text(
                    'Super Alimentos',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.only(left: 16.0),
                  child: Text(
                    'Aprende sobre los super alimentos.',
                    style: TextStyle(
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
                    onPressed: () {},
                    child: const Text(
                      'Aprender',
                    ),
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
