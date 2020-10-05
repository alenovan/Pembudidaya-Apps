import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class ForgotPasswordView extends StatefulWidget {
  ForgotPasswordView({Key key}) : super(key: key);

  @override
  _ForgotPasswordViewState createState() => _ForgotPasswordViewState();
}

class _ForgotPasswordViewState extends State<ForgotPasswordView> {
  bool _clickForgot = true;
  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.leftToRight,
            // duration: Duration(microseconds: 1000),
            child: ForgotVerifView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppbarForgot(context, appBarForgotPassword, LoginView()),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              margin: EdgeInsets.only(top: 20.0),
              child: TitleText(context, titleForgotPassword, textAppBar, 30.0,
                  20.0, 10.0, 0.0)),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 20.0, top: 10.0),
            child: TextFormField(
              decoration: EditTextDecorationNumber(context, "Nomor Handphone"),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: subTitleLogin),
            ),
          ),
          Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 5,
                right: SizeConfig.blockVertical * 5,
                top: 15.0),
            child: CustomElevation(
                height: 30.0,
                child: RaisedButton(
                  highlightColor: colorPrimary, //Replace with actual colors
                  color: _clickForgot ? colorPrimary : editTextBgColor,
                  onPressed: () => _toggleButtonForgot(),
                  child: Text(
                    buttonTextForgotPassword,
                    style: TextStyle(
                        color: _clickForgot ? backgroundColor : blackTextColor,
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        letterSpacing: 1.25,
                        fontSize: subTitleLogin),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
          ),
        ],
      )),
    );
  }
}
