import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:nutriplato/home.dart';
import 'package:nutriplato/domain/article/article_provider.dart';
import 'package:nutriplato/presentation/presentation/presentation.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.android);

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            lazy: false,
            create: (_) {
              final articleProvider = ArticleProvider();
              articleProvider.getArticles();
              return articleProvider;
            }),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NutriPlato',
        theme: ThemeData(
          useMaterial3: true,
          colorSchemeSeed: Colors.purple,
        ),
        home: presentation ? const Presentation() : const Home(),
      ),
    );
  }
}
