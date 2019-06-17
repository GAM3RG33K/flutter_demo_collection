import 'package:meta/meta.dart';

import 'theme_bloc.dart';

@immutable
abstract class ThemeEvent {}

class ThemeChangeStartEvent extends ThemeEvent {
  final ThemeType themeID;
  ThemeChangeStartEvent(this.themeID);
}

class ThemeChangeCompleteEvent extends ThemeEvent {}
