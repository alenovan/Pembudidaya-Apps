import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/Models/ProfileModels.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/KtpScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:progress_dialog/progress_dialog.dart';

class BiodataScreen extends StatefulWidget {
  const BiodataScreen({Key key}) : super(key: key);

  @override
  _BiodataScreenState createState() => _BiodataScreenState();
}

class _BiodataScreenState extends State<BiodataScreen> {
  var blox;
  var loop = 0;

  @override
  void initState() {
    update();
    super.initState();
  }

  bool _clickForgot = true;
  bool isButtonEnabled = false;
  TextEditingController namaLengkapController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController kotaController = TextEditingController();
  TextEditingController provinsiController = TextEditingController();
  TextEditingController kodePosController = TextEditingController();
  TextEditingController kelurahanController = TextEditingController();
  TextEditingController kecamatanController = TextEditingController();

  void _toggleSimpan() async {
    if (isButtonEnabled) {
      Navigator.of(context).push(new MaterialPageRoute<Null>(
          builder: (BuildContext context) {
            return LoadingShow(context);
          },
          fullscreenDialog: true));
      var status = await bloc.funUpdateProfile(
        namaLengkapController.text.toString(),
        alamatController.text.toString(),
        kotaController.text.toString(),
        provinsiController.text.toString(),
        kelurahanController.text.toString(),
        kecamatanController.text.toString(),
        kodePosController.text.toString(),
      );
      Navigator.of(context).pop();
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade,
              // duration: Duration(microseconds: 1000),
              child: KtpScreen()));
    } else {
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
    }
  }

  void checkInput() {
    if ((namaLengkapController.text.trim() != "") &&
        (alamatController.text.trim() != "") &&
        (kotaController.text.trim() != "") &&
        (provinsiController.text.trim() != "") &&
        (kodePosController.text.trim() != "") &&
        (kelurahanController.text.trim() != "") &&
        (kecamatanController.text.trim() != "")) {
      setState(() {
        isButtonEnabled = true;
      });
    } else {
      setState(() {
        isButtonEnabled = false;
      });
    }
  }

  void update() async {
    blox = await bloc.getProfile();
    namaLengkapController.text = blox['data']['name'];
    alamatController.text = blox['data']['address'];
    kotaController.text = blox['data']['city'];
    provinsiController.text = blox['data']['province'];
    kelurahanController.text = blox['data']['district'];
    kecamatanController.text = blox['data']['region'];
    kodePosController.text = blox['data']['postal_code'];
    checkInput();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          AppbarForgot(
              context, "Aktivasi Akun ", ProfileScreen(), Colors.white),
              Expanded(child:
              SingleChildScrollView(
                  physics: new BouncingScrollPhysics(),
                  child:Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 5,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Nama Lengkap",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: namaLengkapController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Alamat",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: alamatController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Kota",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: kotaController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Provinsi",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: provinsiController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Kecamatan",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: kecamatanController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Kelurahan",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: kelurahanController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                      keyboardType: TextInputType.text,
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
                        top: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 5),
                    child: Text(
                      "Kode Pos",
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
                      onChanged: (val) {
                        checkInput();
                      },
                      controller: kodePosController,
                      decoration:
                      EditTextDecorationText(context, "", 20.0, 0, 0, 0),
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
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 5,
                                    right: SizeConfig.blockVertical * 5,
                                    top: 15.0),
                                child: CustomElevation(
                                    height: 30.0,
                                    child: RaisedButton(
                                      highlightColor: colorPrimary,
                                      //Replace with actual colors
                                      color: isButtonEnabled
                                          ? colorPrimary
                                          : editTextBgColor,
                                      onPressed: () => _toggleSimpan(),
                                      child: Text(
                                        isButtonEnabled
                                            ? "NEXT"
                                            : "Lengkapi data diatas",
                                        style: TextStyle(
                                            color: isButtonEnabled
                                                ? backgroundColor
                                                : blackTextColor,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'poppins',
                                            letterSpacing: 1.25,
                                            fontSize: 15.0),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(30.0),
                                      ),
                                    )),
                              ),
                              Container(
                                height: 45.0,
                                width: MediaQuery.of(context).size.width,
                                margin: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 5,
                                    right: SizeConfig.blockVertical * 5,
                                    top: 15.0),
                                child: CustomElevation(
                                    height: 30.0,
                                    child: RaisedButton(
                                      highlightColor: redTextColor,
                                      //Replace with actual colors
                                      color: _clickForgot
                                          ? redTextColor
                                          : editTextBgColor,
                                      onPressed: () => {},
                                      child: Text(
                                        "Batal",
                                        style: TextStyle(
                                            color: _clickForgot
                                                ? backgroundColor
                                                : blackTextColor,
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
                          )))
                ],
              )))
        ],
      ),
    );
  }
}
