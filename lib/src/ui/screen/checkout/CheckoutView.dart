import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';

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
  DbHelper _dbHelper;
  var dataPenentuan;

  void getDataPanen() async {
    dataPenentuan = await _dbHelper.select(int.parse(widget.idKolam));
    print(dataPenentuan);
    setState(() {
      sow_date = dataPenentuan["sow_date"].toString();
      seed_price = dataPenentuan["seed_price"];
      seed_amount = dataPenentuan["seed_amount"];
      seed_weight = dataPenentuan["seed_weight"];
      survival_rate = dataPenentuan["survival_rate"];
      feed_conversion_ratio = dataPenentuan["feed_conversion_ratio"];
      target_fish_count = dataPenentuan["target_fish_count"];
      target_price = dataPenentuan["target_price"];
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
    update();
    getDataPanen();
    super.initState();
  }

  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
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
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                padding: EdgeInsets.only(top: SizeConfig.blockVertical * 5),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: getBackButton(),
                    ),
                    const Spacer(),
                    getTitle(),
                    const Spacer(flex: 2)
                  ],
                ),
              ),
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
                                  child: Text(
                                    "Ubah",
                                    style:
                                        overline.copyWith(color: Colors.grey),
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
                          CardPenentuanPakan(
                              context,
                              widget.name_pakan,
                              "Rp." + formatter.format(widget.price),
                              "Kg",
                              widget.url_pakan),
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
                                      "Selasa, 22 September 2020",
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
                                      "Kota Malang",
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
                                      "3000 Kg",
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
                                      "Rp.3.000.000,-",
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
                                            "Rp.5.000.000,-",
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
                                            onPressed: () => {},
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
        ));
  }
}
