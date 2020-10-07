import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/TabsPageLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class LelangView extends StatefulWidget {
  LelangView({Key key}) : super(key: key);

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
    return Container(
      child: Scaffold(
          backgroundColor: backgroundGreyColor,
          resizeToAvoidBottomPadding: false,
          appBar: AppbarForgot(context, "Lelang", LoginView()),
          body: Align(
            alignment: Alignment.bottomCenter,
            child: Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockVertical * 3,
                    left: SizeConfig.blockVertical * 3,
                    right: SizeConfig.blockVertical * 3,
                    bottom: SizeConfig.blockVertical * 3),
                color: backgroundGreyColor,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "History Lelang",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 18.0),
                        ),
                        Wrap(
                          children: [
                            Container(
                              height: 30.0,
                              child: CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor:
                                        colorPrimary, //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () => {},
                                    child: Text(
                                      "lelang",
                                      style: TextStyle(
                                          color: backgroundColor,
                                          fontWeight: FontWeight.w500,
                                          fontFamily: 'poppins',
                                          letterSpacing: 1.25,
                                          fontSize: 10.0),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius:
                                          new BorderRadius.circular(30.0),
                                    ),
                                  )),
                            )
                          ],
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.only(
                        top: SizeConfig.blockVertical * 3,
                      ),
                      child: Column(
                        children: [
                          CardLelang(context, "Lele catfish blackie", "180.000",
                              "09 Juni 2012"),
                          CardLelang(context, "Lele catfish blackie", "180.000",
                              "09 Juni 2012"),
                          CardLelang(context, "Lele catfish blackie", "180.000",
                              "09 Juni 2012")
                        ],
                      ),
                    )
                  ],
                )),
          )),
    );
  }
}
