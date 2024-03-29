import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class KtpScreen extends StatefulWidget {
  final String from;

  const KtpScreen({Key key, this.from}) : super(key: key);

  @override
  _KtpScreenState createState() => _KtpScreenState();
}

class _KtpScreenState extends State<KtpScreen> {
  bool _clickForgot = true;
  String base64ImageKtp;
  String base64ImageSelfie;

  TextEditingController noKtpController = TextEditingController();

  void _toggleButtonForgot() async {
    if (base64ImageKtp != null || base64ImageSelfie != null) {
      LoadingDialog.show(context);
      var status = await bloc.funUpdateProfileKtp(
          noKtpController.text.toString(), base64ImageKtp, base64ImageSelfie);
      AppExt.popScreen(context);
      if (status) {
        if (widget.from == "dashboard") {
          BottomSheetFeedback.show_success(context, title: "Selamat", description: "Aktivasi anda berhasil");
          Timer(const Duration(seconds: 1), () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: DashboardView()));
          });
        } else {
          BottomSheetFeedback.show_success(context, title: "Selamat", description: "Aktivasi anda berhasil");
          Timer(const Duration(seconds: 1), () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade, child: ProfileScreen()));
          });
        }
      } else {
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf", description: "Pastikan data terisi semua");
      }
    } else {
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
    }
  }

  File _imageKtp;
  File _imageSelfie;

  _imgFromCamera() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    } catch (e) {
      print(e);
    }

    setState(() {
      base64ImageKtp = image.path;
      _imageKtp = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      base64ImageKtp = image.path;
      _imageKtp = image;
    });
  }

  _imgFromCameraSelfie() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    } catch (e) {
      print(e);
    }

    setState(() {
      base64ImageSelfie = image.path;
      _imageSelfie = image;
    });
  }

  _imgFromGallerySelfie() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      base64ImageSelfie = image.path;
      _imageSelfie = image;
    });
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            backgroundColor: Colors.white,
            resizeToAvoidBottomInset: false,
            body: Column(
              children: [
                AppbarForgot(
                    context, "Aktivasi Akun ", Colors.white, widget.from),
                Expanded(
                  child: SingleChildScrollView(
                      physics: new BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "No KTP",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 15.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              controller: noKtpController,
                              decoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 15.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Foto Ktp",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 15.sp),
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
                              child:
                                  roundedRectBorderWidget(context, _imageKtp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Foto Selfie dengan KTP",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: 15.sp),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: GestureDetector(
                              onTap: () {
                                _showPickerSelfie(context);
                              },
                              child: roundedRectBorderWidget(
                                  context, _imageSelfie),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.0),
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
                                          color: _clickForgot
                                              ? colorPrimary
                                              : editTextBgColor,
                                          onPressed: () =>
                                              _toggleButtonForgot(),
                                          child: Text(
                                            "Kirim",
                                            style: TextStyle(
                                                color: _clickForgot
                                                    ? backgroundColor
                                                    : blackTextColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: 15.sp),
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
                                          onPressed: () =>
                                              _toggleButtonForgot(),
                                          child: Text(
                                            "Batal",
                                            style: TextStyle(
                                                color: _clickForgot
                                                    ? backgroundColor
                                                    : blackTextColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: 15.sp),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                                new BorderRadius.circular(30.0),
                                          ),
                                        )),
                                  ),
                                ],
                              ))
                        ],
                      )),
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
              height: ScreenUtil().setHeight(350),
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

  void _showPickerSelfie(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: ScreenUtil().setHeight(350),
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
                        _imgFromGallerySelfie();
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
                        _imgFromCameraSelfie();
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
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: _image != null
            ? Image.file(
                _image,
                fit: BoxFit.fitWidth,
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
