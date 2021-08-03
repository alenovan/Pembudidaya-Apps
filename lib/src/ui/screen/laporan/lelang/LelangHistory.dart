import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:lelenesia_pembudidaya/src/models/AuctionModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/DetailLelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/TambahLelang.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/lelang/WinnerBidder.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class LelangHistory extends StatefulWidget {
  final String idKolam;

  LelangHistory({Key key, this.idKolam}) : super(key: key);

  @override
  _LelangViewState createState() => _LelangViewState();
}

class _LelangViewState extends State<LelangHistory> {
  bool _showDetail = true;
  final formatter = new NumberFormat('#,##0', 'ID');
  ScrollController _controller_scroll;
  bool silverCollapsed = false;
  String myTitle = "";
  Color silverColor = Colors.transparent;
  Color tmblColor = Colors.black;

  List<AuctionModels> dataLelang = new List();
  var items = List<AuctionModels>();
  var items2 = List<AuctionModels>();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

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
    lelang.bloc.getHistoryLelang().then((value) {
      setState(() {
        dataLelang = value;
        items.addAll(dataLelang);
        items2.addAll(dataLelang);
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
          myTitle = "History Lelang";
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
                          left: ScreenUtil().setWidth(40),
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
                            size:25.sp),
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
                                  left: ScreenUtil().setWidth(30),
                                  right: ScreenUtil().setWidth(50)),
                              child: Text(
                                "Lelang Hasil Panen",
                                style: h3.copyWith(
                                    color: blackPrimaryTextColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize:25.sp),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(110),
                                  left: ScreenUtil().setWidth(30),
                                  right: ScreenUtil().setWidth(50)),
                              child: Text(
                                "Lelang hasil panen ikanmu agar anda segera mendapat keuntungan !",
                                style: caption.copyWith(
                                    color: greyTextColor,
                                    fontWeight: FontWeight.w700,
                                    fontSize:20.sp),
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
                                      left: ScreenUtil().setWidth(60),
                                      right: ScreenUtil().setWidth(40)),
                                  child: CustomElevation(
                                      height: 40.h,
                                      child: RaisedButton(
                                        highlightColor: colorPrimary,
                                        //Replace with actual colors
                                        color: colorPrimary,
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: TambahLelang(
                                                    idKolam: widget.idKolam,
                                                  )))
                                        },
                                        child: Text(
                                          "Lelang",
                                          style: subtitle2.copyWith(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 25.sp),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(30.0),
                                        ),
                                      ))),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Lelang berlangsung",
                          style: h3.copyWith(
                              color: blackPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0.0, -ScreenUtil().setHeight(60), 0.0),
                          margin: EdgeInsets.only(
                            top: 10.h,
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: FutureBuilder(
                            future: lelang.bloc.getHistoryLelang(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return buildList2(snapshot);
                              } else if (snapshot.hasError) {
                                return Text("");
                              }
                              return ListView.builder(
                                  itemCount: 1,
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
                      Container(
                        transform: Matrix4.translationValues(0.0, -ScreenUtil().setHeight(60), 0.0),
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(60),
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Histori Lelang",
                          style: h3.copyWith(
                              color: blackPrimaryTextColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                          transform: Matrix4.translationValues(0.0, -ScreenUtil().setHeight(100), 0.0),
                          margin: EdgeInsets.only(
                              top: 10.h,
                              left: ScreenUtil().setWidth(60),
                              right: ScreenUtil().setWidth(60)),
                          child: FutureBuilder(
                            future: lelang.bloc.getHistoryLelang(),
                            builder:
                                (context, AsyncSnapshot<dynamic> snapshot) {
                              if (snapshot.hasData) {
                                return RefreshIndicator(
                                  key: refreshKey,
                                  child: buildList(snapshot),
                                  onRefresh: refreshList,
                                );
                              } else if (snapshot.hasError) {
                                return Text(snapshot.error.toString());
                              }
                              return ListView.builder(
                                  itemCount: 5,
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
                          ))
                    ]),
                  ),

                  // SliverToBoxAdapter(
                  //   child: Container(
                  //     child: ,
                  //   ),
                  // )
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
        return items2[index].endBid.isBefore(DateTime.now())|| items2[index].winnerId.toString() != "null"?InkWell(
          onTap: (){
            if(items2[index].winnerId.toString() != "null") {
              if(items[index].winnerId.toString() == "0") {
                BottomSheetFeedback.show(context, title: "Mohon Maaf",
                    description: "Mohon Maaf Lelang Telah Di Hentikan");
              }else {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: WinnerBidder(
                          idBidder: items2[index].winnerId.toString(),
                          idKolam: widget.idKolam,
                          idLelang: items[index].id.toString(),
                        )));
              }
            }else {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.fade,
                      child: DetailLelangView(
                        idKolam: widget.idKolam,
                        idLelang: items[index].bidName,
                        endLelang: items[index].endBid,
                        price: formatter.format(items[index].firstPrice)
                            .toString(),
                        perKilo: items[index].fishperkg.toString(),
                        stock: items[index].quantity.toString(),
                      )));
            }
          },
          child: Container(
            child: LelangLeftRight(
                context, items[index].bidName.toString(), "Rp.${formatter.format(int.parse(items[index].firstPrice))}", "${DateFormat('dd MMMM yyyy').format(items[index].startBid)}"),
          ),
        ):SizedBox(height: 0.1,);
      },
    );
  }


  Widget buildList2(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      primary: false,
      shrinkWrap: true,
      itemCount: items2.length,
      itemBuilder: (BuildContext context, int index) {
        print(items2[index].endBid);
        return items2[index].endBid.isAfter(DateTime.now()) && items2[index].winnerId.toString() == "null"?InkWell(
          onTap: (){
          },
          child: Container(
            child: CardLeftRightButton(
                context, items2[index].bidName,  "${DateFormat('dd MMMM yyyy').format(items2[index].startBid)}", DetailLelangView(
              idKolam: widget.idKolam,
              idLelang: items2[index].id.toString(),
              endLelang: items2[index].endBid,
              price: formatter.format(int.parse(items2[index].firstPrice)).toString(),
              perKilo: items2[index].fishperkg.toString(),
              stock: items2[index].quantity.toString(),
            )),
          ),
        ):SizedBox(height: 0.1,);
      },
    );
  }
}
