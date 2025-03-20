import 'package:flutter/material.dart';
import 'package:nutriplato/config/theme/app_theme.dart';
import 'package:provider/provider.dart';

import '../../provider/theme_changer_provider.dart';

class ThemeChangerScreen extends StatelessWidget {
  const ThemeChangerScreen({super.key});

  static const appRouterName = "ThemeChangerScreen";

  @override
  Widget build(BuildContext context) {
    int selected = context.watch<ThemeChangerProvider>().selectedColor;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          appRouterName,
        ),
      ),
    );
  }
}
