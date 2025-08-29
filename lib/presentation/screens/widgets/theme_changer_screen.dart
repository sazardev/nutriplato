import 'package:flutter/material.dart';

class ThemeChangerScreen extends StatelessWidget {
  const ThemeChangerScreen({super.key});

  static const appRouterName = "ThemeChangerScreen";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appRouterName,
        ),
      ),
    );
  }
}
