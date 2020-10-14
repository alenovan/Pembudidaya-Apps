import 'dart:ui';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class CheckoutView extends StatefulWidget {
  CheckoutView({Key key}) : super(key: key);

  @override
  _CheckoutViewState createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  bool _clickForgot = true;

  void _toggleButtonForgot() {
    setState(() {
      _clickForgot = !_clickForgot;
    });
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            // duration: Duration(microseconds: 1000),
            child: ForgotResetView()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomPadding: false,
        appBar:
            AppbarForgot(context, "Checkout", LoginView(), Colors.grey[100]),
        body: Container(
            width: MediaQuery.of(context).size.width,
            child: Stack(
              children: [
                Positioned(
                    child: SingleChildScrollView(
                  child: Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 4,
                        right: SizeConfig.blockVertical * 4,
                        top: SizeConfig.blockVertical * 2),
                    child: Column(
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
                                  style: TextStyle(
                                      color: Colors.grey[500],
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: 14.0),
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
                                          "Kristyan Michael Poilot",
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              letterSpacing: 0.4,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 14.0),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top:
                                                  SizeConfig.blockVertical * 2),
                                          child: Text(
                                            "Jl. Sendiri aja jodohnya kemana ?",
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                letterSpacing: 0.4,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Kel. Jatimulyo, Kec. Klojen",
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                letterSpacing: 0.4,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                        Container(
                                          child: Text(
                                            "Kota Malang, Jawa Timur",
                                            style: TextStyle(
                                                fontFamily: 'poppins',
                                                letterSpacing: 0.4,
                                                fontSize: 13.0),
                                          ),
                                        ),
                                        Container(
                                          margin: EdgeInsets.only(
                                              top: SizeConfig.blockVertical * 2,
                                              bottom:
                                                  SizeConfig.blockVertical * 2),
                                          child: Text(
                                            "+6287759659653",
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
                                                  SizeConfig.blockVertical * 3),
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
                            context, "Pabrik Si panji", "Rp.80.000", "Kg"),
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
                        Container(
                          height: 100,
                          width: MediaQuery.of(context).size.width,
                        ),
                      ],
                    ),
                  ),
                )),
                new Positioned(
                  child: Container(
                      child: new Align(
                          alignment: FractionalOffset.bottomCenter,
                          child: Container(
                            height: SizeConfig.blockVertical * 12,
                            width: MediaQuery.of(context).size.width,
                            color: purpleTextColor,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 4),
                                    alignment: Alignment.centerLeft,
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
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
                                            highlightColor:
                                            colorPrimary, //Replace with actual colors
                                            color:  colorPrimaryLight ,
                                            onPressed: () => {},
                                            child: Text(
                                              "Pembayaran",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'poppins',
                                                  letterSpacing: 1.25,
                                                  fontSize: 14.0),
                                            ),
                                            shape: new RoundedRectangleBorder(
                                              borderRadius: new BorderRadius.circular(30.0),
                                            ),
                                          )),
                                    ),)
                              ],
                            ),
                          ))),
                )
              ],
            )));
  }
}
