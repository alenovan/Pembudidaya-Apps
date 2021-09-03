import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/bloc/RegisterBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class RegisterView extends StatefulWidget {
  RegisterView({Key key}) : super(key: key);

  @override
  _RegisterViewState createState() => _RegisterViewState();
}

class _RegisterViewState extends State<RegisterView> {
  bool _clickLogin = true;
  ProgressDialog pr;
  var nama = " ";
  var phone = " ";
  TextEditingController nohpController = new TextEditingController();
  TextEditingController namaController = new TextEditingController();

  void _toggleButtonRegister() async {
    LoadingDialog.show(context);

    var data = await bloc.funRegister(
        namaController.text.toString(), nohpController.text.toString());
    var status = data['status'];

    setState(() {
      nama = data['data']['nama'].toString() == "null"
          ? " "
          : data['data']['nama'].toString();
      phone = data['data']['phone'].toString() == "null"
          ? " "
          : data['data']['phone'].toString();
    });
    print(status);
    if (status == 1) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context,
          title: "Selamat", description: "Selamat Pendaftaran anda berhasil");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(context,
            PageTransition(type: PageTransitionType.fade, child: LoginView()));
      });
    } else if (status == 2) {
      AppExt.popScreen(context);
      var message = data['data']['message'].toString();
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: message);
    } else {
      AppExt.popScreen(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    SizeConfig().init(context);
    pr = new ProgressDialog(context, type: ProgressDialogType.Normal);
    pr.style(
      message: 'Menunggu...',
      borderRadius: 10.0,
      backgroundColor: Colors.white,
      elevation: 10.0,
      insetAnimCurve: Curves.easeInOut,
      progress: 0.0,
      maxProgress: 100.0,
      progressTextStyle: TextStyle(
          color: Colors.black, fontSize: 13.0, fontWeight: FontWeight.w400),
      messageTextStyle: TextStyle(
          color: Colors.black, fontSize: 19.0, fontWeight: FontWeight.w600),
    );
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.white,
            body: Stack(
              children: [
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
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(60),
                                      top: ScreenUtil().setHeight(50)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Logo(context, colorPrimary),
                                  )),
                              Spacer(),
                              Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(60),
                                      top: ScreenUtil().setHeight(50)),
                                  child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: LogoPanen(context, Colors.white),
                                  )),
                              SizedBox(
                                width: ScreenUtil().setWidth(60),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(100),
                          ),
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
                                titleDaftarText,
                                style: h1.copyWith(
                                    fontSize:25.sp),
                              ),
                              Container(
                                child: Text(
                                  subTitleDaftarText,
                                  style: caption.copyWith(
                                      fontSize:15.sp,
                                      color: greyTextColor),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(50),
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child: TextFormField(
                            controller: namaController,
                            decoration: EditTextDecorationText(
                                context, "Nama", 20.0, 0, 0, 0),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: 15.sp),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(50),
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child: TextFormField(
                            controller: nohpController,
                            decoration: EditTextDecorationNumber(
                                context, "Nomor Handphone"),
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: 15.sp),
                          ),
                        ),
                        Visibility(
                          visible: phone != "-" ? true : false,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(50),
                                top: ScreenUtil().setHeight(50),
                                right: ScreenUtil().setWidth(50)),
                            child: Text(
                              phone,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 25.sp),
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(
                              0.0, -ScreenUtil().setHeight(40), 0.0),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: RichText(
                            text: TextSpan(
                              children: <TextSpan>[
                                TextSpan(
                                  text: oneDaftarText,
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize:
                                          15.sp),
                                ),
                                TextSpan(
                                  text: twoDaftarText,
                                  style: TextStyle(
                                      color: purpleTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize:
                                      15.sp),
                                ),
                                TextSpan(
                                  text: danDaftarText,
                                  style: TextStyle(
                                      color: greyTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize:
                                      15.sp),
                                ),
                                TextSpan(
                                  text: threeDaftarText,
                                  style: TextStyle(
                                      color: purpleTextColor,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize:
                                      15.sp),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          transform: Matrix4.translationValues(
                              0.0, -ScreenUtil().setHeight(50), 0.0),
                          height: 40.h,
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(60),
                              top: ScreenUtil().setHeight(50),
                              right: ScreenUtil().setWidth(60)),
                          child: CustomElevation(
                              height: 40.h,
                              child: RaisedButton(
                                highlightColor: colorPrimary,
                                //Replace with actual colors
                                color: _clickLogin
                                    ? colorPrimary
                                    : editTextBgColor,
                                onPressed: () => {_toggleButtonRegister()},
                                child: Text(
                                  buttonDaftarText,
                                  style: TextStyle(
                                      color: _clickLogin
                                          ? backgroundColor
                                          : blackTextColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'poppins',
                                      letterSpacing: 1.25,
                                      fontSize:15.sp),
                                ),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              )),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                bottomOneText,
                                style: body2.copyWith(
                                    fontSize: 15.sp),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: LoginView()));
                                  },
                                  child: Text(
                                    bottomTwoText,
                                    style: body2.copyWith(
                                        fontSize:15.sp,
                                        color: colorPrimary),
                                  ))
                            ],
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                          ),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text(
                                "Hubungi admin ? ",
                                style: body2.copyWith(
                                    fontSize: 15.sp),
                              ),
                              InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: LoginView()));
                                  },
                                  child: Text(
                                    "Klik Di Sini",
                                    style: body2.copyWith(
                                        fontSize:15.sp,
                                        color: colorPrimary),
                                  ))
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                // new Positioned(
                //   child: Container(
                //       margin: EdgeInsets.only(bottom: 20.0),
                //       child: new Align(
                //           alignment: FractionalOffset.bottomCenter,
                //           child:)),
                // )
              ],
            )));
  }

  Future<bool> _onBackPressed() {
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: LoginView()));
  }
}
