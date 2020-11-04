import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void hideKeyboard(context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

void popScreen(BuildContext context, [dynamic data]) {
  Navigator.pop(context, data);
}

enum RouteTransition { slide, dualSlide, fade, material, cupertino }


Future pushScreenAndWait(BuildContext context, Widget buildScreen) async {
  await Navigator.push(
      context, CupertinoPageRoute(builder: (context) => buildScreen));
  return;
}

// launchScreen(context, String tag, {Object arguments}) {
//   if (arguments == null) {
//     Navigator.pushNamed(context, tag);
//   } else {
//     Navigator.pushNamed(context, tag, arguments: arguments);
//   }
// }

// void launchScreenWithNewTask(context, String tag) {
//   Navigator.pushNamedAndRemoveUntil(context, tag, (r) => false);
// }

Color hexStringToHexInt(String hex) {
  hex = hex.replaceFirst('#', '');
  hex = hex.length == 6 ? 'ff' + hex : hex;
  int val = int.parse(hex, radix: 16);
  return Color(val);
}
/*
String parseHtmlString(String htmlString) {
  return parse(parse(htmlString).body.text).documentElement.text;
}*/

Color computeTextColor(Color color) {
  return color.computeLuminance() > 0.5 ? Colors.black : Colors.white;
}