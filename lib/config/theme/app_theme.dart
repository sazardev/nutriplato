import 'package:flutter/material.dart';

const List<Color> colorList = [
  Colors.blue,
  Colors.indigo,
  Colors.purple,
  Colors.purpleAccent,
  Colors.deepPurple,
  Colors.red,
  Colors.redAccent,
  Colors.pink,
  Colors.green,
  Colors.greenAccent,
  Colors.lightGreen,
  Colors.teal,
  Colors.tealAccent,
  Colors.lightBlue,
  Colors.blueGrey,
];

class AppTheme {
  final int selectedColor;
  final bool isDarkMode;

  AppTheme({
    this.selectedColor = 0,
    this.isDarkMode = false,
  })  : assert(selectedColor >= 0, 'Selected color must be greater then 0'),
        assert(selectedColor < colorList.length,
            'Selected color must be less or equal than ${colorList.length - 1}');

  ThemeData getTheme() => ThemeData(
        useMaterial3: true,
        brightness: isDarkMode ? Brightness.dark : Brightness.light,
        colorSchemeSeed: colorList[selectedColor],
        appBarTheme: const AppBarTheme(centerTitle: false),
      );

  AppTheme copyWith({
    int? selectedColor,
    bool? isDarkMode,
  }) =>
      AppTheme(
        selectedColor: selectedColor ?? this.selectedColor,
        isDarkMode: isDarkMode ?? this.isDarkMode,
      );
}
