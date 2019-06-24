import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_general_utils/flutter_general_utils.dart';
import 'package:flutter_share_plugin/flutter_share_plugin.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String selectedFileName = 'None';
  String selectedFilePath = 'Unknown';
  final textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter file share app demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("file: $selectedFileName"),
            Text("path: $selectedFilePath"),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () => showChooser(),
                  child: Text('Choose file'),
                ),
                Container(
                  padding: EdgeInsets.all(5.0),
                ),
                RaisedButton(
                  onPressed: () =>
                      shareFile(selectedFileName, selectedFilePath),
                  child: Text('Share file'),
                )
              ],
            ),
            RaisedButton(
              onPressed: () => chooseAndShare(),
              child: Text('Choose & Share file'),
            ),
            TextField(autofocus: true, controller: textController),
            RaisedButton(
              onPressed: () => shareText(textController.text),
              child: Text('Share text'),
            )
          ],
        ),
      ),
    );
  }

  shareFile(String fileName, String filePath) {
    getFileBytes(filePath).then((bytes) async {
      var text = "sharing file: $fileName";
      NotificationHelper.showToast(text, false);
      await FlutterShare.shareFileWithText(
          textContent: text, filePath: filePath);
    });
  }

  showChooser() async {
    var task = () {
      getFileFromChooser().then((filePath) {
        setState(() {
          this.selectedFileName = getFileNameFromPath(filePath);
          this.selectedFilePath = filePath;
        });
      });
    };
    PermissionManager.performTaskWithPermission(AppPermission.Storage, task);
    // String filePath = await getFileFromChooser();
  }

  shareText(String text) {
    var textContent = "sharing text: $text";

    FlutterShare.shareText(text).then((text) {
      //DO something here if needed.
      NotificationHelper.showToast(textContent, false);
    });
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    textController.dispose();
    super.dispose();
  }

  chooseAndShare() {
    var task = () {
      getFileFromChooser().then((filePath) {
        setState(() {
          this.selectedFileName = getFileNameFromPath(filePath);
          this.selectedFilePath = filePath;
        });
        FlutterShare.shareFile(filePath);
      });
    };
    PermissionManager.performTaskWithPermission(AppPermission.Storage, task);
  }
}

Future<String> getFileFromChooser() async {
  // Pick a single file directly
  String filePath = await FilePicker.getFilePath(
      type: FileType
          .ANY); // will return a File object directly from the selected file
  return filePath;
}

Future<List<int>> getFileBytes(String filePath) async {
  var file = File.fromUri(Uri.parse(filePath));
  var fileBytes = await file.readAsBytes();
  return fileBytes;
}

String getFileNameFromPath(String filePath) {
  int fileNameStartIndex = filePath.lastIndexOf("/") + 1;
  return filePath.substring(fileNameStartIndex, filePath.length);
}
