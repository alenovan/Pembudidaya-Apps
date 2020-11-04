import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class PageTwo extends StatefulWidget {
  final String idKolam;
  final int tgl;
  final int bulan;
  final int tahun;
  PageTwo({Key key, this.idKolam, this.tgl, this.bulan, this.tahun}) : super(key: key);

  @override
  _PageTwoState createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  bool _showDetail = true;
  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }
  TextEditingController feedController = TextEditingController();
  @override
  void initState() {
    print(widget.tgl);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
          body:  Column(
              children: [
              AppBarContainer(context, "Laporan", DashboardView(),Colors.white),
              Expanded(child: Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.blockVertical * 3,
                    right: SizeConfig.blockVertical * 3,
                    bottom: SizeConfig.blockVertical * 20),
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
                                    "Berapa pakan yang kamu habiskan hari ini ? (Kilogram)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'poppins',
                                        letterSpacing: 0.25,
                                        fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: feedController,
                                    decoration: EditTextDecorationText(
                                        context, "", 20.0, 0, 0, 0),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'lato',
                                        letterSpacing: 0.4,
                                        fontSize: subTitleLogin),
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
                                          // if(feedController.text.trim() == ""){
                                          // BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Pastikan data terisi semua")
                                          // }else{
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
                                                      laporan_page: "tiga",
                                                    )))
                                          // }
                                        },
                                        child: Text(
                                          "Selanjutnya",
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

