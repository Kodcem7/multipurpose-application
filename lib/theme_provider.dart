import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier {
  bool isDarkMode = false;

  ThemeData getTheme() {
    return isDarkMode ? ThemeData.dark() : ThemeData.light();
  }

  void toggleTheme(bool isOn) {
    isDarkMode = isOn;
    notifyListeners();
  }
}
