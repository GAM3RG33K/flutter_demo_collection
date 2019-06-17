import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import './bloc.dart';

enum ThemeType { light, dark, custom1, custom2 }

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  @override
  ThemeState get initialState =>
      ThemeDataLoadedState(_getTheme(ThemeType.light));

  @override
  Stream<ThemeState> mapEventToState(
    ThemeEvent event,
  ) async* {
    if (event is ThemeChangeStartEvent) {
      yield ThemeDataLoadedState(_getTheme(event.themeID));
      return;
    }
  }
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

final themeBlocInstance = ThemeBloc();
