import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/bloc/PakanBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/DatePicker.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';

class TambahLelang extends StatefulWidget {
  final String idKolam;

  const TambahLelang({Key key, @required this.idKolam}) : super(key: key);

  @override
  _TambahLelangState createState() => _TambahLelangState();
}

class _TambahLelangState extends State<TambahLelang> {
  bool _clickForgot = true;

  void _buttonPenentuan() async {

  }


  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          resizeToAvoidBottomPadding: false,
          body: Column(
            children: [
              AppBarContainer(
                  context, "Lelang", LaporanMain(
            page: 1, laporan_page: "Lelang",idKolam: "20",), Colors.white),
              Expanded(child:
              SingleChildScrollView(
                  physics: new BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Produk",
                          style: subtitle2.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Jenis Ikan",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Jumlah Stock (Kilogram)",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Harga Per Kilogram",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Jumlah ikan per Kilogram",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Lelang",
                          style: subtitle2.copyWith(fontWeight: FontWeight.w700),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Tanggal Mulai Lelang",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Tanggal Berakhir Lelang",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 2,
                            right: SizeConfig.blockVertical * 5),
                        child: Text(
                          "Buka Harga",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 14.0),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 5,
                            top: SizeConfig.blockVertical * 1,
                            right: SizeConfig.blockVertical * 5),
                        child: TextFormField(
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),

                      Container(
                          margin: EdgeInsets.only(bottom: 20.0),
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
                                        left: SizeConfig.blockVertical * 5,
                                        right: SizeConfig.blockVertical * 5,
                                        top: 20.0),
                                    child: CustomElevation(
                                        height: 30.0,
                                        child: RaisedButton(
                                          highlightColor: colorPrimary,
                                          //Replace with actual colors
                                          color: colorPrimary,
                                          onPressed: () => {},
                                          child: Text(
                                            "Lelang",
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: subTitleLogin),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(
                                                30.0),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 45.0,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        right: SizeConfig.blockVertical * 5,
                                        top: 15.0),
                                    child: CustomElevation(
                                        height: 30.0,
                                        child: RaisedButton(
                                          highlightColor: redTextColor,
                                          //Replace with actual colors
                                          color: redTextColor,
                                          onPressed: () => {},
                                          // _toggleButtonForgot(),
                                          child: Text(
                                            "Batal",
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: subTitleLogin),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(
                                                30.0),
                                          ),
                                        )),
                                  ),
                                ],
                              )))
                    ],
                  ))),
            ],
          ),
        ));
  }
}
