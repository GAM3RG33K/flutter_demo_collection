import 'package:flutter/material.dart';
import 'package:theme_change_app/bloc/bloc.dart';

class HomePage extends StatefulWidget {
  final themeBloc = themeBlocInstance;
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Change Themes"),
        automaticallyImplyLeading: true,
      ),
      body: ThemeChangeView(widget.themeBloc),
    );
  }
}

class ThemeChangeView extends StatefulWidget {
  ThemeBloc themeBloc;

  ThemeChangeView(this.themeBloc);
  @override
  _ThemeChangeViewState createState() => _ThemeChangeViewState();
}

class _ThemeChangeViewState extends State<ThemeChangeView> {
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      margin: EdgeInsets.all(8.0),
      padding: EdgeInsets.all(4.0),
      child: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildCircleView(ThemeType.light),
            buildCircleView(ThemeType.dark),
            buildCircleView(ThemeType.custom1),
            buildCircleView(ThemeType.custom2),
          ],
        ),
      ),
    ));
  }

  buildCircleView(ThemeType themeType) {
    Color buttonColor;
    Color textColor;
    switch (themeType) {
      case ThemeType.custom1:
        buttonColor = Colors.cyanAccent;
        textColor = Colors.deepOrange;
        break;
      case ThemeType.custom2:
        buttonColor = Colors.pink;
        textColor = Colors.lightBlueAccent;
        break;
      case ThemeType.light:
        buttonColor = Colors.white;
        textColor = Colors.blueAccent;
        break;
      case ThemeType.dark:
        buttonColor = Colors.black;
        textColor = Colors.blue;
        break;
    }
    return RaisedButton(
      textColor: textColor,
      color: buttonColor,
      child: Text(themeType.toString()),
      onPressed: () {
        print('launching new theme: $themeType');
        widget.themeBloc.dispatch(ThemeChangeStartEvent(themeType));
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    );
  }
}
