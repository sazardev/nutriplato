import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:nutriplato/data/fitness/exercises.dart';
import 'package:nutriplato/widgets/cards/recommended_card.dart';
import 'package:nutriplato/widgets/contact.dart';

import '../data/blog/blog.dart';
import '../widgets/cards/focus_card.dart';

class Dashboard extends StatelessWidget {
  final String name = "Jacqueline";

  const Dashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      return Scaffold(
        backgroundColor: const Color.fromARGB(255, 245, 245, 245),
        appBar: AppBar(
          toolbarHeight: 60,
          automaticallyImplyLeading: false,
          title: Padding(
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
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (builder) {
                            return const Dialog(
                              child: Contact(),
                            );
                          });
                    },
                    icon: const Icon(
                      FontAwesomeIcons.addressCard,
                      color: Colors.purple,
                    ))
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Column(
                  children: List.generate(blogs.length, (index) {
                    return FocusCard(blog: blogs[index]);
                  }),
                ),
                Column(
                  children: List.generate(1, (index) {
                    return SizedBox(
                        width: constraints.maxWidth,
                        child: RecommendedCard(fitness: fitness[1]));
                  }),
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}
