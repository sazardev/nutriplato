import 'package:flutter/material.dart';
import 'package:nutriplato/infrastructure/entities/article/article.dart';
import 'package:nutriplato/infrastructure/entities/article/article_section.dart';

class ArticleProvider extends ChangeNotifier {
  List<Article> articles = [];
  Article? selectedArticle;
  bool isLoading = false;
  String? error;

  void getArticles() async {
    isLoading = true;
    notifyListeners();

    try {
      await Future.delayed(const Duration(milliseconds: 500));
      articles = _getExampleArticles();
      isLoading = false;
      error = null;
    } catch (e) {
      error = e.toString();
      isLoading = false;
    }

    notifyListeners();
  }

  void setSelectedArticle(Article article) {
    selectedArticle = article;
    notifyListeners();
  }

  List<Article> _getExampleArticles() {
    return [
      Article(
        title: "Beneficios de una alimentación balanceada",
        description:
            "Descubre cómo una alimentación equilibrada mejora tu salud",
        content: "Resumen del artículo",
        imageUrl: "lib/data/img/plato_del_bien_comer.jpeg",
        color: Colors.green,
        publishDate: DateTime.now().subtract(const Duration(days: 3)),
        tags: ["nutrición", "salud", "bienestar"],
        sections: [
          ArticleSection(
            title: "¿Qué es una alimentación balanceada?",
            content:
                "Una alimentación balanceada consiste en consumir una variedad de alimentos que proporcionen los nutrientes necesarios para mantener la salud y tener energía. Estos nutrientes incluyen proteínas, carbohidratos, grasas, vitaminas y minerales.",
          ),
          ArticleSection(
            title: "Beneficios para la salud física",
            content:
                "Consumir una dieta equilibrada tiene múltiples beneficios para la salud física: mantiene un peso saludable, fortalece el sistema inmunológico, reduce el riesgo de enfermedades crónicas como diabetes y enfermedades cardíacas, y mejora la energía y vitalidad.",
          ),
          ArticleSection(
            title: "Impacto en la salud mental",
            content:
                "La alimentación también afecta directamente nuestra salud mental. Una dieta rica en antioxidantes, ácidos grasos omega-3, vitaminas y minerales está relacionada con menores tasas de depresión y ansiedad, y mejor claridad mental.",
          ),
        ],
      ),
      Article(
        title: "Los mejores alimentos para deportistas",
        description: "Nutrición adecuada para mejorar tu rendimiento físico",
        content: "Resumen del artículo",
        imageUrl: "lib/data/img/fitness_food.jpeg",
        color: Colors.blue,
        publishDate: DateTime.now().subtract(const Duration(days: 5)),
        tags: ["deporte", "energía", "rendimiento"],
        sections: [
          ArticleSection(
            title: "Carbohidratos para energía",
            content:
                "Los carbohidratos son la fuente principal de energía para los deportistas. Es recomendable consumirlos antes, durante y después del ejercicio para mantener los niveles de glucosa en sangre y reponer el glucógeno muscular.",
          ),
          ArticleSection(
            title: "Proteínas para recuperación",
            content:
                "Las proteínas son esenciales para la reparación y el crecimiento muscular. Los deportistas deben consumir proteínas de alta calidad distribuidas a lo largo del día, especialmente después del entrenamiento.",
          ),
        ],
      ),
    ];
  }
}
