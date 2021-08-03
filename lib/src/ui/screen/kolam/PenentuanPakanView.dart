import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListPakanModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/PakanBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/ChekoutReorder.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/pakan/DetailPenentuanPakan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class PenentuanPakanView extends StatefulWidget {
  final String idKolam;
  final String idIkan;
  final String from;
  const PenentuanPakanView({Key key, this.idKolam, this.idIkan, this.from}) : super(key: key);

  @override
  _PenentuanPakanViewState createState() => _PenentuanPakanViewState();
}

class _PenentuanPakanViewState extends State<PenentuanPakanView> {
  bool _clickForgot = true;
  List<ListPakanModels> dataPakan = new List();
  var items = List<ListPakanModels>();
  TextEditingController _searchBoxController = TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void fetchData() {
    bloc.fetchAllPakan().then((value) {
      setState(() {
        dataPakan = value;
        items.addAll(dataPakan);
      });
    });
  }

  onItemChanged(String query) {
    List<ListPakanModels> dummySearchList = List<ListPakanModels>();
    dummySearchList.addAll(dataPakan);
    if (query.isNotEmpty) {
      List<ListPakanModels> dummyListData = List<ListPakanModels>();

      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          print(item.name);
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(dataPakan);
      });
    }
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }

  dispose() {
    super.dispose();
  }

  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            // duration: Duration(microseconds: 1000),
            child: CheckoutView()));
  }

  GestureDetector gs = GestureDetector(
      onTap: () {
        // _togglevisibility();
      },
      child: Icon(
        Icons.search,
        color: colorPrimary,
        size: 15.sp,
      ));

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      items.clear();
    });
    fetchData();

    return null;
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
                backgroundColor: Colors.grey[100],
                resizeToAvoidBottomInset: false,
                // appBar: AppBar(
                //   elevation: 0,
                //   leading: IconButton(
                //     icon: Icon(Icons.arrow_back, color: Colors.black),
                //     onPressed: () => {
                //       Navigator.push(
                //           context,
                //           PageTransition(
                //               type: PageTransitionType.rightToLeft,
                //               child: PenentuanPanenView(idKolam: widget.idKolam,)))
                //     },
                //   ),
                //   actions: <Widget>[],
                //   backgroundColor: Colors.white,
                //   brightness: Brightness.light,
                //   title: Text(
                //     "",
                //     style: h3,
                //   ),
                // ),
                body: Container(
                    child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      child: Image.asset(
                        "assets/png/header_laporan.png",
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height:200.h,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppBarContainer(
                            context,
                            "",
                            widget.from == "laporan"?LaporanMain(
                              page: 0,
                              laporan_page: "home",
                              idKolam: widget.idKolam,
                            ):PenentuanPanenView(idKolam: widget.idKolam),
                            Colors.transparent),
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(90),
                              right: ScreenUtil().setWidth(40)),
                          child: Text(
                            "Penentuan Pakan",
                            style: h3.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 20.sp),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(90),
                              bottom: ScreenUtil().setHeight(100),
                              right: ScreenUtil().setWidth(90)),
                          child: Text(
                            "Belilah Produk Pakan yang disediakan oleh kami agar lelemu menjadi sehat ",
                            style: caption.copyWith(
                                color: Colors.grey,
                                fontWeight: FontWeight.w700,
                                fontSize: 19.sp),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: 10.w,
                              right: 10.w),
                          child: Column(
                            children: [
                              Container(
                                child: TextFormField(
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  onChanged: onItemChanged,
                                  controller: _searchBoxController,
                                  decoration: EditText(
                                      context,
                                      "Cari Pabrik Pakan",
                                      10.w,
                                      0,
                                      0,
                                      20.h,
                                      gs),
                                  keyboardType: TextInputType.text,
                                  style: body2.copyWith(
                                      fontSize:19.sp),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockVertical * 2,
                                  right: SizeConfig.blockVertical * 2),
                              child: Container(
                                  child: FutureBuilder(
                                future: bloc.fetchAllPakan(),
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
                                                    Shimmer.fromColors(
                                                      baseColor: Colors
                                                          .grey[300],
                                                      highlightColor:
                                                      Colors
                                                          .grey[200],
                                                      period: Duration(
                                                          milliseconds:
                                                          1000),
                                                      child: Container(
                                                        margin: EdgeInsets.all(10.0),
                                                        width:ScreenUtil().setWidth(280),
                                                        height:ScreenUtil().setHeight(280),
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                            BorderRadius
                                                                .circular(
                                                                10),
                                                            color: Colors
                                                                .white),
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Column(
                                                        crossAxisAlignment: CrossAxisAlignment.center,
                                                        mainAxisAlignment: MainAxisAlignment.center,
                                                        mainAxisSize: MainAxisSize.min,
                                                        children: [
                                                          Shimmer.fromColors(
                                                              period: Duration(milliseconds: 1000),
                                                              baseColor: Colors.grey[300],
                                                              highlightColor: Colors.white,
                                                              child:  Container(
                                                                margin: EdgeInsets.only(left: 10.0,right: 10.0),
                                                                width: double.infinity,
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
                              ))),
                        ),
                      ],
                    )
                  ],
                )))));
  }

  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.rightToLeft,
            child: PenentuanPanenView(
              idKolam: widget.idKolam,
            )));
  }

  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      physics: new BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        print(items);
        return GestureDetector(
            onTap: () {
              if(widget.from == "laporan"){
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: CheckoutReorder(
                          idKolam: widget.idKolam,
                          idIkan: widget.idIkan,
                          feedId: items[index].id.toString(),
                        )));
              }else{
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: DetailPenentuanPakan(
                          idKolam: widget.idKolam,
                          id_pakan: items[index].id,
                          name: items[index].name,
                          stok: items[index].stock.toDouble(),
                          size: items[index].size,
                          type: items[index].type,
                          price: items[index].price,
                          nameManufacture: items[index].manufacturer.name,
                          photoManufacture: items[index].manufacturer.photo,
                          addressManufacture: items[index].manufacturer.address,
                          pabrikManufacture: "",
                          desc: items[index].description,
                          image_url: items[index].photo,
                        )));
              }

            },
            child: Container(
              child: CardPenentuanPakan(context, items[index].name, "5.0",
                  "-", items[index].price, items[index].photo),
            ));
      },
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;

  const ListItem({Key key, this.index});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: ScreenUtil().setHeight(420),
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          child: Container(
              margin: EdgeInsets.only(
                  left: ScreenUtil().setWidth(20),
                  right: ScreenUtil().setWidth(20)),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: ScreenUtil().setWidth(20),
                        right: ScreenUtil().setWidth(20)),
                    width: ScreenUtil().setHeight(200),
                    padding: EdgeInsets.only(
                      top: SizeConfig.blockHorizotal * 2,
                      bottom: SizeConfig.blockVertical * 2,
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: Image.network(
                        "",
                        fit: BoxFit.cover,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.network(
                              "https://via.placeholder.com/300");
                        },
                      ),
                    ),
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockHorizotal * 3,
                              left: SizeConfig.blockVertical * 2,
                            ),
                            child: Text(
                              "",
                              style: subtitle2.copyWith(
                                  fontSize: ScreenUtil(allowFontScaling: false)
                                      .setSp(40)),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockHorizotal * 1,
                              left: SizeConfig.blockVertical * 2,
                            ),
                            child: Text(
                              "Rp.",
                              style: subtitle2.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize: ScreenUtil(allowFontScaling: false)
                                      .setSp(45)),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockHorizotal * 1,
                              left: SizeConfig.blockVertical * 1,
                            ),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(20),
                                        top: ScreenUtil().setWidth(20)),
                                    child: Icon(
                                      Icons.circle,
                                      color: Colors.grey[300],
                                      size: ScreenUtil(allowFontScaling: false)
                                          .setSp(30),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(40),
                                      top: ScreenUtil().setWidth(20)),
                                  child: Text(
                                    " ",
                                    style: caption.copyWith(
                                        fontSize:
                                            ScreenUtil(allowFontScaling: false)
                                                .setSp(40)),
                                  ),
                                )
                              ],
                            )),
                        Container(
                            margin: EdgeInsets.only(
                              top: SizeConfig.blockHorizotal * 1,
                              left: SizeConfig.blockVertical * 1,
                            ),
                            child: Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(10),
                                        top: ScreenUtil().setWidth(2)),
                                    child: Icon(
                                      Boxicons.bx_dollar_circle,
                                      color: colorPrimary,
                                      size: ScreenUtil(allowFontScaling: false)
                                          .setSp(60),
                                    )),
                                Container(
                                  margin: EdgeInsets.only(
                                      left: ScreenUtil().setWidth(20),
                                      top: ScreenUtil().setWidth(4)),
                                  child: Text(
                                    " COD",
                                    style: caption.copyWith(
                                        color: colorPrimary,
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            ScreenUtil(allowFontScaling: false)
                                                .setSp(40)),
                                  ),
                                )
                              ],
                            )),
                      ],
                    ),
                  ),
                ],
              ))),
    );
  }
}
