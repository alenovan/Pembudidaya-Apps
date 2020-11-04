import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
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
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';

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
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            LoadingShow(context),
      );
      var status = await bloc.funAktivasiKolam(
          widget.idKolam,base64IKolam);
      Navigator.of(context).pop(true);
      if(status){
        showDialog(
          context: context,
          builder: (BuildContext context) => AlertSuccess(context, ProfileScreen()),
        );
        Timer(const Duration(seconds: 1), () {
          Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        // duration: Duration(microseconds: 1000),
                        child: PenentuanPanenView(idKolam: widget.idKolam,)));
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
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
    ),
    child:Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        body: Stack(
          children: [
            Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    AppBarContainer(context, "Aktivasi Kolam", DashboardView(),Colors.white),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       left: SizeConfig.blockVertical * 5,
                    //       right: SizeConfig.blockVertical * 5),
                    //   child: Text(
                    //     "Nama Kolam",
                    //     style: TextStyle(
                    //         color: appBarTextColor,
                    //         fontFamily: 'lato',
                    //         letterSpacing: 0.4,
                    //         fontSize: 14.0),
                    //   ),
                    // ),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //       left: SizeConfig.blockVertical * 5,
                    //       top: SizeConfig.blockVertical * 1,
                    //       right: SizeConfig.blockVertical * 5),
                    //   child: TextFormField(
                    //     decoration:
                    //     EditTextDecorationText(context, "Nama", 20.0, 0, 0, 0),
                    //     keyboardType: TextInputType.number,
                    //     style: TextStyle(
                    //         color: blackTextColor,
                    //         fontFamily: 'lato',
                    //         letterSpacing: 0.4,
                    //         fontSize: subTitleLogin),
                    //   ),
                    // ),
                    Container(
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 5,
                          top: SizeConfig.blockVertical * 2,
                          right: SizeConfig.blockVertical * 5),
                      child: Text(
                        "Foto Kolam",
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
                          top: SizeConfig.blockVertical * 2,
                          right: SizeConfig.blockVertical * 5),
                      child: GestureDetector(
                        onTap: () {
                          _showPicker(context);
                        },
                        child: roundedRectBorderWidget(context, _image),
                      ),
                    ),
                  ],
                )),
            new Positioned(
              child: Container(
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
                                top: 15.0),
                            child: CustomElevation(
                                height: 30.0,
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
                                        fontSize: subTitleLogin),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(30.0),
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
                                        fontSize: subTitleLogin),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                    new BorderRadius.circular(30.0),
                                  ),
                                )),
                          ),
                        ],
                      ))),
            )
          ],
        )));
  }

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
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
