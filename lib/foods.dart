import 'package:flutter/material.dart';
import 'package:nutriplato/proportion_food.dart';

import 'data.dart';
import 'food.dart';

class Foods extends StatefulWidget {
  final Color color;
  final int tappedSection;

  const Foods({
    super.key,
    required this.color,
    required this.tappedSection,
  });

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  @override
  Widget build(BuildContext context) {
    bool isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    return Align(
      alignment: Alignment.centerRight,
      child: FractionallySizedBox(
        widthFactor: 0.5,
        child: Scaffold(
          backgroundColor: widget.color,
          appBar: AppBar(
            foregroundColor: Colors.white,
            backgroundColor: widget.color,
            title: Text(
              categories[widget.tappedSection],
              style: const TextStyle(color: Colors.white),
            ),
          ),
          body: GridView.count(
            crossAxisCount: 2,
            children: List.generate(10, (index) {
              return LayoutBuilder(
                builder: (context, constraints) {
                  return Card(
                    elevation: 5,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Spacer(),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            'Title $index',
                            style: const TextStyle(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: [
                              IconButton(
                                color: widget.color,
                                onPressed: () {
                                  showDialog(
                                      context: context,
                                      builder: (builder) {
                                        return ProportionFood(
                                          color: widget.color,
                                          food: Food(
                                            name: 'Manzana',
                                            portions: 0.5,
                                            calories: 100,
                                          ),
                                        );
                                      });
                                },
                                icon: const Icon(Icons.palette),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}
