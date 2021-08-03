import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/menu/menu_screen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class TambahKolam extends StatefulWidget {
  final String idKolam;

  const TambahKolam({Key key, @required this.idKolam}) : super(key: key);

  @override
  _TambahKolamState createState() => _TambahKolamState();
}

class _TambahKolamState extends State<TambahKolam> {
  bool _clickForgot = true;
  String base64IKolam;

  void _toggleButtonForgot() async {
    // print(base64IKolam);
    if(base64IKolam != null){
      LoadingDialog.show(context);
      var status = await bloc.funAktivasiKolam(
          widget.idKolam,base64IKolam);
      AppExt.popScreen(context);
      if(status){
        BottomSheetFeedback.show_success(context, title: "Selamat", description: "Aktivasi Kolam Anda Berhasil");
        Timer(const Duration(seconds: 1), () {
          Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: MenuScreen(idKolam: widget.idKolam,)));
        });
      }else{
        BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
      }
    }else{
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Pastikan data terisi semua");
    }
  }
  File _image;

  _imgFromCamera() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    } catch (e) {
      print(e);
    }


    setState(() {
      base64IKolam = image.path;
      _image = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      base64IKolam = image.path;
      _image = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
    child:Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/png/header_laporan.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 200.h,
              ),
            ),
            Container(
                child: ListView(
                  children: [
                    AppBarContainer(context, "", DashboardView(),Colors.transparent),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(70),
                          right: ScreenUtil().setWidth(50)),
                      child:  Text(
                        "Aktivasi Kolam ",
                        style:  h3.copyWith(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.sp),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(10),
                          left: ScreenUtil().setWidth(70),
                          right: ScreenUtil().setWidth(50)),
                      child: Text(
                        "Hai Fotokan kolam anda agar kami tau bahwa anda mempunyai kolam !",
                        style: caption.copyWith(
                            color: Colors.grey,
                            fontWeight: FontWeight.w700,fontSize: 20.sp),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 5,
                          top: ScreenUtil().setHeight(80),
                          right: SizeConfig.blockVertical * 5),
                      child: Text(
                        "Foto Kolam",
                        style: TextStyle(
                            color: appBarTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: 20.sp),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 5,
                          top: SizeConfig.blockVertical * 2,
                          right: SizeConfig.blockVertical * 5),
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: roundedRectBorderWidget(context, _image),
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
                                  height: 45.h,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 5,
                                      right: SizeConfig.blockVertical * 5,
                                      top: 15.0),
                                  child: CustomElevation(
                                      height: 30.h,
                                      child: RaisedButton(
                                        highlightColor: colorPrimary,
                                        //Replace with actual colors
                                        color: _clickForgot
                                            ? colorPrimary
                                            : editTextBgColor,
                                        onPressed: () => _toggleButtonForgot(),
                                        child: Text(
                                          "Tambahkan",
                                          style: TextStyle(
                                              color: _clickForgot
                                                  ? backgroundColor
                                                  : blackTextColor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'poppins',
                                              letterSpacing: 1.25,
                                              fontSize: 20.sp),
                                        ),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                          new BorderRadius.circular(30.0),
                                        ),
                                      )),
                                ),
                                Container(
                                  height: 45.h,
                                  width: MediaQuery
                                      .of(context)
                                      .size
                                      .width,
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 5,
                                      right: SizeConfig.blockVertical * 5,
                                      top: 15.0),
                                  child: CustomElevation(
                                      height: 30.h,
                                      child: RaisedButton(
                                        highlightColor: redTextColor,
                                        //Replace with actual colors
                                        color: _clickForgot
                                            ? redTextColor
                                            : editTextBgColor,
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              PageTransition(
                                                  type: PageTransitionType.fade,
                                                  // duration: Duration(microseconds: 1000),
                                                  child: DashboardView())),
                                        },
                                        child: Text(
                                          "Batal",
                                          style: TextStyle(
                                              color: _clickForgot
                                                  ? backgroundColor
                                                  : blackTextColor,
                                              fontWeight: FontWeight.w500,
                                              fontFamily: 'poppins',
                                              letterSpacing: 1.25,
                                              fontSize: 20.sp),
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
                )),
          ],
        )));
  }

  void _showPicker(context) {

    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: 120.h,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _imgFromGallery();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.image,
                            color: colorPrimary,
                            size: 50,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Galeri",
                            style:
                            caption.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _imgFromCamera();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.camera,
                            color: colorPrimary,
                            size: 50,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Camera",
                            style:
                            caption.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}

Widget roundedRectBorderWidget(BuildContext context, File _image) {
  return DottedBorder(
    color: greyLineColor,
    dashPattern: [8, 4],
    strokeWidth: 2,
    strokeCap: StrokeCap.round,
    borderType: BorderType.RRect,
    radius: Radius.circular(12),
    child: ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(12)),
      child: Container(
        height: 200,
        width: MediaQuery
            .of(context)
            .size
            .width,
        color: Colors.grey[100],
        child: _image != null
            ? Image.file(
          _image,
          fit: BoxFit.fill,
          height: 100.0,
        )
            : Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.upload,
              color: Colors.grey[400],
              size: 26.0,
            ),
            Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Unggah Gambar",
                  style: TextStyle(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.w500,
                      fontFamily: 'poppins',
                      letterSpacing: 1.25,
                      fontSize: 15.0),
                ))
          ],
        ),
      ),
    ),
  );
}
