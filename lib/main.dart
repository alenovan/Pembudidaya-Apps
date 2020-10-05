import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotPasswordView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/TabsPageLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:device_preview/device_preview.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';

// end

// void main() => runApp(
//       DevicePreview(
//         enabled: !kReleaseMode,
//         builder: (context) => MyApp(),
//       ),
//     );

void main() {
  runApp(MaterialApp(initialRoute: '/', routes: <String, WidgetBuilder>{
    '/': (context) => LoginView(),
    '/forgot': (context) => ForgotPasswordView(),
    '/forgotreset': (context) => ForgotResetView(),
    '/forgotverif': (context) => ForgotVerifView(),
    '/register': (context) => RegisterView(),
    '/pagelaporan': (context) => TabsPageLaporan(),
  }));
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
    return null;
  }
}
