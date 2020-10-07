import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/TabsPageLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/test.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class PageTwo extends StatefulWidget {
  PageTwo({Key key}) : super(key: key);

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

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
          backgroundColor: backgroundGreyColor,
          resizeToAvoidBottomPadding: false,
          appBar: AppbarForgot(context, "Laporan", LoginView()),
          body: Align(
            child: Container(
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
                                    decoration: EditTextDecorationText(
                                        context, "", 20.0, 0, 0, 0),
                                    keyboardType: TextInputType.text,
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
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  // duration: Duration(microseconds: 1000),
                                                  child: Test(
                                                    page: 2,
                                                    laporan_page: "tiga",
                                                  )))
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
                )),
          )),
    );
  }
}
