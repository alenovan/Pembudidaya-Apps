import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class ForgotResetView extends StatefulWidget {
  @override
  _ForgotResetViewState createState() => _ForgotResetViewState();
}

class _ForgotResetViewState extends State<ForgotResetView> {
  bool _showPassword = true;
  bool _showRePassword = true;
  bool _clickLogin = true;
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleButtonLogin() {
    setState(() {
      _clickLogin = !_clickLogin;
    });
  }

  void _togglevisibilityRePassword() {
    setState(() {
      _showRePassword = !_showRePassword;
    });
  }

  bool _clickForgot = true;
  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            // duration: Duration(microseconds: 1000),
            child: LoginView()));
  }

  @override
  Widget build(BuildContext context) {
    GestureDetector gsRepassword = GestureDetector(
        onTap: () {
          _togglevisibilityRePassword();
        },
        child: Icon(
          _showRePassword ? Icons.visibility : Icons.visibility_off,
          color: greyIconColor,
        ));
    GestureDetector gspassword = GestureDetector(
        onTap: () {
          _togglevisibility();
        },
        child: Icon(
          _showPassword ? Icons.visibility : Icons.visibility_off,
          color: greyIconColor,
        ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: colorPrimary,
    ));
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      appBar: AppbarForgot(context, appBarForgotPassword, LoginView(),Colors.white),
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(top: 20.0),
            child: TitleText(context, titleResetForgotPassword, textAppBar,
                30.0, 20.0, 30.0, 0.0),
          ),
          Container(
            // transform: Matrix4.translationValues(0.0, -20.0, 0.0),
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 3,
                right: SizeConfig.blockVertical * 3,
                top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  obscureText: _showPassword,
                  decoration: EditTextPaswordDecoration(
                      context, "Password", gspassword),
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: 'lato',
                      letterSpacing: 0.4,
                      fontSize: subTitleLogin),
                ),
                Visibility(
                    visible: false,
                    child: Container(
                        margin: EdgeInsets.only(left: 20.0, top: 5.0),
                        child: Text(
                          passwordValidasiText,
                          style: TextStyle(
                              color: redTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: textValdaisiDaftar),
                        )))
              ],
            ),
          ),
          Container(
            // transform: Matrix4.translationValues(0.0, -10.0, 0.0),
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 3,
                right: SizeConfig.blockVertical * 3,
                top: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  obscureText: _showRePassword,
                  decoration: EditTextPaswordDecoration(
                      context, "Ulangi Password", gsRepassword),
                  keyboardType: TextInputType.visiblePassword,
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: 'lato',
                      letterSpacing: 0.4,
                      fontSize: subTitleLogin),
                ),
                Visibility(
                  visible: false,
                  child: Container(
                      margin: EdgeInsets.only(left: 20.0, top: 10.0),
                      child: Text(
                        rePasswordValidasiText,
                        style: TextStyle(
                            color: redTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: textValdaisiDaftar),
                      )),
                )
              ],
            ),
          ),
          Container(
            height: 45.0,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 3,
                right: SizeConfig.blockVertical * 3,
                top: 15.0),
            child: CustomElevation(
                height: 30.0,
                child: RaisedButton(
                  highlightColor: colorPrimary, //Replace with actual colors
                  color: _clickForgot ? colorPrimary : editTextBgColor,
                  onPressed: () => _toggleButtonForgot(),
                  child: Text(
                    "KIRIM",
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
