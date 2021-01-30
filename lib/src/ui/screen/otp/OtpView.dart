import 'dart:async';
import 'dart:ui';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardFirstView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/ImagesSvg.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
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
    LoadingDialog.show(context);
    bool status = await bloc.getCheckKolam();
    AppExt.popScreen(context);
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
    ScreenUtil.instance = ScreenUtil()..init(context);
    startTimer();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
      child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: DashboardView()))
              },
            ),
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Kode OTP",
              style: h3.copyWith(color: Colors.black,  fontSize: ScreenUtil(
                  allowFontScaling:
                  false)
                  .setSp(50)),
            ),
          ),
      body: Container(
          transform: Matrix4.translationValues(0.0, -ScreenUtil().setHeight(40), 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Align(
              alignment: Alignment.center,
              child: OtpImage(context)),
           Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(60),
                  right: ScreenUtil().setWidth(60)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                      alignment: Alignment.centerLeft,
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(60),
                          right: ScreenUtil().setWidth(60)),
                      child: Text(
                        "Periksa sms anda",
                        style: h3.copyWith(fontWeight: FontWeight.w500 ,  fontSize: ScreenUtil(
                            allowFontScaling:
                            false)
                            .setSp(60)),
                      )),
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(60),
                        right: ScreenUtil().setWidth(60)),
                    child: RichText(
                        textAlign: TextAlign.left,
                        text: TextSpan(children: <TextSpan>[
                          TextSpan(
                            text: "Kode OTP sudah terkirim ke  ",
                            style: caption.copyWith(color: greyTextColor,fontSize: ScreenUtil(
                                allowFontScaling:
                                false)
                                .setSp(35)),
                          ),
                          TextSpan(
                            text: widget.no_phone,
                            style: caption.copyWith(color: Colors.black,fontSize: ScreenUtil(
                                allowFontScaling:
                                false)
                                .setSp(35)),
                          ),
                          TextSpan(
                            text: " masukkan kode tersebut ke dalam form dibawah ini",
                            style: caption.copyWith(color: greyTextColor,fontSize: ScreenUtil(
                                allowFontScaling:
                                false)
                                .setSp(35)),
                          ),
                        ])),
                  ),
                  Container(
                    margin: EdgeInsets.only(left: ScreenUtil().setWidth(60), right: ScreenUtil().setWidth(60), top: ScreenUtil().setHeight(60)),
                    child: Center(
                      child: Container(
                        width: ScreenUtil().setWidth(500),
                        padding: EdgeInsets.only(left: ScreenUtil().setWidth(50), right: ScreenUtil().setWidth(50)),
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
                              fontSize: ScreenUtil(
                                  allowFontScaling:
                                  true)
                                  .setSp(45)),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: ScreenUtil().setHeight(120),
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(70),
                        top: ScreenUtil().setHeight(60)),
                    child: CustomElevation(
                        height: ScreenUtil().setHeight(120),
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: _clickForgot ? colorPrimary : editTextBgColor,
                          onPressed: () => {_toggleButtonForgot()},
                          child: Text(
                            "Lanjutkan",
                            style: TextStyle(
                                color: _clickForgot ? backgroundColor : blackTextColor,
                                fontWeight: FontWeight.w700,
                                fontFamily: 'poppins',
                                letterSpacing: 1.25,
                                fontSize: ScreenUtil(
                                    allowFontScaling:
                                    true)
                                    .setSp(45)),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        )),
                  ),
                  Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(60),
                          top: ScreenUtil().setHeight(60),
                          right: ScreenUtil().setWidth(60)),
                      child: Column(
                        children: [
                          Visibility(
                              visible: _visibiliySend == false ? true:false,
                              child: RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(children: <TextSpan>[
                                    TextSpan(
                                      text: "Mohon Tunggu dalam ",
                                      style: body2.copyWith(color: greyTextColor,  fontSize: ScreenUtil(
                                          allowFontScaling:
                                          true)
                                          .setSp(45)),
                                    ),
                                    TextSpan(
                                      text: countdown.toString(),
                                      style: body2.copyWith(color: Colors.black,  fontSize: ScreenUtil(
                                          allowFontScaling:
                                          true)
                                          .setSp(45)),
                                    ),
                                    TextSpan(
                                      text: " Detik untuk dikirim ulang",
                                      style: body2.copyWith(color: greyTextColor,  fontSize: ScreenUtil(
                                          allowFontScaling:
                                          true)
                                          .setSp(45)),
                                    ),
                                  ]))),

                          Visibility(
                              visible: _visibiliySend == false ? false:true,
                              child: Center(
                                child: Text(
                                  "Kirim Ulang",
                                  style: body2.copyWith(color: colorPrimary,  fontSize: ScreenUtil(
                                      allowFontScaling:
                                      true)
                                      .setSp(45)),
                                ),
                              )),
                        ],
                      )),
                ],
              )),

        ],
      ))),
    );
  }
}
