import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animation_demo/animations/animation_controller.dart';

void main() {
  SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: SafeArea(child: MyHomePage('Flutter Demo Home Page')),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String title;
  MyHomePage(this.title);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      // appBar: AppBar(),
      body: FullScreenWidget(),
    );
  }
}

class FullScreenWidget extends StatefulWidget {
  FullScreenWidget();

  @override
  _FullScreenWidgetState createState() => _FullScreenWidgetState();
}

class _FullScreenWidgetState extends State<FullScreenWidget>
    with
        SingleTickerProviderStateMixin,
        CustomAnimationControllerMixin,
        ToolsFragmentAnimationMixin {
  AnimationController _controller;
  @override
  void initState() {
    super.initState();
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    initOffset(_controller);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onDoubleTap: () {
        triggerAnimation(_controller);
        setState(() {
          print('setState');
        });
      },
      child: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          buildBaseContainer("Chart"),
          buildDurationContainer("3-Day", "5-Min", durationOffset),
          buildBottomIconsContainer(toolsOffset),
          buildOptionMenu(),
        ],
      ),
    );
  }

  _doubleTap() {}
}

List<String> options = ['a', 'b', 'c'];

buildOptionMenu() {
  return Align(
    alignment: Alignment.topRight,
    child: PopupMenuButton(
      itemBuilder: (context) {
        return options.map((item) {
          return PopupMenuItem(
            value: item,
            child: ListTile(title: Text(item)),
          );
        }).toList();
      },
      onSelected: _onOptionMenuItemSelect,
    ),
  );
}

void _onOptionMenuItemSelect(item) {
  print("option selected: $item");
}

buildBottomIconsContainer(Animation<Offset> offset) {
  print('BottomIconsContainer BUILD');
  return Align(
    alignment: Alignment.bottomRight,
    child: SlideTransition(
      position: offset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          Icon(Icons.zoom_in),
          Icon(Icons.zoom_out_map),
          Icon(Icons.zoom_out),
        ],
      ),
    ),
  );
}

buildDurationContainer(
    String duration, String timeFrame, Animation<Offset> offset) {
  print('DurationContainer BUILD');
  var style =
      TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.white);
  return Align(
    alignment: Alignment.topLeft,
    child: SlideTransition(
      position: offset,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Text(
            duration,
            style: style,
          ),
          Text(
            " - ",
            style: style,
          ),
          Text(
            timeFrame,
            style: style,
          )
        ],
      ),
    ),
  );
}

buildBaseContainer(String text) {
  print('BaseContainer BUILD');
  return Container(
    child: Center(child: Text(text)),
    color: Colors.lightBlueAccent,
  );
}
