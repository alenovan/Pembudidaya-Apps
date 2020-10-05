import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class RegisterView extends StatefulWidget {
  RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
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

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

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
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                new Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          // color: Colors.red,
                          height: SizeConfig.blockHorizotal * 60,
                          width: double.infinity,
                          child: Stack(
                            children: [
                              Container(
                                  child: Align(
                                alignment: Alignment.topRight,
                                child: RightLiquid(context),
                              )),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 5),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Logo(context),
                                  )),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5),
                          transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                titleDaftarText,
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'poppins',
                                    letterSpacing: 0.25,
                                    fontSize: titleLogin),
                              ),
                              Text(
                                subTitleDaftarText,
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: 'lato',
                                    letterSpacing: 0.4,
                                    fontSize: subTitleLogin),
                              )
                            ],
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -40.0, 0.0),
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5),
                          child: TextFormField(
                            decoration: EditTextDecorationText(
                                context, "Nama", 20.0, 0, 0, 0),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: subTitleLogin),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -30.0, 0.0),
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5),
                          child: TextFormField(
                            decoration: EditTextDecorationNumber(
                                context, "Nomor Handphone"),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: subTitleLogin),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5),
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
                                      margin:
                                          EdgeInsets.only(left: 20.0, top: 5.0),
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
                          transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5),
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
                                    margin:
                                        EdgeInsets.only(left: 20.0, top: 10.0),
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
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5,
                              top: 5.0),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: oneDaftarText,
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: textSyaratTitleDaftar),
                                ),
                                TextSpan(
                                  text: twoDaftarText,
                                  style: TextStyle(
                                      color: purpleTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: textSyaratTitleDaftar),
                                ),
                                TextSpan(
                                  text: danDaftarText,
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: textSyaratTitleDaftar),
                                ),
                                TextSpan(
                                  text: threeDaftarText,
                                  style: TextStyle(
                                      color: purpleTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: textSyaratTitleDaftar),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          height: 45.0,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5,
                              top: 10.0),
                          child: CustomElevation(
                              height: 30.0,
                              child: RaisedButton(
                                highlightColor:
                                    colorPrimary, //Replace with actual colors
                                color: _clickLogin
                                    ? colorPrimary
                                    : editTextBgColor,
                                onPressed: () => _toggleButtonLogin(),
                                child: Text(
                                  buttonDaftarText,
                                  style: TextStyle(
                                      color: _clickLogin
                                          ? backgroundColor
                                          : blackTextColor,
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
                    ),
                  ),
                ),
                new Positioned(
                  child: Container(
                      margin: EdgeInsets.only(bottom: 20.0),
                      child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                bottomOneText,
                                style: TextStyle(
                                    color: greyTextColor,
                                    fontFamily: 'lato',
                                    letterSpacing: 0.4,
                                    fontSize: subTitleLogin),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type:
                                                PageTransitionType.rightToLeft,
                                            child: LoginView()));
                                  },
                                  child: Text(
                                    bottomTwoText,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: colorPrimary,
                                        fontFamily: 'lato',
                                        letterSpacing: 0.25,
                                        fontSize: subTitleLogin),
                                  ))
                            ],
                          ))),
                )
              ],
            )));
  }

  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft, child: LoginView()));
  }
}
