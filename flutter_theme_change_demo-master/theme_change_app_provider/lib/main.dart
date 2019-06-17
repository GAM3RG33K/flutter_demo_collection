import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:theme_change_app_provider/theme_data.dart';
import 'pages/home_page.dart';

void main() {
  runApp(ChangeNotifierProvider(
    //Get Change Provider instance here
    builder: (context) => AppThemeData(),
    //Set your UI widget here, which should be re-drawn when notified by the Change notifier class
    // We are also applying the Consumer<ChangeNotifier> here to make sure that
    // the underlying widget is re-built when a change is notified
    child: Consumer<AppThemeData>(
      builder: (context, appThemeData, child) =>
          ThemeApp(appThemeData.appTheme),
    ),
  ));
}

class ThemeApp extends StatefulWidget {
  final ThemeData _appTheme;
  const ThemeApp(this._appTheme);

  @override
  _ThemeAppState createState() => _ThemeAppState();
}

class _ThemeAppState extends State<ThemeApp> {
  @override
  Widget build(BuildContext context) {
    print("ThemeAppState created !!");
    return MaterialApp(
      title: "Dynamic Theme App [Provider]",
      debugShowCheckedModeBanner: false,
      home: HomePage(),
      theme: widget._appTheme,
    );
  }
}
