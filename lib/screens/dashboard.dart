import 'package:flutter/material.dart';

import '../widgets/cards/focus_card.dart';

class Dashboard extends StatelessWidget {
  final String name = "Jacqueline";

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        body: Column(
          children: [
            SizedBox(
              height: 60,
              child: Card(
                elevation: 0,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      const Text('Buen dia, ',
                          style: TextStyle(
                            fontSize: 18,
                          )),
                      Text(
                        '$name.',
                        style: TextStyle(
                            color: Theme.of(context).colorScheme.primary,
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                      const Spacer(),
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.person,
                            color: Colors.deepPurple,
                          ))
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 16),
              child: FocusCard(
                colorButton: Colors.purple,
                content: 'Mejora tu fuerza y energia.',
                gradientColors: [
                  Colors.deepPurple.shade400,
                  Colors.purple.shade400,
                ],
                promptButton: 'Ver alimentos',
                title: 'Alto en proteinas',
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 6, right: 16),
              child: FocusCard(
                colorButton: Colors.orange,
                content: 'Reduce las grasas.',
                gradientColors: [
                  Colors.deepOrange.shade600,
                  Colors.amber.shade600,
                ],
                promptButton: 'Ver alimentos',
                title: 'Bajo en grasas',
              ),
            ),
          ],
        ),
      );
    });
  }
}
