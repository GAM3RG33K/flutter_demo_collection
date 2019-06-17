import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

@immutable
abstract class ThemeState {}

class ThemeDataLoadedState extends ThemeState {
  final ThemeData themeData;
  ThemeDataLoadedState(this.themeData);
}
