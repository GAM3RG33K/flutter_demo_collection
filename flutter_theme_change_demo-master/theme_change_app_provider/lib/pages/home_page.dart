import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../theme_data.dart';

class HomePage extends StatefulWidget {
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
      body: ThemeChangeView(),
    );
  }
}

class ThemeChangeView extends StatefulWidget {
  ThemeChangeView();
  @override
  _ThemeChangeViewState createState() => _ThemeChangeViewState();
}

class _ThemeChangeViewState extends State<ThemeChangeView> with ChangeNotifier {
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
        //get reference of the ChangeNotification instance
        var appThemeData = Provider.of<AppThemeData>(context, listen: false);
        //set/change propety of the instace to trigger notification
        appThemeData.appTheme = themeType;
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0)),
    );
  }
}
