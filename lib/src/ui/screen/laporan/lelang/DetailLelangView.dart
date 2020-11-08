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
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/LaporanHomeWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/TambahLelang.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class DetailLelangView extends StatefulWidget {
  final String idKolam;
  final String idLelang;
  DetailLelangView({Key key, this.idKolam, this.idLelang}) : super(key: key);

  @override
  _DetailLelangViewState createState() => _DetailLelangViewState();
}

class _DetailLelangViewState extends State<DetailLelangView> {
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
                Navigator.pop(context, true)
              },
            ),
            actions: <Widget>[

            ],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Detail Lelang",
              style: h3,
            ),
          ),
          body: Column(
            children: [
              Container(
                  padding: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 3,
                      right: SizeConfig.blockVertical * 3),
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            top: SizeConfig.blockVertical * 3),
                        child: CardColumnLelang(context,"Sisa Waktu Lelang","17 : 07 : 09",Alignment.center,0),
                      ),
                      Row(
                        children: <Widget>[
                          Expanded(child: Container(
                            child:  CardInfoLelang(context, "Ikan / Kilogram",
                                "8", "Ekor"),
                          )),
                          Expanded(child: Container(
                            child:  CardInfoLelang(context, "Jumlah Stock",
                                "50", "Kilogram"),
                          ),),
                        ],
                      ),
                      Container(
                        width: double.infinity,
                        child:  CardInfoLelang(context, "Harga / Kilogram",
                            "20.000", "Rupiah"),
                      ),

                      Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: new Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 45.0,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        top: 15.0),
                                    child: CustomElevation(
                                        height: 30.0,
                                        child: RaisedButton(
                                          highlightColor: colorPrimary,
                                          //Replace with actual colors
                                          color: colorPrimary,
                                          onPressed: () =>
                                          {
                                          },
                                          child: Text(
                                            "Menuju Lelang",
                                            style: TextStyle(
                                                color:  backgroundColor,
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
                                  Container(
                                    height: 45.0,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        top: 15.0),
                                    child: CustomElevation(
                                        height: 30.0,
                                        child: RaisedButton(
                                          highlightColor: redTextColor,
                                          //Replace with actual colors
                                          color: redTextColor,
                                          onPressed: () => {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    // duration: Duration(microseconds: 1000),
                                                    child: DashboardView())),
                                          },
                                          child: Text(
                                            "Stop Lelang",
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
                              )))


                    ],
                  ))
            ],
          )),
    );
  }
}
