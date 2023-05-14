import 'package:flutter/material.dart';

class Foods extends StatefulWidget {
  final int position;

  const Foods({
    super.key,
    required this.position,
  });

  @override
  State<Foods> createState() => _FoodsState();
}

class _FoodsState extends State<Foods> {
  List<String> categories = [
    'Verduras',
    'Frutas',
    'Legumbres',
    'Animal',
    'Cereales',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 12,
              ),
              child: Text(
                categories[widget.position],
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(3.0),
              child: IconButton(
                onPressed: () {},
                icon: const Icon(
                  Icons.close,
                  size: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
