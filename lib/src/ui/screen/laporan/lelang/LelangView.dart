import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/models/ListSellModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
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
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:shimmer/shimmer.dart';

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
  List<ListSellModels> dataJual = new List();
  var items = List<ListSellModels>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  final formatter = new NumberFormat('#,##0', 'ID');

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      items.clear();
    });
    fetchData();

    return null;
  }

  void fetchData() {
    lelang.bloc.getJualMarket().then((value) {
      setState(() {
        dataJual = value;
        items.addAll(dataJual);
      });
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    fetchData();
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
          resizeToAvoidBottomInset: false,
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
                      child: GestureDetector(
                        onTap: () => {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType
                                      .fade,
                                  child: LaporanMain(
                                    page: 2,
                                    laporan_page: "home",
                                    idKolam: widget.idKolam,
                                  )))
                        },
                        child: Icon(Icons.arrow_back,
                            color: tmblColor,
                            size:
                                ScreenUtil(allowFontScaling: false).setSp(80)),
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
                              child: Text(
                                "Pasarkan",
                                style: h3.copyWith(
                                    color: blackPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:
                                        ScreenUtil(allowFontScaling: false)
                                            .setSp(60)),
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
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        ScreenUtil(allowFontScaling: false)
                                            .setSp(40)),
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
                                                  child: JualScreen(
                                                    idKolam: widget.idKolam
                                                        .toString(),
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
                        child: Text(
                          "Histori Penjualan",
                          style: h3.copyWith(
                              color: blackPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(50)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(
                              0.0, -ScreenUtil().setHeight(60), 0.0),
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: FutureBuilder(
                            future: lelang.bloc.getJualMarket(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return RefreshIndicator(
                                  key: refreshKey,
                                  child: buildList(snapshot),
                                  onRefresh: refreshList,
                                );
                              } else if (snapshot.hasError) {
                                return Text("");
                              }
                              return ListView.builder(
                                  itemCount: 5,
                                  shrinkWrap: true,
                                  // Important code
                                  itemBuilder: (context, index) => Container(
                                      height: ScreenUtil().setHeight(320),
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Shimmer.fromColors(
                                                    period: Duration(
                                                        milliseconds: 1000),
                                                    baseColor: Colors.grey[300],
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0),
                                                      width: ScreenUtil()
                                                          .setWidth(200),
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      16.0))),
                                                      child: SizedBox(
                                                        height: ScreenUtil()
                                                            .setHeight(80),
                                                      ),
                                                    ),
                                                  ),
                                                  Shimmer.fromColors(
                                                    period: Duration(
                                                        milliseconds: 1000),
                                                    baseColor: Colors.grey[300],
                                                    highlightColor:
                                                        Colors.white,
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          left: 10.0,
                                                          right: 10.0,
                                                          top: 2.0),
                                                      width: double.infinity,
                                                      decoration: BoxDecoration(
                                                          color: Colors.white,
                                                          borderRadius:
                                                              BorderRadius.all(
                                                                  Radius.circular(
                                                                      16.0))),
                                                      child: SizedBox(
                                                        height: ScreenUtil()
                                                            .setHeight(80),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      )));
                            },
                          )),
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

  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
          onTap: () {},
          child: Container(
            child: LelangLeftRight(
                context,
                items[index].name,
                "Rp.${formatter.format(items[index].price)}",
                DateFormat("dd MMMM yyyy ").format(items[index].createdAt)),
          ),
        );
      },
    );
  }
}
