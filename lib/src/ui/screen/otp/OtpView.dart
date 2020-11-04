import 'dart:async';
import 'dart:convert';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardFirstView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';

class OtpView extends StatefulWidget {
  String no_phone;

  OtpView({Key key, this.no_phone}) : super(key: key);

  @override
  _OtpViewState createState() => _OtpViewState();
}

class _OtpViewState extends State<OtpView> {
  bool _clickForgot = true;
  bool _visibiliySend = false;
  int countdown = 50;

  void startTimer() {
    Future.delayed(Duration(seconds: 2), () {
      setState(() {
        if (countdown >= 1) {
          countdown--;
          _visibiliySend = false;
        } else {
          _visibiliySend = true;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
  }

  void _toggleButtonForgot() async {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    bool status = await bloc.getCheckKolam();
    print(status);
    Navigator.of(context).pop();
    if (status) {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              // duration: Duration(microseconds: 1000),
              child: DashboardFirstView()));
    } else {
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              // duration: Duration(microseconds: 1000),
              child: DashboardView()));
    }

  }

  @override
  Widget build(BuildContext context) {
    startTimer();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
      child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
      body: Container(
          child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarContainer(context, "Kode OTP", LoginView(),Colors.white),
          Container(
              margin: EdgeInsets.only(
                  top: SizeConfig.blockVertical * 3  ,
                  left: SizeConfig.blockVertical * 4,
                  right: SizeConfig.blockVertical * 4),
              child: Text(
                "Periksa Pesan Anda",
                style: h3,
              )),
          Container(
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 4,
                right: SizeConfig.blockVertical * 4),
            child: RichText(
                textAlign: TextAlign.left,
                text: TextSpan(children: <TextSpan>[
                  TextSpan(
                    text: "kode OTP sudah terkirim ke  ",
                    style: caption.copyWith(color: greyTextColor),
                  ),
                  TextSpan(
                    text: widget.no_phone,
                    style: caption.copyWith(color: Colors.black),
                  ),
                  TextSpan(
                    text: " masukkan kode tersebut ke dalam form dibawah ini",
                    style: caption.copyWith(color: greyTextColor),
                  ),
                ])),
          ),
          Container(
            margin: EdgeInsets.only(left: 30.0, right: 30.0, top: 15.0),
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
                  highlightColor: colorPrimary,
                  //Replace with actual colors
                  color: _clickForgot ? colorPrimary : editTextBgColor,
                  onPressed: () => {_toggleButtonForgot()},
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
              child: Column(
                children: [
                  Visibility(
                      visible: _visibiliySend == false ? true:false,
                      child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(children: <TextSpan>[
                            TextSpan(
                              text: "Mohon Tunggu dalam ",
                              style: body2.copyWith(color: greyTextColor),
                            ),
                            TextSpan(
                              text: countdown.toString(),
                              style: body2.copyWith(color: Colors.black),
                            ),
                            TextSpan(
                              text: " Detik untuk dikirim ulang",
                              style: body2.copyWith(color: greyTextColor),
                            ),
                          ]))),

                  Visibility(
                      visible: _visibiliySend == false ? false:true,
                      child: Center(
                        child: Text(
                          "Kirim Ulang",
                          style: body2.copyWith(color: colorPrimary),
                        ),
                      )),
                ],
              )),
        ],
      ))),
    );
  }
}
