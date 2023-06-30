import 'package:flutter/widgets.dart';

class ThemeChangerProvider extends ChangeNotifier {
  int selectedColor = 0;

  void changeColorIndex(int index) {
    selectedColor = index;

    notifyListeners();
  }
}
