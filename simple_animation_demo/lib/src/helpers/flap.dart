import 'package:flutter/material.dart';

class flap extends StatelessWidget {
  var _flapColor;

  flap(boxColor) {
    _flapColor = boxColor;
  }

  @override
  Widget build(BuildContext context) {
    return Container(height: 10.0, width: 100.0, color: _flapColor);
  }
}
