import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_statusbarcolor/flutter_statusbarcolor.dart';
import 'package:flutter/services.dart';

class StatusBarColor extends StatefulWidget {
  StatusBarColor({Key key}) : super(key: key);

  @override
  _StatusBarColorState createState() => _StatusBarColorState();
}

class _StatusBarColorState extends State<StatusBarColor> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    FlutterStatusbarcolor.setStatusBarColor(Colors.black);
    FlutterStatusbarcolor.setStatusBarWhiteForeground(false);
    return Scaffold(
      appBar: AppBar(
        title: Text("aaa"),
      ),
      body: Text("aaa"),
    );
  }

}
