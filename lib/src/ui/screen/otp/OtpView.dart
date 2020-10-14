import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardFirstView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
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

class OtpView extends StatefulWidget {
  OtpView({Key key}) : super(key: key);

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
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
            child: DashboardFirstView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppbarForgot(context, appBarOtp, LoginView(),Colors.white),
      body: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  child: TitleText(context, titleVerifForgotPassword, textAppBar,
                      30.0, 20.0, 30.0, 0.0)),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 5.0),
                child:RichText(
                    textAlign: TextAlign.left,
                    text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: "kode OTP sudah terkirim ke  ",
                        style: TextStyle(
                            color: greyTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.25,
                            fontSize: 14.0),
                      ),
                      TextSpan(
                        text: "081229976213",
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'lato',
                            letterSpacing: 0.25,
                            fontSize: 14.0),
                      ),TextSpan(
                        text: " masukkan kode tersebut ke dalam form dibawah ini",
                        style: TextStyle(
                            color: greyTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.25,
                            fontSize: 14.0),
                      ),
                    ])),
              ),
              Container(
                margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
                child: Center(
                  child: Container(
                    width: 200.0,
                    padding: EdgeInsets.only(left: 30.0, right: 30.0),
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      maxLength: 4,
                      decoration:
                      EditTextDecorationText(context, "____", 0, 0, 0, 0),
                      keyboardType: TextInputType.number,
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: 'lato',
                          letterSpacing: 10,
                          fontSize: subTitleLogin),
                    ),
                  ),
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
                        "Verif",
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
              Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 10,
                      top: SizeConfig.blockVertical * 3,
                      right: SizeConfig.blockVertical * 10),
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: "Mohon Tunggu dalam ",
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.25,
                              fontSize: 14.0),
                        ),
                        TextSpan(
                          text: "50",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              letterSpacing: 0.25,
                              fontSize: 14.0),
                        ),TextSpan(
                          text: " Detik untuk dikirim ulang",
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.25,
                              fontSize: 14.0),
                        ),
                      ]))),
            ],
          )),
    );
  }
}
