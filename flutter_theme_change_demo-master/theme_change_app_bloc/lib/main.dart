import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:theme_change_app/bloc/bloc.dart';

import 'bloc/theme_bloc.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ThemeApp(themeBlocInstance));
}

class ThemeApp extends StatefulWidget {
  ThemeBloc themeBloc;

  ThemeApp(this.themeBloc);

  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ThemeEvent, ThemeState>(
      bloc: widget.themeBloc,
      builder: (context, ThemeState snapshot) {
        if (snapshot is ThemeDataLoadedState) {
          return MaterialApp(
            title: "Dynamic Theme App [BLoC]",
            debugShowCheckedModeBanner: false,
            home: HomePage(),
            theme: (snapshot).themeData,
          );
        }
        return Center(
          child: Container(
            child: Text("Something went wrong!!"),
          ),
        );
      },
    );
  }
}
