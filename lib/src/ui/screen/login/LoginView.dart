import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;

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
    LoadingDialog.show(context);
    var status = await bloc.funLogin(nohpController.text.toString());
    if (status) {
      setState(() {
        _statusLogin = false;
      });
      AppExt.popScreen(context);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: OtpView(
                no_phone: nohpController.text.toString(),
              )));
    } else {
      AppExt.popScreen(context);
      setState(() {
        _statusLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    SizeConfig().init(context);
    SystemChrome.setSystemUIOverlayStyle(
        SystemUiOverlayStyle(statusBarColor: Colors.transparent));
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            resizeToAvoidBottomPadding: false,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(70),
                    bottomRight: Radius.circular(70),
                  ),
                  child: Image.asset(
                    "assets/png/login_background.png",
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: ScreenUtil().setHeight(1400),
                  ),
                ),
                new Positioned(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(120),
                          ),
                          width: double.infinity,
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(60),
                                      top: ScreenUtil().setHeight(50)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LogoPanen(context, colorPrimary),
                                  )),
                              Spacer(),
                              Image.asset(
                                "assets/logo/logo_polinema.png",
                                height: ScreenUtil().setWidth(150),
                                width: ScreenUtil().setWidth(150),
                              ),
                              SizedBox(
                                width: ScreenUtil().setWidth(60),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(250),
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child: Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                  ScreenUtil().setHeight(60)),
                            ),
                            child: Container(
                              child: Container(
                                padding: EdgeInsets.only(
                                    top: ScreenUtil().setHeight(80),
                                    bottom: ScreenUtil().setHeight(80)),
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(60),
                                    right: ScreenUtil().setWidth(60)),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      "assets/logo/logo_panenIkan.png",
                                      height: ScreenUtil().setWidth(100),
                                      // width: ScreenUtil().setWidth(150),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(50),
                                    ),
                                    Text(
                                      titleLoginText,
                                      style: h1.copyWith(
                                          fontSize: ScreenUtil(
                                                  allowFontScaling: false)
                                              .setSp(80)),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(20),
                                      ),
                                      child: Text(
                                        subTitleLoginText,
                                        style: caption.copyWith(
                                            fontSize: ScreenUtil(
                                                    allowFontScaling: false)
                                                .setSp(40),
                                            color: greyTextColor),
                                      ),
                                    ),
                                    Container(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(50),
                                                bottom:
                                                    ScreenUtil().setHeight(30)),
                                            child: Text(
                                              "Nomor Handphone",
                                              style: body2.copyWith(
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                              false)
                                                      .setSp(40)),
                                            ),
                                          ),
                                          TextFormField(
                                            controller: nohpController,
                                            decoration:
                                                EditTextDecorationNumber(
                                                    context, "Nomor Handphone"),
                                            keyboardType: TextInputType.number,
                                            style: TextStyle(
                                                color: blackTextColor,
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontSize: ScreenUtil(
                                                        allowFontScaling: false)
                                                    .setSp(45)),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Visibility(
                                      visible: _statusLogin ? true : false,
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(60),
                                            top: ScreenUtil().setHeight(30),
                                            right: ScreenUtil().setWidth(60)),
                                        child: Text(
                                          "Nomor handphone anda belum terdaftar",
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontFamily: 'lato',
                                              letterSpacing: 0.4,
                                              fontSize: ScreenUtil(
                                                      allowFontScaling: true)
                                                  .setSp(45)),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: ScreenUtil().setHeight(50),
                                    ),
                                    Container(
                                      transform: Matrix4.translationValues(0.0,
                                          -ScreenUtil().setHeight(40), 0.0),
                                      height: ScreenUtil().setHeight(110),
                                      width: MediaQuery.of(context).size.width,
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(50)),
                                      child: CustomElevation(
                                          height: ScreenUtil().setHeight(110),
                                          child: RaisedButton(
                                            highlightColor: colorPrimary,
                                            //Replace with actual colors
                                            color: _clickLogin
                                                ? colorPrimary
                                                : editTextBgColor,
                                            onPressed: () =>
                                                _toggleButtonLogin(),
                                            child: Text(
                                              buttonLoginText,
                                              style: TextStyle(
                                                  color: _clickLogin
                                                      ? backgroundColor
                                                      : blackTextColor,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'poppins',
                                                  letterSpacing: 1.25,
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                              true)
                                                      .setSp(45)),
                                            ),
                                            shape: new RoundedRectangleBorder(
                                              borderRadius:
                                                  new BorderRadius.circular(
                                                      30.0),
                                            ),
                                          )),
                                    ),
                                    Container(
                                        transform: Matrix4.translationValues(
                                            0.0,
                                            -ScreenUtil().setHeight(50),
                                            0.0),
                                        margin: EdgeInsets.only(
                                            left: ScreenUtil().setWidth(60),
                                            top: ScreenUtil().setHeight(50),
                                            right: ScreenUtil().setWidth(60)),
                                        child: new Align(
                                            alignment: FractionalOffset.center,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Belum punya akun ?",
                                                  style: body2.copyWith(
                                                      fontSize: ScreenUtil(
                                                              allowFontScaling:
                                                                  false)
                                                          .setSp(40)),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              // duration: Duration(microseconds: 100),
                                                              child:
                                                                  RegisterView()));
                                                    },
                                                    child: Text(
                                                      " Daftar",
                                                      style: body2.copyWith(
                                                          fontSize: ScreenUtil(
                                                                  allowFontScaling:
                                                                      false)
                                                              .setSp(40),
                                                          color: colorPrimary),
                                                    ))
                                              ],
                                            ))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            bottom: ScreenUtil().setHeight(50)),
                                        child: new Align(
                                            alignment:
                                                FractionalOffset.bottomCenter,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                Text(
                                                  "Hubungi admin ?",
                                                  style: body2.copyWith(
                                                      fontSize: ScreenUtil(
                                                              allowFontScaling:
                                                                  false)
                                                          .setSp(42)),
                                                ),
                                                InkWell(
                                                    onTap: () {
                                                      Navigator.push(
                                                          context,
                                                          PageTransition(
                                                              type:
                                                                  PageTransitionType
                                                                      .fade,
                                                              // duration: Duration(microseconds: 100),
                                                              child:
                                                                  RegisterView()));
                                                    },
                                                    child: Text(
                                                      " Klik Disini",
                                                      style: body2.copyWith(
                                                          fontSize: ScreenUtil(
                                                                  allowFontScaling:
                                                                      false)
                                                              .setSp(42),
                                                          color: colorPrimary),
                                                    ))
                                              ],
                                            )))
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )));
  }
}
