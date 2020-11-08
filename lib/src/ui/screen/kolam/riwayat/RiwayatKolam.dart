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
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/riwayat/DetailRiwayatKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
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

class RiwayatKolam extends StatefulWidget {
  final String idKolam;
  final String halaman;

  RiwayatKolam({Key key, this.idKolam, this.halaman}) : super(key: key);

  @override
  _RiwayatKolamState createState() => _RiwayatKolamState();
}

class _RiwayatKolamState extends State<RiwayatKolam> {
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
            centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: LaporanMain(
                          page: 0,
                          laporan_page: "home",
                          idKolam: widget.idKolam,
                        )))
              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Riwayat Kolam",
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
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 3,
                        ),
                        child: Column(
                          children: [
                            CardRiwayat(context,
                                "120 Kg", "12 Januari 2020 - 12 Spetember 2020"),
                          ],
                        ),
                      ),
                    ],
                  ))
            ],
          )),
    );
  }
  Widget CardRiwayat(
      BuildContext context, String title, String date) {
    final Widget svgIcon = Container(
      height: SizeConfig.blockVertical * 15,
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: InkWell(
            onTap: (){
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: DetailRiwayatKolam(idKolam: widget.idKolam,)));
            },
            child: Container(
                padding: EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          date,
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 12.0),
                        ),
                        Container(
                            margin: EdgeInsets.only(top: 5.0),
                            child: Text(
                              title,
                              style: subtitle1.copyWith(color:Colors.black,fontSize: 20.0),
                            ))
                      ],
                    ),
                    Container(
                        alignment: Alignment.centerRight,
                        child:  Icon(
                          FontAwesomeIcons.chevronCircleRight,
                          color: purpleTextColor,
                          size: SizeConfig.blockHorizotal * 8,
                        ))
                  ],
                )),
          )),
    );
    return svgIcon;
  }
}



