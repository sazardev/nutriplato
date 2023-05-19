import 'package:flutter/material.dart';

class Contact extends StatelessWidget {
  const Contact({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: LayoutBuilder(
        builder: (context, constraints) {
          return Column(
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
                      const Spacer(),
                      const Text('Jacqueline Juarez'),
                      const Spacer(),
                    ],
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }
}
