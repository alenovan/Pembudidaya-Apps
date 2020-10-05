import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';

class LoginWidget extends StatelessWidget {
  const LoginWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

// ignore: non_constant_identifier_names
Widget AppbarForgot(BuildContext context, String title, Widget page) {
  SizeConfig().init(context);
  final Widget appBar = AppBar(
    backgroundColor: Colors.transparent,
    elevation: 0.0,
    title: Container(
        margin: EdgeInsets.only(
          top: 30.0,
        ),
        child: Text(
          title,
          style: TextStyle(
              color: appBarTextColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins',
              letterSpacing: 0.15,
              fontSize: textAppBar),
        )),
    leading: Container(
        margin: EdgeInsets.only(top: 30.0, left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: page));
            /* Write listener code here */
          },
          child: IconTheme(
            data: IconThemeData(color: appBarTextColor),
            child: Icon(Icons.arrow_back),
          ),
        )),
  );
  return appBar;
}

Widget TitleText(BuildContext context, String title, double sizex, double leftx,
    double rightx, double topx, double bottomx) {
  SizeConfig().init(context);
  final Widget titlex = Container(
    margin:
        EdgeInsets.only(left: leftx, right: rightx, top: topx, bottom: bottomx),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: blackTextColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins',
              fontSize: sizex),
        ),
      ],
    ),
  );
  ;
  return titlex;
}
