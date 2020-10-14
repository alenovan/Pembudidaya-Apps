import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class DashboardFirstView extends StatefulWidget {
  const DashboardFirstView({Key key}) : super(key: key);

  @override
  _DashboardFirstViewState createState() => _DashboardFirstViewState();
}

class _DashboardFirstViewState extends State<DashboardFirstView> {
  bool _showPassword = true;
  bool _clickLogin = true;
  TextEditingController nohpController = new TextEditingController();
  TextEditingController sandiController = new TextEditingController();

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleButtonLogin() {

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
                            alignment: Alignment.topLeft,
                            child: LeftLiquid(context),
                          )),
                          Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockVertical * 3,
                                  right: SizeConfig.blockVertical * 3,
                                  bottom: SizeConfig.blockVertical * 3),
                              child: Align(
                                alignment: Alignment.topRight,
                                child: CircleAvatar(
                                  radius: 40,
                                  backgroundColor: greyLineColor,
                                  child: CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                        'https://via.placeholder.com/150'),
                                    backgroundColor: Colors.transparent,
                                  ),
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            bottom: SizeConfig.blockVertical * 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: DetailNull(context)),
                            Text(
                              textNullFirst,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'poppins',
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.25,
                                  fontSize: 18.0),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockVertical * 3),
                              child: Text(
                                subTextNullFirst,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontFamily: 'poppins',
                                    letterSpacing: 0.25,
                                    fontSize: 14.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 10.0),
                              child: Center(
                                child: Container(
                                  width: 200.0,
                                  padding:
                                      EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: TextFormField(
                                    textAlign: TextAlign.center,
                                    decoration: EditTextDecorationText(
                                        context, "", 0, 0, 0, 0),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'lato',
                                        fontSize: subTitleLogin),
                                  ),
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
                                    highlightColor: colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            Alertquestion(context,DashboardView()),
                                      )
                                    },
                                    child: Text(
                                      "Buat Kolam",
                                      style: TextStyle(
                                          color: backgroundColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'poppins',
                                          letterSpacing: 1.25,
                                          fontSize: subTitleLogin),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ],
                ),
              ),
            ),
          ],
        ));
  }
}
