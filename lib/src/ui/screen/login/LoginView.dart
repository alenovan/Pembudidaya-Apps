import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotPasswordView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = true;
  bool _clickLogin = true;
  bool _statusLogin = false;
  TextEditingController nohpController = new TextEditingController();
  TextEditingController sandiController = new TextEditingController();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleButtonLogin() async {
    var status = await bloc.funLogin(nohpController.text.toString());
    print(status);
    if(status){
      setState(() {
        _statusLogin = false;
      });
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: OtpView()));
    }else{
      setState(() {
        _statusLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    GestureDetector gspassword = GestureDetector(
        onTap: () {
          _togglevisibility();
        },
        child: Icon(
          _showPassword ? Icons.visibility : Icons.visibility_off,
          color: greyIconColor,
        ));
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
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
                      height: SizeConfig.blockHorizotal * 50,
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
                                  left: SizeConfig.blockVertical * 3),
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Logo(context),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleLoginText,
                            style: TextStyle(
                                color: blackTextColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'poppins',
                                letterSpacing: 0.25,
                                fontSize: titleLogin),
                          ),
                          Text(
                            subTitleLoginText,
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
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          top: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: nohpController,
                            decoration: EditTextDecorationNumber(
                                context, "Nomor Handphone"),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: subTitleLogin),
                          ),
                        ],
                      ),
                    ),
                    Visibility(
                      visible: _statusLogin? true : false,
                      child:  Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 3),
                        child: Text(
                          "Nomor handphone anda belum terdaftar",
                          style: TextStyle(
                              color: Colors.red,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 12.0),
                        ),
                      ),
                    ),

                    Container(
                      height: 45.0,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3,
                          top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 30.0,
                          child: RaisedButton(
                            highlightColor:
                                colorPrimary, //Replace with actual colors
                            color: _clickLogin ? colorPrimary : editTextBgColor,
                            onPressed: () => _toggleButtonLogin(),
                            child: Text(
                              buttonLoginText,
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
                    Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 3),
                        child: new Align(
                            alignment: FractionalOffset.centerLeft,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  "Belum punya akun ?",
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
                                              type: PageTransitionType.fade,
                                              // duration: Duration(microseconds: 100),
                                              child: RegisterView()));
                                    },
                                    child: Text(
                                      " Daftar",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          color: colorPrimary,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.25,
                                          fontSize: subTitleLogin),
                                    ))
                              ],
                            )))
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
                            "Hubungi admin ?",
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
                                        type: PageTransitionType.fade,
                                        // duration: Duration(microseconds: 100),
                                        child: RegisterView()));
                              },
                              child: Text(
                                " Klik Disini",
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
        ));
  }
}
