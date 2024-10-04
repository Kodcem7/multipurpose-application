import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      AppLocalizationsDelegate();

  static final Map<String, Map<String, String>> localizedValues = {
    'en': {
      'settings': 'Settings',
      'home_page': 'Home Page',
      'theme': 'Theme',
      'dark_theme': 'Dark Theme',
      'language': 'Language',
      'english': 'English',
      'turkish': 'Turkish',
      'deutsch' : 'Deutsch',
      'hello': 'Hello',
      'home': 'Home',
      'news': 'News',
      'haberleri getir' : 'Get The News',
      'topic (e.g.: general, sport, technology)' : 'topic (e.g.: general, sport, technology)',
      'country (Örn: tr, en, de)' : 'country (e.g.: tr, en, de)',
      'weather': 'Weather',
      'dil (tr/en vb.)': 'Language (tr/en etc.)',
      'şehir': 'City',
      'hava durumu getir': 'Get The Weather',
      'durum': 'State',
      'sicaklik': 'Degree',
      'nem' : 'Humidity',
      'veri yüklenemedi' : 'Failed to load data',
      'hava durumu' : 'Weather',
      'futball' : 'Futball',
      'leagues' : 'Leagues',
      'min' : 'Min',
      'max' : 'Max',
      'gece' : 'Night',
      'veri yok' : 'No data'
    },
    'tr': {
      'settings': 'Ayarlar',
      'home_page': 'Ana Sayfa',
      'theme': 'Tema',
      'dark_theme': 'Koyu Tema',
      'language': 'Dil',
      'english': 'İngilizce',
      'turkish': 'Türkçe',
      'deutsch' : 'Almanca',
      'hello': 'Naber',
      'home': 'Ev',
      'news': 'Haberler',
      'haberleri getir' : 'Haberleri Getir',
      'topic (e.g.: general, sport, technology)' : 'konu (e.g.: general, sport, technology)',
      'country (Örn: tr, en, de)' : 'ülke (Örn: tr, en, de)',
      'weather': 'Hava',
      'dil (tr/en vb.)': 'Dil (tr/en vb.)',
      'şehir': 'Şehir',
      'hava durumu getir': 'Hava Durumu Getir',
      'durum': 'Durum',
      'sicaklik': 'Sicaklik',
      'nem' : 'Nem',
      'veri yüklenemedi' : 'Veri Yüklenemedi',
      'hava durumu' : 'Hava Durumu',
      'futball' : 'Futbol',
      'leagues' : 'Ligler',
      'min' : 'Min',
      'max' : 'Max',
      'gece' : 'Gece',
      'veri yok' : 'Veri yok'
    },
  };

  String? translate(String key) {
    return localizedValues[locale.languageCode]![key];
  }
}

class AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'tr'].contains(locale.languageCode);
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return SynchronousFuture<AppLocalizations>(AppLocalizations(locale));
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}
