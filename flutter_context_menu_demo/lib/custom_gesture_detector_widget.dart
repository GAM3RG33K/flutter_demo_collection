import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CustomGestureDetectorWidget extends StatefulWidget {
  @override
  _CustomGestureDetectorWidgetState createState() =>
      _CustomGestureDetectorWidgetState();
}

class _CustomGestureDetectorWidgetState
    extends State<CustomGestureDetectorWidget> {
  String lastAction = 'None';
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //single tap gesture
      onTap: () {
        _updateLastAction('Single Tap');
      },
      //double tap gesture
      onDoubleTap: () {
        _showHelp(context, 'Double Tap');
      },
      //long press gesture
      onLongPress: () {
        _showHelp(context, 'Long Press');
        _showContextMenu(context);
      },
      //Horizontal Drag gestures
      onHorizontalDragStart: (DragStartDetails details) =>
          _processDragStartEvent(details),
      onHorizontalDragUpdate: (DragUpdateDetails details) =>
          _processDragUpdateEvent(details),
      onHorizontalDragEnd: (DragEndDetails details) =>
          _processDragEndEvent(details),

      /*
               *  We can not use both vertical drag and scale gestures togather.
               *  If we do we will get an error, 
               * 
               *  
               */

      //Vertical Drag gestures
      // onVerticalDragStart: (DragStartDetails details) =>
      //     _processDragStartEvent(details),
      // onVerticalDragUpdate: (DragUpdateDetails details) =>
      //     _processDragUpdateEvent(details),
      // onVerticalDragEnd: (DragEndDetails details) =>
      //     _processDragEndEvent(details),

      //Scale gestures
      onScaleStart: (ScaleStartDetails details) =>
          _processScaleStartEvent(details),
      onScaleUpdate: (ScaleUpdateDetails details) =>
          _processScaleUpdateEvent(details),
      onScaleEnd: (ScaleEndDetails details) => _processScaleEndEvent(details),

      child: Container(
        color: Colors.yellow[50],
        child: Center(
          child: Text(lastAction),
        ),
      ),
    );
  }

  _updateLastAction(action) {
    lastAction = 'Last Action: $action';
    setState(() {
      print(action);
    });
  }

  _showHelp(BuildContext context, String action) {
    _updateLastAction(action);
    _showToast(context, action);
  }

  _processDragStartEvent(DragStartDetails details) {
    _updateLastAction("Drag Start Potision: \n\n${details.globalPosition}");
  }

  _processDragUpdateEvent(DragUpdateDetails details) {
    _updateLastAction("Drag Update Potision: \n\n${details.globalPosition}");
  }

  _processDragEndEvent(DragEndDetails details) {
    _updateLastAction("Drag End Velocity: \n\n${details.velocity}");
  }

  _processScaleStartEvent(ScaleStartDetails details) {
    _updateLastAction("Scale Start Focal point: \n\n${details.focalPoint}");
  }

  _processScaleUpdateEvent(ScaleUpdateDetails details) {
    _updateLastAction("Scale Update Scale: \n\n${details.scale}");
  }

  _processScaleEndEvent(ScaleEndDetails details) {
    _updateLastAction("Scale End Velocity: \n\n${details.velocity}");
  }
}

void _showContextMenu(BuildContext context) {
  // showMenu(
  //   context: context,
  //   position: RelativeRect.fill,
  //   initialValue: 'option 1',
  //   elevation: 5.0,
  //   items: ['option 1', 'option 2', 'option 3', 'option 4', 'option 5']
  //       .map((String option) {
  //     return PopupMenuItem(
  //       value: option,
  //       child: Text(option),
  //     );
  //   }).toList(),

  // );

  // var items = ['option 1', 'option 2', 'option 3', 'option 4', 'option 5'];
  const TextStyle style = TextStyle(fontSize: 15.0);
  var alertDialog = SimpleDialog(
    title: const Text(
      'Select Option',
      style: TextStyle(fontSize: 20.0),
    ),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          _showToast(context, "option 1");
        },
        child: const Text(
          'option 1',
          style: style,
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          _showToast(context, "option 2");
        },
        child: const Text(
          'option 2',
          style: style,
        ),
      ),
    ],
  );

  showDialog(
    context: context,
    child: alertDialog,
  );
}

_showToast(BuildContext context, String action) {
  Fluttertoast.showToast(
      msg: action,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 14.0);
}
