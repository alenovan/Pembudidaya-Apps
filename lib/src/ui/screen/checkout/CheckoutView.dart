import 'dart:convert';
import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as checkout;
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/ListAlamatPengiriman.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class CheckoutView extends StatefulWidget {
  final String name_pakan;
  final int price;
  final String idKolam;
  final String url_pakan;

  CheckoutView(
      {Key key, this.name_pakan, this.price, this.url_pakan, this.idKolam})
      : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  final formatter = new NumberFormat("#,###");
  bool _clickForgot = true;
  var blox;
  var _nama = " ";
  var _alamat = " ";
  var _phone = " ";
  var sow_date = "";
  var seed_price = 0;
  var seed_amount = 0;
  var seed_weight = 0;
  var survival_rate = 0;
  var feed_conversion_ratio = 0;
  var target_fish_count = 0;
  var target_price = 0;
  var name_pakan = "";
  var pricex = "";
  var url_pakanx = "";
  var total_payment= "";
  var total_kebutuhan_kilo = "";
  DbHelper _dbHelper;
  var dataPenentuan;
  var id_order = 0;
  var feed_idx = "";
  void detailKolam() async {
    // Future.delayed(new Duration(milliseconds: 1500), () {
    //   showLoaderDialog(context);
    // });
    var detail = await bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    setState(() {
      id_order = data['harvest']['last_order_id'];
      feed_idx = data['harvest']['feed_id'].toString();
    });
    detailOrder();
    getDataPanen();
    // Navigator.of(context).pop();
  }

  void detailOrder() async {
    var detail = await checkout.bloc.getOrderId(id_order.toString());
    var data = detail['data'];

    setState(() {
      name_pakan = data["feed_name"];
      pricex = data["feed_price"];
      total_payment = data["total_payment"];
      total_kebutuhan_kilo = data["order_amount"];

    });
  }

  void getDataPanen() async {
    dataPenentuan = await _dbHelper.select(int.parse(widget.idKolam));
    var detail_pakan =  await checkout.bloc.getFeedDetail(feed_idx);
    var data = detail_pakan;
    setState(() {
      sow_date = dataPenentuan["sow_date"].toString();
      seed_price = dataPenentuan["seed_price"];
      seed_amount = dataPenentuan["seed_amount"];
      seed_weight = dataPenentuan["seed_weight"];
      survival_rate = dataPenentuan["survival_rate"];
      feed_conversion_ratio = dataPenentuan["feed_conversion_ratio"];
      target_fish_count = dataPenentuan["target_fish_count"];
      target_price = dataPenentuan["target_price"];
      url_pakanx = data["data"]["photo"].toString();
    });
  }

  void update() async {
    blox = await profile.bloc.getProfile();
    setState(() {
      _phone = blox['data']['phone_number'].toString() == "null"
          ? " "
          : blox['data']['phone_number'].toString();
      _nama = blox['data']['name'].toString() == "null"
          ? " "
          : blox['data']['name'].toString();
      _alamat = blox['data']['address'].toString() == "null"
          ? " "
          : blox['data']['address'].toString();
    });
  }

  @override
  void initState() {
    super.initState();
    _phone = "Loading";
    _nama = "Loading";
    _alamat ="Loading";
    name_pakan = "Loading";
    pricex = "Loading";
    total_payment = "Loading";
    total_kebutuhan_kilo = "Loading";
    detailKolam();
    _dbHelper = DbHelper.instance;
    update();
    // getDataPanen();
    // Navigator.pop(context);

  }

  void _clickCheckOut() async {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    var status = await checkout.bloc.checkout(id_order.toString());
    if(status){
      Navigator.of(context).pop();
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertSuccess(context, LaporanMain(
              idKolam: widget
                  .idKolam
                  .toString(),
              page: 0,
              laporan_page:
              "home",
            )),
      );

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              child: LaporanMain(
                idKolam: widget
                    .idKolam
                    .toString(),
                page: 0,
                laporan_page:
                "home",
              )));
    }else{
      Navigator.of(context).pop();
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }

  Widget getTitle() {
    return const Text('Checkout', style: subtitle2);
  }

  BackButton getBackButton() {
    return const BackButton();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child:  WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: LaporanMain(
                          page: 0,
                          laporan_page: "home",
                          idKolam: widget.idKolam,
                        )))
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
                                        fontSize: 17.0),
                                  )),
                              Container(
                                  alignment: Alignment.centerLeft,
                                  child: InkWell(
                                    onTap: ()=>{
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              child: ListAlamatPengiriman(
                                                idKolam: widget.idKolam,
                                              )))
                                  },
                                    child: Text(
                                      "Pilih Alamat Lain",
                                      style:
                                      overline.copyWith(color: colorPrimary),
                                    ),
                                  ))
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
                                    Container(
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
                                                  fontSize: 13.0),
                                            ),
                                          ),
                                          // Container(
                                          //   child: Text(
                                          //     "Kel. Jatimulyo, Kec. Klojen",
                                          //     style: TextStyle(
                                          //         fontFamily: 'poppins',
                                          //         letterSpacing: 0.4,
                                          //         fontSize: 13.0),
                                          //   ),
                                          // ),
                                          // Container(
                                          //   child: Text(
                                          //     "Kota Malang, Jawa Timur",
                                          //     style: TextStyle(
                                          //         fontFamily: 'poppins',
                                          //         letterSpacing: 0.4,
                                          //         fontSize: 13.0),
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
                                                  fontSize: 13.0),
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                    Column(
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
                                        fontSize: 17.0),
                                  )),
                            ],
                          ),
                          CardPenentuanPakan(context, name_pakan,
                              pricex, "", url_pakanx),
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
                                        fontSize: 17.0),
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
                                          fontSize: 13.0),
                                    )),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 13.0),
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
                                          fontSize: 13.0),
                                    )),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 13.0),
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
                                          fontSize: 13.0),
                                    )),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      total_kebutuhan_kilo,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 13.0),
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
                                          fontSize: 13.0),
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
                                          fontSize: 13.0),
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
                                        fontSize: 17.0),
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
                                          fontSize: 13.0),
                                    )),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                     total_payment,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 13.0),
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
                                          fontSize: 13.0),
                                    )),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Rp.25.000,-",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 13.0),
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
                              height: SizeConfig.blockVertical * 12,
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
                                                fontSize: 15.0),
                                          ),
                                          Text(
                                            total_payment,
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'poppins',
                                                letterSpacing: 0.4,
                                                fontWeight: FontWeight.w700,
                                                fontSize: 20.0),
                                          )
                                        ],
                                      )),
                                  Container(
                                    padding: EdgeInsets.only(
                                        right: SizeConfig.blockVertical * 4),
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      height: 35.0,
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
                                                  fontSize: 14.0),
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
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: LaporanMain(
              page: 0,
              laporan_page: "home",
              idKolam: widget.idKolam,
            )));
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
                "Apakah anda yakin melakukan checkout? ",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
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
                              "Ya",
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
                          color: redTextColor,
                          onPressed: () => {Navigator.pop(context, true)},
                          child: Text(
                            "Tidak",
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
                        )),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
    return data;
  }
}
