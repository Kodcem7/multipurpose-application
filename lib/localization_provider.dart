import 'package:flutter/material.dart';

class LocalizationProvider extends ChangeNotifier {
  
  Locale _locale = const Locale('en', 'US');

  Locale getLocale() => _locale;

  String get currentLanguage => _locale.languageCode;

  void changeLanguage(String languageCode) {
    if (languageCode == 'en') {
      _locale = const Locale('en', 'US');
    } else if (languageCode == 'tr') {
      _locale = const Locale('tr', 'TR');
    }
    notifyListeners();
  }
}
