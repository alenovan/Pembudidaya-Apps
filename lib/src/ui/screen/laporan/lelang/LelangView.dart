import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/TambahLelang.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class LelangView extends StatefulWidget {
  final String idKolam;
  final String halaman;
  LelangView({Key key, this.idKolam, this.halaman}) : super(key: key);

  @override
  _LelangViewState createState() => _LelangViewState();
}

class _LelangViewState extends State<LelangView> {
  bool _showDetail = true;

  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
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
            actions: <Widget>[

            ],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Lelang",
              style: h3,
            ),
          ),
          body: Column(
            children: [
              // AppBarContainer(context, "Lelang", DashboardView(), Colors.white),
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 3,
                      right: SizeConfig.blockVertical * 3),
                  child: Column(
                    children: [
                      Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockVertical * 3,
                          ),
                          child: CustomElevation(
                              height: 40.0,
                              child: RaisedButton(
                                highlightColor: colorPrimary,
                                //Replace with actual colors
                                color: colorPrimary,
                                onPressed: () => {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          // duration: Duration(microseconds: 1000),
                                          child: TambahLelang()))
                                },
                                child: Text(
                                  "Lelang",
                                  style: subtitle2.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700),
                                ),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              ))),
                      Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 3,
                              left: SizeConfig.blockHorizotal * 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lelang Berlangsung",
                              style: subtitle2,
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 3,
                        ),
                        child: Column(
                          children: [
                            CardLelangBerlangsung(context,
                                "Lele catfish blackie", "09 Juni 2012"),
                          ],
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 3,
                              left: SizeConfig.blockHorizotal * 2),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "History Lelang",
                              style: subtitle2,
                            ),
                          )),
                      Container(
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 3,
                        ),
                        child: Column(
                          children: [
                            CardLelang(context, "Lele catfish blackie",
                                "180.000", "09 Juni 2012"),
                            CardLelang(context, "Lele catfish blackie",
                                "180.000", "09 Juni 2012"),
                          ],
                        ),
                      )
                    ],
                  ))
            ],
          )),
    );
  }
}
