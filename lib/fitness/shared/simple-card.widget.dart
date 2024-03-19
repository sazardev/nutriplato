import 'package:flutter/material.dart';

class SimpleCard extends StatelessWidget {
  const SimpleCard({
    super.key,
    required this.title,
    required this.onTap,
    this.icon,
    this.time,
  });

  final String title;
  final Function() onTap;
  final IconData? icon;
  final String? time;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 180,
      height: 150,
      child: Card(
        elevation: 0,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: onTap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 12),
                child: Icon(icon),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 16.0,
                  right: 16,
                  top: 8,
                ),
                child: Text(
                  title,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 12.0, top: 5),
                child: Row(
                  children: [
                    const Icon(Icons.timer),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(time ?? ''),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
