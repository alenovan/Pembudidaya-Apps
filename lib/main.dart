import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotPasswordView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/splash/SplashScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/AuthLoadingScreen.dart';

void main() async {
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);

  runApp(new MaterialApp(
    theme: ThemeData(
      accentColor: colorPrimary,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      //change the color for CircularProgressIndicator color here
    ),
    home: SplashScreen(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lelenesia',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: ForgotVerifView(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Text("aaa");
  }
}
