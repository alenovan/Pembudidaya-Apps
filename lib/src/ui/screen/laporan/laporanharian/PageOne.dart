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
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class PageOne extends StatefulWidget {
  final String idKolam;
  final int tgl;
  final int bulan;
  final int tahun;
  final DateTime isoData;
  PageOne({Key key, this.idKolam, @required this.tgl, @required this.bulan, @required this.tahun, this.isoData}) : super(key: key);

  @override
  _PageOneState createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  bool _showDetail = true;
  void _cekStatusHarian() {

  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(widget.isoData);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => {
                  PageTransition(
                      type: PageTransitionType.fade,
                      child:  LaporanMain(
                        idKolam: widget
                            .idKolam
                            .toString(),
                        page: 2,
                        laporan_page:
                        "home",
                      ))
                },
              ),
              actions: <Widget>[],
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Text(
                "Laporan",
                style: h3,
              ),
            ),
          body:  Column(
              children: [
                Expanded(child: Container(
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 3,
                      right: SizeConfig.blockVertical * 3,
                        bottom: SizeConfig.blockVertical * 20,),
                    color: backgroundGreyColor,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Container(
                                padding: EdgeInsets.all(25.0),
                                child: Column(
                                  children: [
                                    Container(
                                      margin: EdgeInsets.only(top: 10.0),
                                      child: Text(
                                        "Laporan Hari ini kosong , segera buat laporan anda !",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: blackTextColor,
                                            fontFamily: 'poppins',
                                            letterSpacing: 0.25,
                                            fontSize: 16.0),
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
                                            highlightColor:
                                            colorPrimary, //Replace with actual colors
                                            color: colorPrimary,
                                            onPressed: () => {
                                              // print(widget.idKolam.toString())
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.fade,
                                                      // duration: Duration(microseconds: 1000),
                                                      child: LaporanMain(
                                                        idKolam: widget.idKolam.toString(),
                                                        tgl: widget.tgl,
                                                        bulan: widget.bulan,
                                                        tahun: widget.tahun,
                                                        page: 2,
                                                        isoString: widget.isoData,
                                                        laporan_page: "dua",
                                                      )))
                                            },
                                            child: Text(
                                              "Buat Laporan",
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
                                    )
                                  ],
                                )))
                      ],
                    )))
              ],
          )),);
  }
}
