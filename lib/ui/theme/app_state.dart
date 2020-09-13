import 'package:diabetttty/ui/theme/styles.dart';
import 'package:flutter/material.dart';

class AppLangState with ChangeNotifier {
  var selectedLanguageCode = 'en';
  Locale locale = Locale('en');

  ThemeData _themeData = getLightTheme();

  getTheme() => _themeData;

  setTheme(ThemeData themeData) async {
    _themeData = themeData;
    notifyListeners();
  }

  AppLangState(lang) {
    selectedLanguageCode = lang;
  }

  Locale get getLocale => locale;

  get getSelectedLanguageCode => selectedLanguageCode;

  setLocale(locale) => this.locale = locale;

  setSelectedLanguageCode(code) => this.selectedLanguageCode = code;

  changeLocale(Locale l) {
    locale = l;
    notifyListeners();
  }

  changeLanguageCode(code) {
    selectedLanguageCode = code;
    locale = Locale(code);
    notifyListeners();
  }
}
