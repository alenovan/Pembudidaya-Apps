import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as checkout;
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/models/ListAlamatModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/ListAlamatPengiriman.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/bloc/PakanBloc.dart' as order;
class CheckoutFix extends StatefulWidget {
  final String idKolam;
  final String feedId;
  final String idIkan;

  CheckoutFix(
      {Key key,this.idKolam, this.feedId, this.idIkan})
      : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutFix> {
  final formatter = new NumberFormat("#,###");
  bool _clickForgot = true;
  var blox;
  var _nama = " ";
  var _alamat = " ";
  var _phone = " ";
  var sow_date = "";
  var seed_price = 0;
  var ongkir = 25000;
  var seed_amount = 0;
  var feed_amount = 1;
  var seed_weight = 0;
  var survival_rate = 0;
  var feed_conversion_ratio = 0;
  var target_fish_count = 0;
  var target_price = 0;
  var name_pakan = "";
  var pricex = 0;
  var url_pakanx = "";
  var total_payment= 0;
  var total_kebutuhan_kilo = "";
  DbHelper _dbHelper;
  var dataPenentuan;
  var id_order = 0;
  var feed_idx = "";
  var id_pakan = 0;
  var items = List<ListAlamatModels>();
  List<ListAlamatModels> dataAlamat = new List();
  void detailKolam() async {
    var detail = await bloc.getKolamDetail(widget.idKolam);
    getDataPanen();
  }



  void getDataPanen() async {
    var detail_pakan =  await checkout.bloc.getFeedDetail(widget.feedId.toString());
    var data = detail_pakan;
    setState(() {
      url_pakanx = data["data"]["photo"].toString();
      name_pakan = data["data"]["name"].toString();
      pricex = data["data"]["price"];
      total_kebutuhan_kilo = (feed_amount * 30).toString() +" Kg";
      total_payment = ((pricex * feed_amount) + ongkir);
    });
  }

  void updatePrice(){
    setState(() {
      total_kebutuhan_kilo = (feed_amount * 30).toString() +" Kg";
      total_payment = ((pricex * feed_amount) + ongkir);
    });
  }

  void update() async {
    profile.bloc.fetchAllAlamat().then((value) {
      setState(() {
        dataAlamat = value;
        items.addAll(dataAlamat);
        for (var data in items) {
          if(data.isMain == 1){
            setState(() {
              _nama = data.name.toString();
              _phone = data.phoneNumber.toString();
              _alamat = "${data.address.toString()} ${data.province.name.toString()}  ${data.city.name.toString()}   ${data.district.name.toString()}";
            });
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    _dbHelper = DbHelper.instance;
    _phone = "Loading";
    _nama = "Loading";
    _alamat ="Loading";
    name_pakan = "Loading";
    pricex = 0;
    total_payment = 0;
    total_kebutuhan_kilo = "Loading";
    detailKolam();

    update();
    // getDataPanen();
    // Navigator.pop(context);

  }

  void _clickCheckOut() async {
    AppExt.popScreen(context);
    LoadingDialog.show(context);
    var dataOrder = await order.bloc.funReOrderFeed(
        widget.idKolam,
        widget.feedId,
        feed_amount.toString());
    if(dataOrder){
      var detail = await bloc.getKolamDetail(widget.idKolam);
      var data = detail['data'];
      setState(() {
        id_order = data['harvest']['last_order_id'];
      });
      var statusCheckout = await checkout.bloc.checkout(id_order.toString());
      if(statusCheckout){
        AppExt.popScreen(context);
        BottomSheetFeedback.show_success(context, title: "Selamat", description: "Pembelian anda berhasil di checkout");
        Timer(const Duration(seconds: 2), () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: DetailKolam(
                    idIkan: widget.idIkan.toString(),
                    idKolam: widget
                        .idKolam
                        .toString(),
                  )));
        });
      }else{
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
      }
    }else{
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }

  void _clickOrder() async {
    AppExt.popScreen(context);
    LoadingDialog.show(context);
    var dataOrder = await order.bloc.funReOrderFeed(
        widget.idKolam,
        widget.feedId,
        feed_amount.toString());
    if(dataOrder){
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "Berhasil Memesan Pakan Ikan");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: DetailKolam(
                  idIkan: widget.idIkan.toString(),
                  idKolam: widget
                      .idKolam
                      .toString(),
                )));
      });
    }else{
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }



  BackButton getBackButton() {
    return const BackButton();
  }

  @override
  Widget build(BuildContext context) {
    final double _screenWidth = MediaQuery.of(context).size.width;
    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child:  WillPopScope(
            onWillPop: _onBackPressed,
            child:Scaffold(
              resizeToAvoidBottomInset: false,
              appBar: AppBar(
                centerTitle: true,
                elevation: 0,
                leading: IconButton(
                  icon: Icon(Icons.arrow_back, color: Colors.black),
                  onPressed: () => {
                    Navigator.of(context).pop(true)
                  },
                ),
                actions: <Widget>[],
                backgroundColor: Colors.white,
                brightness: Brightness.light,
                title: Text(
                  "Checkout",
                  style: h3,
                ),
              ),
              backgroundColor: Colors.white,
              body: Column(
                children: [
                  Expanded(
                      child: Stack(
                        children: [
                          SingleChildScrollView(
                            physics: new BouncingScrollPhysics(),
                            child: Container(
                              padding: EdgeInsets.only(
                                  left: SizeConfig.blockVertical * 4,
                                  right: SizeConfig.blockVertical * 4,
                                  top: SizeConfig.blockVertical * 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Alamat Pengiriman",
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                                          )),
                                      // Container(
                                      //     alignment: Alignment.centerLeft,
                                      //     child: InkWell(
                                      //       onTap: ()=>{
                                      //         Navigator.push(
                                      //             context,
                                      //             PageTransition(
                                      //                 type: PageTransitionType.fade,
                                      //                 child: ListAlamatPengiriman(
                                      //                   idKolam: widget.idKolam,
                                      //                 )))
                                      //       },
                                      //       child: Text(
                                      //         "Pilih Alamat Lain",
                                      //         style:
                                      //         overline.copyWith(color: colorPrimary),
                                      //       ),
                                      //     ))
                                    ],
                                  ),
                                  Wrap(
                                    children: [
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockVertical * 2),
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(10),
                                          color: Colors.grey[100],
                                          boxShadow: [
                                            BoxShadow(
                                                color: Colors.grey, spreadRadius: 0.4),
                                          ],
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Flexible(
                                              flex: 4,
                                              child:  Container(
                                                margin: EdgeInsets.only(
                                                  left: SizeConfig.blockVertical * 3,
                                                  top: SizeConfig.blockVertical * 2,
                                                  right: SizeConfig.blockVertical * 2,
                                                ),
                                                child: Column(
                                                  crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                                  children: [
                                                    Text(
                                                      _nama,
                                                      style: TextStyle(
                                                          fontFamily: 'poppins',
                                                          letterSpacing: 0.4,
                                                          fontWeight: FontWeight.w700,
                                                          fontSize: 14.0),
                                                    ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: SizeConfig.blockVertical *
                                                              2),
                                                      child: Text(
                                                        _alamat,
                                                        style: TextStyle(
                                                            fontFamily: 'poppins',
                                                            letterSpacing: 0.4,
                                                            fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                      ),
                                                    ),
                                                    // Container(
                                                    //   child: Text(
                                                    //     "Kel. Jatimulyo, Kec. Klojen",
                                                    //     style: TextStyle(
                                                    //         fontFamily: 'poppins',
                                                    //         letterSpacing: 0.4,
                                                    //         fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                    //   ),
                                                    // ),
                                                    // Container(
                                                    //   child: Text(
                                                    //     "Kota Malang, Jawa Timur",
                                                    //     style: TextStyle(
                                                    //         fontFamily: 'poppins',
                                                    //         letterSpacing: 0.4,
                                                    //         fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                    //   ),
                                                    // ),
                                                    Container(
                                                      margin: EdgeInsets.only(
                                                          top: SizeConfig.blockVertical *
                                                              2,
                                                          bottom:
                                                          SizeConfig.blockVertical *
                                                              2),
                                                      child: Text(
                                                        _phone,
                                                        style: TextStyle(
                                                            fontFamily: 'poppins',
                                                            letterSpacing: 0.4,
                                                            fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                      ),
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ),
                                            Flexible(
                                              flex: 1,
                                              child:    Column(
                                                children: [
                                                  Center(
                                                    child: Container(
                                                      margin: EdgeInsets.only(
                                                          right:
                                                          SizeConfig.blockVertical *
                                                              3),
                                                      child: Icon(
                                                        Icons.check_circle,
                                                        color: purpleTextColor,
                                                        size: 30.0,
                                                      ),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockVertical * 2),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Detail Pesanan",
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                                          )),
                                    ],
                                  ),
                                  // CardPenentuanPakan(context, name_pakan,
                                  //     "Rp.${formatter.format(pricex)} / 30 Kg", "", url_pakanx),
                                  Container(
                                    margin: EdgeInsets.only(top: 10.0,bottom: 10.0),
                                    height: ScreenUtil().setHeight(200),
                                    child: Container(
                                        child: Row(
                                          children: [
                                            Container(
                                              width: ScreenUtil().setHeight(200),
                                              child: ClipRRect(
                                                  borderRadius: BorderRadius.circular(8.0),
                                                  child: Image.network(
                                                    url_pakanx,
                                                    fit: BoxFit.cover,
                                                    height: SizeConfig.blockHorizotal * 17,
                                                    errorBuilder: (BuildContext context, Object exception,
                                                        StackTrace stackTrace) {
                                                      return Image.network(
                                                        url_pakanx,
                                                        height: SizeConfig.blockHorizotal * 17,
                                                        fit: BoxFit.cover,
                                                        frameBuilder: (context, child, frame,
                                                            wasSynchronouslyLoaded) {
                                                          if (wasSynchronouslyLoaded) {
                                                            return child;
                                                          } else {
                                                            return AnimatedSwitcher(
                                                              duration: const Duration(milliseconds: 500),
                                                              child: frame != null
                                                                  ? child
                                                                  : Shimmer.fromColors(
                                                                baseColor: Colors.grey[300],
                                                                highlightColor: Colors.grey[200],
                                                                period: Duration(milliseconds: 1000),
                                                                child: Container(
                                                                  width: _screenWidth * (20 / 100),
                                                                  height: _screenWidth * (15 / 100),
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                      BorderRadius.circular(10),
                                                                      color: Colors.white),
                                                                ),
                                                              ),
                                                            );
                                                          }
                                                        },
                                                      );
                                                    },
                                                  )),
                                            ),
                                            Expanded(
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.center,
                                                children: [
                                                  Container(
                                                      child: Text(
                                                        name_pakan,
                                                        style: TextStyle(
                                                            color: purpleTextColor,
                                                            fontFamily: 'poppins',
                                                            letterSpacing: 0.4,
                                                            fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                                      )),
                                                  Container(
                                                      margin: EdgeInsets.only(top: 5.0),
                                                      child: Row(
                                                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                        children: [
                                                          Row(
                                                            children: [
                                                              Container(
                                                                child: Text(
                                                                  "Rp.${formatter.format(pricex)} / 30 Kg",
                                                                  style: TextStyle(
                                                                      color: Colors.black,
                                                                      fontFamily: 'lato',
                                                                      letterSpacing: 0.4,
                                                                      fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                                ),
                                                              )
                                                            ],
                                                          ),
                                                          // Row(
                                                          //   children: [
                                                          //     InkWell(
                                                          //       child: Container(
                                                          //         child: Icon(
                                                          //           Boxicons.bx_minus_circle,
                                                          //           color: colorPrimary, size: ScreenUtil(allowFontScaling: false).setSp(70),
                                                          //         ),
                                                          //       ),
                                                          //       onTap: () {
                                                          //         setState(() {
                                                          //           if(feed_amount <=1){
                                                          //             feed_amount = 1;
                                                          //           }else{
                                                          //             feed_amount--;
                                                          //           }
                                                          //           updatePrice();
                                                          //         });
                                                          //       },
                                                          //     ),
                                                          //     Container(
                                                          //       padding: EdgeInsets.only(left: 5.0,right: 5.0),
                                                          //       child: Text(
                                                          //         "${feed_amount}",
                                                          //         style: TextStyle(
                                                          //             color: Colors.black,
                                                          //             fontFamily: 'lato',
                                                          //             letterSpacing: 0.4,
                                                          //             fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                          //       ),
                                                          //     ),
                                                          //     InkWell(
                                                          //       child: Container(
                                                          //         child: Icon(
                                                          //           Boxicons.bx_plus_circle,
                                                          //           color: colorPrimary, size: ScreenUtil(allowFontScaling: false).setSp(70),
                                                          //         ),
                                                          //       ),
                                                          //       onTap: () {
                                                          //         setState(() {
                                                          //           feed_amount++;
                                                          //           updatePrice();
                                                          //         });
                                                          //       },
                                                          //     ),
                                                          //   ],
                                                          // )
                                                        ],
                                                      )),
                                                ],
                                              ),
                                            )
                                          ],
                                        )),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Detail Pengiriman",
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Tanggal Pengiriman",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Area Pengiriman",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "-",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Total Kebutuhan",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              total_kebutuhan_kilo,
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 1),
                                    child: Column(
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Catatan (Opsional)",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            padding: EdgeInsets.all(
                                                SizeConfig.blockVertical * 2),
                                            height: 150.0,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: Colors.grey[100],
                                              boxShadow: [
                                                BoxShadow(
                                                    color: Colors.grey,
                                                    spreadRadius: 0.4),
                                              ],
                                            ),
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockVertical * 2),
                                            alignment: Alignment.centerLeft,
                                            child: TextField(
                                              style: TextStyle(
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'poppins',
                                                  letterSpacing: 1.25,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                              maxLines: 8,
                                              decoration: InputDecoration.collapsed(
                                                  hintText: "Tambahkan catatan khusus"),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockVertical * 2),
                                          alignment: Alignment.centerLeft,
                                          child: Text(
                                            "Ringkasan Pembayaran",
                                            style: TextStyle(
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontWeight: FontWeight.w700,
                                                fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                                          )),
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 3),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Subtotal",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Rp.${formatter.format(total_payment-ongkir)}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    height: 1,
                                    width: MediaQuery.of(context).size.width,
                                    color: Colors.grey[300],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Ongkos Kirim",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            )),
                                        Container(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              "Rp.${formatter.format(ongkir)}",
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontFamily: 'lato',
                                                  fontWeight: FontWeight.w700,
                                                  letterSpacing: 0.4,
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                            ))
                                      ],
                                    ),
                                  ),
                                  SizedBox(
                                    height: 150,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          new Positioned(
                            child: Container(
                                child: new Align(
                                    alignment: FractionalOffset.bottomCenter,
                                    child: Container(
                                      height: ScreenUtil().setHeight(200),
                                      width: MediaQuery.of(context).size.width,
                                      color: purpleTextColor,
                                      child: Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.only(
                                                  left: SizeConfig.blockVertical * 4),
                                              alignment: Alignment.centerLeft,
                                              child: Column(
                                                mainAxisAlignment:
                                                MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Total Pembayaran",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'lato',
                                                        letterSpacing: 0.4,
                                                        fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                                                  ),
                                                  Text(
                                                    "Rp.${formatter.format(total_payment)}",
                                                    style: TextStyle(
                                                        color: Colors.white,
                                                        fontFamily: 'poppins',
                                                        letterSpacing: 0.4,
                                                        fontWeight: FontWeight.w700,
                                                        fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                                                  )
                                                ],
                                              )),
                                          Container(
                                            padding: EdgeInsets.only(
                                                top: ScreenUtil().setHeight(35),
                                                right: SizeConfig.blockVertical * 4),
                                            alignment: Alignment.centerLeft,
                                            child: Container(
                                              height: ScreenUtil().setHeight(100),
                                              child: CustomElevation(
                                                  height: 35.0,
                                                  child: RaisedButton(
                                                    highlightColor: Colors.white,
                                                    //Replace with actual colors
                                                    color: Colors.white,
                                                    onPressed: () => {
                                                      showDialog(
                                                        context: context,
                                                        builder: (BuildContext context) =>
                                                            AlertquestionInsert(
                                                                context, DashboardView()),
                                                      )
                                                    },
                                                    child: Text(
                                                      "Pembayaran",
                                                      style: TextStyle(
                                                          color: colorPrimary,
                                                          fontWeight: FontWeight.w500,
                                                          fontFamily: 'poppins',
                                                          letterSpacing: 1.25,
                                                          fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                                    ),
                                                    shape: new RoundedRectangleBorder(
                                                      borderRadius:
                                                      new BorderRadius.circular(
                                                          30.0),
                                                    ),
                                                  )),
                                            ),
                                          )
                                        ],
                                      ),
                                    ))),
                          )
                        ],
                      ))
                ],
              ),
            )));
  }

  Future<bool> _onBackPressed() {
    // Navigator.push(
    //     context,
    //     PageTransition(
    //         type: PageTransitionType.fade,
    //         child: LaporanMain(
    //           page: 0,
    //           laporan_page: "home",
    //           idKolam: widget.idKolam,
    //         )));
    Navigator.of(context).pop(true);
  }

  Widget AlertquestionInsert(BuildContext context, Widget success) {
    final Widget data = Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apakah anda yakin melakukan checkout pemesanan? ",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 15.0),
              ),
                  Container(
                      height: 35.0,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 1,
                          right: SizeConfig.blockVertical * 1,
                          top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 35.0,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () => {
                              _clickCheckOut()
                            },
                            child: Text(
                              "Checkout",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                  letterSpacing: 1.25,
                                  fontSize: subTitleLogin),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ))),
            ],
          ),
        ),
      ),
    );
    return data;
  }
}
