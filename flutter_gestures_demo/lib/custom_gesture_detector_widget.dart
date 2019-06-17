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
  int totalItems = 250;
  double scale = 1.0;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      //single tap gestures
      // onTap: () {
      //   _updateLastAction('Single Tap');
      // },
      onTapDown: (details) {
        _updateLastAction('Tap Down: ${details.globalPosition}');
      },
      onTapUp: (details) {
        _updateLastAction('Tap Up: ${details.globalPosition}');
      },
      //double tap gesture
      onDoubleTap: () {
        _showHelp(context: context, action: 'Double Tap');
      },
      //long press gesture
      onLongPress: () {
        _showHelp(context: context, action: 'Long Press');
        _showContextMenu(context);
      },

      /*
               *  We can not use both drag and scale gestures togather.
               *  If we do we will get following output:
               *    - if we use horizontal drag with scale: No Error, we can not scale horizontally, only vertically
               *    - if we use vertical drag with scale: No Error, we can not scale vertically
               *    - if we use both drag with scale: Error, Simultaneously having a vertical drag, a horzontal drag
               *      and a scale gesture, this will result into scale gestures being ignored.
               */
      // Horizontal Drag gestures
      // onHorizontalDragStart: (DragStartDetails details) =>
      //     _processDragStartEvent(details),
      // onHorizontalDragUpdate: (DragUpdateDetails details) =>
      //     _processDragUpdateEvent(details),
      // onHorizontalDragEnd: (DragEndDetails details) =>
      //     _processDragEndEvent(details),

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
        color: Colors.blue[100],
        child: Center(
          child: ChartWidget(lastAction),
        ),
      ),
    );
  }

  _updateLastAction(action) {
    lastAction = 'Last Action: $action';
    setState(() {
      // _showHelp(action: lastAction);
      print(lastAction);
    });
  }

  _showHelp({BuildContext context, @required String action}) {
    _updateLastAction(action);
    // _showToast(context: context, action: action);
  }

  _processDragStartEvent(DragStartDetails details) {
    _updateLastAction("Drag Start: Potision: \n\n${details.globalPosition}");
  }

  _processDragUpdateEvent(DragUpdateDetails details) {
    _updateLastAction("Drag Update: Potision: \n\n${details.globalPosition}");
  }

  _processDragEndEvent(DragEndDetails details) {
    _updateLastAction("Drag End: Velocity: \n\n${details.velocity}");
  }

  _processScaleStartEvent(ScaleStartDetails details) {
    _updateLastAction("Scale Start: Focal point: \n\n${details.focalPoint}");
  }

  _processScaleUpdateEvent(ScaleUpdateDetails details) {
    scale = details.scale;
    Offset focalPoint = details.focalPoint;
    int visibleItems = (totalItems / scale).round();

    if (visibleItems > totalItems) {
      visibleItems = totalItems;
    }
    if (visibleItems < 0) {
      visibleItems = 0;
    }
    int itemDifference = totalItems - visibleItems;

    _updateLastAction('''Scale Update: Scale: $scale, Focal Point: $focalPoint
        \n\t--> totalItems/visibleItems: $totalItems/$visibleItems
        ''');
  }

  _processScaleEndEvent(ScaleEndDetails details) {
    _updateLastAction("Scale End: Velocity: \n\n${details.velocity}");
  }
}

class ChartWidget extends StatelessWidget {
  String lastAction;
  ChartWidget(this.lastAction);
  @override
  Widget build(BuildContext context) {
    return Text(lastAction);
  }
}

void _showContextMenu(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) {
        return buildContextMenuDialog(context);
      });
}

buildContextMenuDialog(BuildContext context) {
  const TextStyle style = TextStyle(fontSize: 15.0);
  return SimpleDialog(
    title: const Text(
      'Select Option',
      style: TextStyle(fontSize: 20.0),
    ),
    children: <Widget>[
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          _showToast(context: context, action: "option 1");
        },
        child: const Text(
          'option 1',
          style: style,
        ),
      ),
      SimpleDialogOption(
        onPressed: () {
          Navigator.pop(context);
          _showToast(context: context, action: "option 2");
        },
        child: const Text(
          'option 2',
          style: style,
        ),
      ),
    ],
  );
}

_showToast({BuildContext context, String action}) {
  Fluttertoast.showToast(
      msg: action,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIos: 2,
      backgroundColor: Colors.blueAccent,
      textColor: Colors.white,
      fontSize: 14.0);
}
