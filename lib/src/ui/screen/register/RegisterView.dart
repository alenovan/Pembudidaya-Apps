import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/Models/RegisterModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/RegisterBloc.dart';
import 'package:lelenesia_pembudidaya/src/resource/Repository.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:progress_dialog/progress_dialog.dart';

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
    var  dialogContext = Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    var data = await bloc.funRegister(
        namaController.text.toString(), nohpController.text.toString());
    var status = data['status'];

    setState(() {
      nama = data['data']['nama'].toString() == "null" ? " " : data['data']['nama'].toString();
      phone =
          data['data']['phone'].toString() == "null" ? " " : data['data']['phone'].toString();
    });
    print(status);
    if (status == 1) {
      showDialog(
        context: context,
        builder: (BuildContext context) => AlertSuccess(context, LoginView()),
      );
      Timer(const Duration(seconds: 2), () {
        Navigator.push(context,
            PageTransition(type: PageTransitionType.fade, child: LoginView()));
      });
    } else if (status == 2) {
      var message  = data['data']['message'].toString();
      Navigator.of(context).pop();
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: message);
    }else{
      Navigator.of(context).pop();
    }

  }

  @override
  Widget build(BuildContext context) {
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
                          height: SizeConfig.blockHorizotal * 40,
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
                                titleDaftarText,
                                style: h1,
                              ),
                              Text(
                                subTitleDaftarText,
                                style: caption,
                              )
                            ],
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 3,
                              top: SizeConfig.blockVertical * 3,
                              right: SizeConfig.blockVertical * 3),
                          child: TextFormField(
                            controller: namaController,
                            decoration: EditTextDecorationText(
                                context, "Nama", 20.0, 0, 0, 0),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: subTitleLogin),
                          ),
                        ),
                        // Visibility(
                        //   visible: nama != "-" ? true : false,
                        //   child: Container(
                        //     margin: EdgeInsets.only(
                        //         left: SizeConfig.blockVertical * 5,
                        //         top: SizeConfig.blockVertical * 1,
                        //         right: SizeConfig.blockVertical * 3),
                        //     child: Text(
                        //       nama,
                        //       style: TextStyle(
                        //           color: Colors.red,
                        //           fontFamily: 'lato',
                        //           letterSpacing: 0.4,
                        //           fontSize: 12.0),
                        //     ),
                        //   ),
                        // ),
                        Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 3,
                              top: SizeConfig.blockVertical * 2,
                              right: SizeConfig.blockVertical * 3),
                          child: TextFormField(
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
                        ),
                        Visibility(
                          visible: phone!="-" ? true : false,
                          child: Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 3),
                            child: Text(
                              phone,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 12.0),
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockHorizotal * 3,
                            right: SizeConfig.blockVertical * 3,
                          ),
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
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 2,
                          ),
                          child: CustomElevation(
                              height: 30.0,
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
                                            type: PageTransitionType.fade,
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
    Navigator.push(context,
        PageTransition(type: PageTransitionType.fade, child: LoginView()));
  }


}
