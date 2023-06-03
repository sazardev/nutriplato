import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  height: constraints.maxHeight / 4,
                  child: Card(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: SizedBox(
                            child: CircleAvatar(
                              radius: constraints.maxHeight / 10,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const Text(
                  'Jacqueline Juarez',
                  style: TextStyle(fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      iconSize: 35,
                      color: Colors.indigo,
                      icon: const Icon(FontAwesomeIcons.facebookMessenger),
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 35,
                      color: Colors.orange,
                      icon: const Icon(FontAwesomeIcons.instagram),
                    ),
                    IconButton(
                      onPressed: () {},
                      iconSize: 35,
                      color: Colors.green,
                      icon: const Icon(FontAwesomeIcons.whatsapp),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}
