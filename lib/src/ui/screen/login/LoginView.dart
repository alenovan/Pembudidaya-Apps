import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotPasswordView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:toast/toast.dart';

class LoginView extends StatefulWidget {
  const LoginView({Key key}) : super(key: key);

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  bool _showPassword = true;
  bool _clickLogin = true;
  ProgressDialog pr;
  bool _statusLogin = false;
  TextEditingController nohpController = new TextEditingController();
  TextEditingController sandiController = new TextEditingController();
  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleButtonLogin() async {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    var status = await bloc.funLogin(nohpController.text.toString());
    if(status){
      setState(() {
        _statusLogin = false;
      });
      Navigator.of(context).pop();
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: OtpView(
                no_phone: nohpController.text.toString(),
              )));
    }else{
      Navigator.of(context).pop();
      setState(() {
        _statusLogin = true;
      });
    }

  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
    child:Scaffold(
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
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleLoginText,
                            style:h1,
                          ),
                          Text(
                            subTitleLoginText,
                            style: caption,
                          )
                        ],
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
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
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
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
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
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
                        transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 3),
                        child: new Align(
                            alignment: FractionalOffset.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Belum punya akun ?",
                                  style: body2,
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
                                      style: body2.copyWith(color: colorPrimary),
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
                            style: body2,
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
        )));
  }
}
