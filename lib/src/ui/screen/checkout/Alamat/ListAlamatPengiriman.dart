import 'dart:ui';

import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as checkout;
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/TambahAlamatView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class ListAlamatPengiriman extends StatefulWidget {
  final String idKolam;

  ListAlamatPengiriman(
      {Key key, this.idKolam})
      : super(key: key);

  @override
  _ListAlamatPengirimanState createState() => _ListAlamatPengirimanState();
}

class _ListAlamatPengirimanState extends State<ListAlamatPengiriman> {
  var blox;
  var _nama = " ";
  var _alamat = " ";
  var _phone = " ";



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
    super.initState();
  }




  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
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
              "Alamat Pengiriman",
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
                              Container(
                                  margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
                                  width: double.infinity,
                                  child: CustomElevation(
                                      height: 40.0,
                                      child: RaisedButton(
                                        highlightColor: colorPrimary,
                                        //Replace with actual colors
                                        color: colorPrimary,
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  child: TambahAlamatView(
                                                    idKolam: widget.idKolam,
                                                  )))
                                        },
                                        child: Text(
                                          "Alamat Baru",
                                          style: h3.copyWith(color: Colors.white),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius: new BorderRadius.circular(30.0),
                                        ),
                                      )))
                            ],
                          ),
                        ),
                      ),

                    ],
                  ))
            ],
          ),
        ));
  }
}
