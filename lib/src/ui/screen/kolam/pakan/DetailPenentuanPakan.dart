import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
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

class DetailPenentuanPakan extends StatefulWidget {
  final String name;
  final int price;
  final String stok;
  final String umur;
  final String jenis;
  final String desc;
  final String image_url;
  final String idKolam;
  final int id_pakan;
  DetailPenentuanPakan({Key key, this.name, this.price, this.stok, this.umur, this.jenis, this.desc, this.image_url, this.idKolam, this.id_pakan}) : super(key: key);

  @override
  _DetailPenentuanPakanState createState() => _DetailPenentuanPakanState();
}

class _DetailPenentuanPakanState extends State<DetailPenentuanPakan> {
  bool _clickForgot = true;
  final formatter = new NumberFormat("#,###");
  void _toggleButtonForgot() {
    print("aaa");
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

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
    child:Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomPadding: false,
        body: Column(
          children: [
            Container(child: Container(
              padding: EdgeInsets.only(top:SizeConfig.blockVertical*8,bottom:SizeConfig.blockVertical*4,),
              color: Colors.white,
              child: Row(
                children: [
                  Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockHorizotal*5),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  // duration: Duration(microseconds: 1000),
                                  child: PenentuanPakanView()));
                        },
                        child: IconTheme(
                          data: IconThemeData(color: appBarTextColor),
                          child: Icon(Icons.arrow_back),
                        ),
                      )),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockHorizotal*2),
                    child:  Text(
                      "Penentuan Pakan",
                      style: h3,
                    ),
                  )
                ],
              ),
            ),),
            Container(
                margin: EdgeInsets.only(
                    top: SizeConfig.blockVertical * 3),
                color: Colors.white,
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                child: Wrap(
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 2),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Info produk",
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w700,
                                      fontSize: subTitleLogin),
                                )
                            ),
                            Container(
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: SizeConfig.blockVertical * 2),
                                    width: SizeConfig.blockHorizotal * 30,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(8.0),
                                      child: Image.network(
                                        image_link+widget.image_url,
                                        fit: BoxFit.cover,
                                        height: SizeConfig.blockHorizotal * 35,
                                        errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                                          return Image.network(
                                              "https://via.placeholder.com/300"
                                          );
                                        },
                                      )
                                      ),
                                  ), Container(
                                    margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 3,
                                      top: SizeConfig.blockVertical * 2,
                                      right: SizeConfig.blockVertical * 2,),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          widget.name,
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              letterSpacing: 0.4,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 18.0),
                                        ),
                                        RichText(
                                            textAlign: TextAlign.left,
                                            text: TextSpan(children: <TextSpan>[
                                              TextSpan(
                                                text: "Rp."+formatter.format(widget.price),
                                                style: TextStyle(
                                                    color: purpleTextColor,
                                                    fontFamily: 'lato',
                                                    letterSpacing: 0.25,
                                                    fontSize: 14.0),
                                              ),
                                              TextSpan(
                                                text: "/Kg",
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontFamily: 'lato',
                                                    letterSpacing: 0.25,
                                                    fontSize: 14.0),
                                              ),
                                            ])),
                                        Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockVertical * 4),
                                            child: RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(children: <TextSpan>[
                                                  TextSpan(
                                                    text: "Stok : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ),
                                                  TextSpan(
                                                    text: " 830 ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ), TextSpan(
                                                    text: "Kg",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  )
                                                ]))
                                        ), Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockVertical * 1),
                                            child: RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(children: <TextSpan>[
                                                  TextSpan(
                                                    text: "Umur : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ),
                                                  TextSpan(
                                                    text: " 20hr - 40hr ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ),
                                                ]))
                                        ), Container(
                                            margin: EdgeInsets.only(
                                                top: SizeConfig.blockVertical * 1),
                                            child: RichText(
                                                textAlign: TextAlign.left,
                                                text: TextSpan(children: <TextSpan>[
                                                  TextSpan(
                                                    text: "Jenis produk : ",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ),
                                                  TextSpan(
                                                    text: "Pelet Apung",
                                                    style: TextStyle(
                                                        color: Colors.black,
                                                        fontFamily: 'lato',
                                                        fontWeight: FontWeight.bold,
                                                        letterSpacing: 0.25,
                                                        fontSize: 13.0),
                                                  ),
                                                ]))
                                        ),

                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockVertical * 4),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Deskripsi produk",
                                  style: TextStyle(
                                      fontFamily: 'poppins',
                                      letterSpacing: 0.4,
                                      fontWeight: FontWeight.w700,
                                      fontSize: subTitleLogin),
                                )
                            ), Container(
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockVertical * 2),
                                alignment: Alignment.centerLeft,
                                child: Text(
                                 widget.desc,
                                  style: TextStyle(
                                      fontFamily: 'lato',
                                      color: greyTextColor,
                                      letterSpacing: 0.4,
                                      fontSize: 15.0),
                                )
                            ),
                            Container(
                              height: 45.0,
                              width: MediaQuery
                                  .of(context)
                                  .size
                                  .width,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockVertical * 3,
                                  right: SizeConfig.blockVertical * 3,
                                  top: SizeConfig.blockVertical * 3),
                              child: CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor:
                                    colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () => {
                                      Navigator.push(
                                          context,
                                          PageTransition(
                                              type: PageTransitionType.fade,
                                              // duration: Duration(microseconds: 1000),
                                              child: CheckoutView()))
                                    },
                                    child: Text(
                                      "Pakai Pakan ini",
                                      style: TextStyle(
                                          color: Colors.white,
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
                            SizedBox(
                              height: 20,
                            )
                          ],
                        ))
                  ],
                ))
          ],
        )));
  }
}
