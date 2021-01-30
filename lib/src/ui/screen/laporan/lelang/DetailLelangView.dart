import 'dart:async';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/models/BidderModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangHistory.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/lelang/DetailPreviewBidder.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class DetailLelangView extends StatefulWidget {
  final String idKolam;
  final String idLelang;
  final String perKilo;
  final String stock;
  final String price;
  final DateTime endLelang;
  DetailLelangView({Key key, this.idKolam, this.idLelang, this.endLelang, this.perKilo, this.stock, this.price}) : super(key: key);

  @override
  _DetailLelangViewState createState() => _DetailLelangViewState();
}

class _DetailLelangViewState extends State<DetailLelangView> {
  bool _showDetail = true;
  ScrollController _controller_scroll;
  bool silverCollapsed = false;
  String myTitle = "";
  Color silverColor = Colors.transparent;
  Color tmblColor = Colors.black;
  final formatter = new NumberFormat('#,##0', 'ID');
  List<BidderModels> dataBidder = new List();
  var items = List<BidderModels>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  CountdownTimerController controller;
  int endTime;
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
    lelang.bloc.getBidderLelang(widget.idLelang).then((value) {
      setState(() {
        dataBidder = value;
        items.addAll(dataBidder);

      });
    });
  }

  void setWinner() async{
    LoadingDialog.show(context);
    var status = await lelang.bloc.setStoplelang(widget.idLelang);
    if (status) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "Lelang berhasil dihentikan");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                // duration: Duration(microseconds: 1000),
                child: LelangHistory(
                  idKolam: widget.idKolam,
                )));
      });


    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }


  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  void onEnd() {
    print('onEnd');
  }

  @override
  void initState() {
    fetchData();
    super.initState();
    setState(() {
      endTime = widget.endLelang.millisecondsSinceEpoch;
    });
    controller = CountdownTimerController(endTime: endTime, onEnd: onEnd);
    initializeDateFormatting(); //very important
    _controller_scroll = ScrollController();
    _controller_scroll.addListener(() {
      if (_controller_scroll.offset > 20 &&
          !_controller_scroll.position.outOfRange) {
        if (!silverCollapsed) {
          myTitle = "Lelang Berlangsung";
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
                        child: GestureDetector(
                          onTap: () => {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LelangHistory(
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
                                child: Text(
                                  "Lelang Hasil Panen",
                                  style: h3.copyWith(
                                      color: blackPrimaryTextColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: ScreenUtil(allowFontScaling: false)
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
                                  "Lelang hasil panen ikanmu agar anda segera mendapat keuntungan !",
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
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(100)),
                          child: Text(
                            "Peringkat atas",
                            style: h3.copyWith(color: blackPrimaryTextColor,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),

                        Container(
                            transform: Matrix4.translationValues(0.0, -ScreenUtil().setHeight(60), 0.0),
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(60),
                                right: ScreenUtil().setWidth(60)),
                            child: FutureBuilder(
                              future: lelang.bloc.getBidderLelang(widget.idLelang),
                              builder:
                                  (context, AsyncSnapshot<dynamic> snapshot) {
                                if (snapshot.hasData) {
                                  return RefreshIndicator(
                                    key: refreshKey,
                                    child: items.length<1?buildList(snapshot):Container(child:CardLeftRightButton(context, "---",
                                        "---",null) ),
                                    onRefresh: refreshList,
                                  );
                                } else if (snapshot.hasError) {
                                  return Text(snapshot.error.toString());
                                }
                                return ListView.builder(
                                    itemCount: 3,
                                    shrinkWrap: true,
                                    // Important code
                                    itemBuilder: (context, index) =>
                                        Container(
                                            height:
                                            ScreenUtil().setHeight(320),
                                            child: Card(
                                              elevation: 4,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    15.0),
                                              ),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                                children: [
                                                  Expanded(
                                                    child: Column(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                      mainAxisSize: MainAxisSize.min,
                                                      children: [
                                                        Shimmer.fromColors(
                                                          period: Duration(milliseconds: 1000),
                                                          baseColor: Colors.grey[300],
                                                          highlightColor: Colors.white,
                                                          child:  Container(
                                                            margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                                            width: ScreenUtil().setWidth(200),
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(16.0))
                                                            ),
                                                            child: SizedBox(height: ScreenUtil().setHeight(80),),
                                                          ),),
                                                        Shimmer.fromColors(
                                                          period: Duration(milliseconds: 1000),
                                                          baseColor: Colors.grey[300],
                                                          highlightColor: Colors.white,
                                                          child:  Container(
                                                            margin: EdgeInsets.only(left: 10.0,right: 10.0,top: 2.0),
                                                            width: double.infinity,
                                                            decoration: BoxDecoration(
                                                                color: Colors.white,
                                                                borderRadius: BorderRadius.all(Radius.circular(16.0))
                                                            ),
                                                            child: SizedBox(height: ScreenUtil().setHeight(80),),
                                                          ),),
                                                      ],
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            )
                                        ));
                              },
                            )),
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       top: ScreenUtil().setHeight(20),
                        //       left: ScreenUtil().setWidth(60),
                        //       right: ScreenUtil().setWidth(60)),
                        //   child:  CardLeftRightButton(context, "Rp17.500 ",
                        //       "Peringkat 1",DetailPreviewBidder()),
                        // ),
                        //
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       top: ScreenUtil().setHeight(20),
                        //       left: ScreenUtil().setWidth(60),
                        //       right: ScreenUtil().setWidth(60)),
                        //   child:  CardLeftRightButton(context, "Rp17.500 ",
                        //       "Peringkat 2",DetailPreviewBidder()),
                        // ),
                        //
                        // Container(
                        //   margin: EdgeInsets.only(
                        //       top: ScreenUtil().setHeight(20),
                        //       left: ScreenUtil().setWidth(60),
                        //       right: ScreenUtil().setWidth(60)),
                        //   child:  CardLeftRightButton(context, "Rp17.500 ",
                        //       "Peringkat 3",DetailPreviewBidder()),
                        // ),


                        Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(100)),
                          child: Text(
                            "Lelang berlangsung",
                            style: h3.copyWith(color: blackPrimaryTextColor,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        CountdownTimer(
                          controller: controller,
                          onEnd: onEnd,
                          endTime: endTime,
                          widgetBuilder: (_, CurrentRemainingTime time) {
                            if (time == null) {
                              return Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(50),
                                    right: ScreenUtil().setWidth(50)),
                                child: Center(
                                  child: CardColumnLelang(context,"Sisa Waktu Lelang","Lelang Telah Berakhir",Alignment.center,0),
                                ),
                              );
                            }
                            return  Container(
                              margin: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(50),
                                  right: ScreenUtil().setWidth(50)),
                              child: Center(
                                child: CardColumnLelang(context,"Sisa Waktu Lelang","${time.days == null?"0":time.days}h : ${time.hours == null?"0":time.hours}j : ${time.min== null?"0":time.min}m",Alignment.center,0),
                              ),
                            );
                          },
                        ),
                       Container(
                         margin: EdgeInsets.only(
                             left: ScreenUtil().setWidth(50),
                             right: ScreenUtil().setWidth(50)),
                         child:  Row(
                           children: <Widget>[
                             Expanded(child: Container(
                               child:  CardInfoLelang(context, "Ikan / Kilogram",
                                   "${widget.perKilo}", "Ekor"),
                             )),
                             Expanded(child: Container(
                               child:  CardInfoLelang(context, "Jumlah Stock",
                                   "${widget.stock}", "Kilogram"),
                             ),),
                           ],
                         ),
                       ),
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child:  CardInfoLelang(context, "Harga / Kilogram",
                              "${widget.price}", "Rupiah"),
                        ),

                        Container(
                            margin: EdgeInsets.only(
                                left: ScreenUtil().setWidth(50),
                                right: ScreenUtil().setWidth(50)),
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
                                ))),
                        SizedBox(
                          height: 60,
                        ),

                      ]),
                    )
                  ],
                )
              ],
            )),
    );
  }
  Future<bool> _onBackPressed() {

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: LelangHistory(
              idKolam: widget.idKolam,
            )));
  }

  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return index<=3?InkWell(
          onTap: (){

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: DetailLelangView(
                      idKolam: widget.idKolam,
                      idLelang: items[index].id.toString(),
                    )));
          },
          child: Container(
            child: CardLeftRightButton(context, "Rp.${formatter.format(items[index].bid)}",
                "${items[index].bidderName.toString()}",DetailPreviewBidder(idBidder: items[index].id.toString(),idLelang: items[index].auctionId.toString(),idKolam: widget.idKolam,)),
          ),
        ):SizedBox(height: 0.1,);
      },
    );
  }
}



