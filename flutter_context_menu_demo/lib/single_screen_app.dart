import 'package:flutter/material.dart';
import 'custom_gesture_detector_widget.dart';

class SingleScreenApp extends StatefulWidget {
  @override
  _SingleScreenAppState createState() => _SingleScreenAppState();
}

class _SingleScreenAppState extends State<SingleScreenApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('FlutterGesturesDemo'),
        ),
        body: SafeArea(
          child: CustomGestureDetectorWidget(),
        ),
      ),
    );
  }
}
