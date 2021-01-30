import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangHistory.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/TambahLelang.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualLanding.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
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
  ScrollController _controller_scroll;
  bool silverCollapsed = false;
  String myTitle = "";
  Color silverColor = Colors.transparent;
  Color tmblColor = Colors.black;
  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initializeDateFormatting(); //very important
    _controller_scroll = ScrollController();
    _controller_scroll.addListener(() {
      if (_controller_scroll.offset > 20 &&
          !_controller_scroll.position.outOfRange) {
        if (!silverCollapsed) {
          myTitle = "History Penjualan";
          silverCollapsed = true;

          setState(() {
            silverColor = colorPrimary;
            tmblColor = Colors.white;
          });
        }
      }
      if (_controller_scroll.offset <= 20 &&
          !_controller_scroll.position.outOfRange) {
        if (silverCollapsed) {
          myTitle = "";
          silverCollapsed = false;
          silverColor = Colors.transparent;
          setState(() {
            silverColor = Colors.transparent;
            tmblColor = Colors.black;
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
          body: Stack(
            children: [

              Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/png/header_laporan.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(550),
                ),
              ),

              CustomScrollView(
                controller: _controller_scroll,
                slivers: <Widget>[
                  SliverAppBar(
                    backgroundColor: silverColor,
                    title: Text(myTitle),
                    leading: Container(
                      margin: EdgeInsets.only(
                          left: ScreenUtil().setWidth(50),
                          right: ScreenUtil().setWidth(50)),
                      child:GestureDetector(
                        onTap: ()=>{
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: DetailKolam(
                                    idKolam: widget.idKolam,
                                  )))
                        },
                        child: Icon(Icons.arrow_back,
                            color: tmblColor,
                            size: ScreenUtil(allowFontScaling: false).setSp(80)),
                      ),
                    ),
                    floating: true,
                    snap: true,
                    flexibleSpace: FlexibleSpaceBar(),
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate([
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(50),
                            right: ScreenUtil().setWidth(50)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              margin: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(10),
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(50)),
                              child:  Text(
                                "Pasarkan",
                                style: h3.copyWith(color: blackPrimaryTextColor,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(60)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(110),
                                  left: ScreenUtil().setWidth(20),
                                  right: ScreenUtil().setWidth(50)),
                              child: Text(
                                "Jual atau lelang hasil panen ikanmu agar anda segera mendapat keuntungan !",
                                style: caption.copyWith(
                                    color: greyTextColor,
                                    fontWeight: FontWeight.w700,fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                textAlign: TextAlign.start,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(30),
                                      left: ScreenUtil().setWidth(100),
                                      right: ScreenUtil().setWidth(40)),
                                  child: CustomElevation(
                                      height: ScreenUtil().setHeight(110),
                                      child: RaisedButton(
                                        highlightColor: colorPrimary,
                                        //Replace with actual colors
                                        color: colorPrimary,
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: JualLanding(
                                                    idKolam: widget.idKolam,
                                                  )))
                                        },
                                        child: Text(
                                          "Jual",
                                          style: subtitle2.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0),
                                        ),
                                      ))),
                            ),
                            Expanded(
                              child: Container(
                                  margin: EdgeInsets.only(
                                      top: ScreenUtil().setWidth(30),
                                      left: ScreenUtil().setWidth(40),
                                      right: ScreenUtil().setWidth(100)),
                                  child: CustomElevation(
                                      height: ScreenUtil().setHeight(110),
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
                                                  child: LelangHistory(
                                                    idKolam: widget.idKolam,
                                                  )))
                                        },
                                        child: Text(
                                          "Lelang",
                                          style: subtitle2.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0),
                                        ),
                                      ))),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(70),
                            right: ScreenUtil().setWidth(100)),
                        child:  Text(
                          "Histori Penjualan",
                          style: h3.copyWith(color: blackPrimaryTextColor,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ), Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(60)),
                        child:  LelangLeftRight(context, "Lele catfish blackie ",
                            "180.000", "09 Juni 2019"),
                      ),
                      SizedBox(
                        height: 20,
                      ),


                    ]),
                  )
                ],
              )
            ],
          )),
    );
  }
}
