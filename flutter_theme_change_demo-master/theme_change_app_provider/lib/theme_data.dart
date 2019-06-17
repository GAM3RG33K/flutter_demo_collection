import 'package:flutter/material.dart';

enum ThemeType { light, dark, custom1, custom2 }

class AppThemeData with ChangeNotifier {
  static ThemeData _appTheme;

  get appTheme => _appTheme ?? _getDefaultTheme();

  set appTheme(ThemeType themeType) {
    //set the them basedon the theme type provided
    _appTheme = _getTheme(themeType);
    //notify all listeners, this should cause a re-build/draw of listening widgets
    notifyListeners();
  }

  ThemeData _getTheme(ThemeType themeID) {
    switch (themeID) {
      case ThemeType.custom1:
        return custom1Theme;
        break;
      case ThemeType.custom2:
        return custom2Theme;
        break;
      case ThemeType.light:
        return lightTheme;
        break;
      case ThemeType.dark:
        return darkTheme;
        break;
    }
  }

  ThemeData get lightTheme => ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.blueAccent,
        primaryColor: Colors.white,
      );

  ThemeData get darkTheme => ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.blue,
        primaryColor: Colors.black,
      );

  ThemeData get custom1Theme => ThemeData(
        brightness: Brightness.light,
        accentColor: Colors.deepOrange,
        primaryColor: Colors.cyanAccent,
      );
  ThemeData get custom2Theme => ThemeData(
        brightness: Brightness.dark,
        accentColor: Colors.lightBlueAccent,
        primaryColor: Colors.pink,
      );

  _getDefaultTheme() {
    _appTheme = _getTheme(ThemeType.light);
    return _appTheme;
  }
}
