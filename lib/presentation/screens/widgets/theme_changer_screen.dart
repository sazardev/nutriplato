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
      body: ListView.builder(
          itemCount: colorList.length,
          itemBuilder: (context, index) {
            return RadioListTile(
              title: Text(colorList[index].toString()),
              activeColor: colorList[index],
              value: index,
              groupValue: selected,
              onChanged: (value) {
                context.read<ThemeChangerProvider>().changeColorIndex(index);
              },
            );
          }),
    );
  }
}
