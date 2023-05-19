import 'package:flutter/material.dart';
import 'package:nutriplato/object/food.dart';

class ProportionFood extends StatelessWidget {
  final Color color;
  final Food food;

  const ProportionFood({
    super.key,
    required this.color,
    required this.food,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: color,
      title: Row(children: [
        Text(
          food.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
        const Spacer(),
        IconButton(
          color: Colors.white,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Icons.close),
        ),
      ]),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Card(
              elevation: 10,
              child: SizedBox(
                width: 200,
                height: 200,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: food.image,
                ),
              ),
            ),
            Text(
              '${food.description}',
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 50,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '${food.calories} kCal por porción',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: SizedBox(
                height: 50,
                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '1 porción = ${food.portions} ${food.name}',
                      style: const TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
