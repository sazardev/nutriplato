import 'package:flutter/material.dart';
import 'package:nutriplato/home.dart';
import 'package:nutriplato/screens/presentation.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  bool presentation = prefs.getBool('presentation') ?? true;

  runApp(MyApp(
    presentation: presentation,
  ));
}

class MyApp extends StatelessWidget {
  final bool presentation;

  const MyApp({super.key, required this.presentation});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NutriPlato',
      theme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: Colors.purple,
      ),
      home: presentation ? const Presentation() : const Home(),
    );
  }
}
