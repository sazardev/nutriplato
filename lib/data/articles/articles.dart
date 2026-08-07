import 'package:nutriplato/data/articles/bienestar.dart';
import 'package:nutriplato/data/articles/estilo_vida.dart';
import 'package:nutriplato/data/articles/mexico.dart';
import 'package:nutriplato/data/articles/nutricion.dart';
import 'package:nutriplato/data/articles/recetas.dart';
import 'package:nutriplato/data/articles/salud.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';

/// Todos los artículos del blog de NutriPlato.
List<Article> allBlogArticles() {
  return [
    ...nutricionArticles(),
    ...recetasArticles(),
    ...saludArticles(),
    ...estiloVidaArticles(),
    ...mexicoArticles(),
    ...bienestarArticles(),
  ];
}
