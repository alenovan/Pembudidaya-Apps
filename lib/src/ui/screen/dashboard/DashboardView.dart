import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LoginBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotPasswordView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/register/RegisterView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
    // setState(() {

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
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    CircleAvatar(
                                      radius: 40,
                                      backgroundColor: greyLineColor,
                                      child: CircleAvatar(
                                        radius: 40,
                                        backgroundImage: NetworkImage(
                                            'https://via.placeholder.com/150'),
                                        backgroundColor: Colors.transparent,
                                      ),
                                    )
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      height: 45.0,
                      width: 150.0,
                      transform: Matrix4.translationValues(0.0, -60.0, 0.0),
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 4,
                          right: SizeConfig.blockVertical * 4),
                      child: CustomElevation(
                          height: 30.0,
                          child: RaisedButton(
                            highlightColor:
                            colorPrimary, //Replace with actual colors
                            color: _clickLogin ? colorPrimary : editTextBgColor,
                            onPressed: () => _toggleButtonLogin(),
                            child: Text(
                              "Tambah",
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
              left: SizeConfig.blockVertical * 4,
              right: SizeConfig.blockVertical * 4,
              bottom: SizeConfig.blockVertical * 10),
          transform: Matrix4.translationValues(0.0, -50.0, 0.0),
          height: MediaQuery.of(context).size.height,
          child: ListView.builder(
            scrollDirection: Axis.vertical,
            itemCount: 4,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: (){
                  if(index == 1){
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: LaporanMain(page:0,laporan_page:"home")));
                  }else{
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: TambahKolam()));
                  }

                },
                child:Container(
                  child: CardKolam(context,"Kolam lele MK0000"+index.toString(),"Pilih untuk lihat detail",index),

                )
              );
            },
          )),

                  ],
                ),
              ),
            ),

          ],
        ));
  }
}
