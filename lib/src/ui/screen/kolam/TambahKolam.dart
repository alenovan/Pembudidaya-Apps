import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotResetView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotVerifView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
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
import 'package:dotted_border/dotted_border.dart';
class TambahKolam extends StatefulWidget {
  const TambahKolam({Key key}) : super(key: key);

  @override
  _TambahKolamState createState() => _TambahKolamState();
}

class _TambahKolamState extends State<TambahKolam> {
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
            child: PenentuanPanenView()));
  }

  Future<File> imageFile;

  //Open gallery
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      appBar: AppbarForgot(context, "Aktivasi Kolam", LoginView(),Colors.white),
      body: Stack(
        children: [
          Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.blockVertical * 5,
                    top: SizeConfig.blockVertical * 5,
                    right: SizeConfig.blockVertical * 5),
                child: Text(
                  "Nama Kolam",
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
                      context, "Nama", 20.0, 0, 0, 0),
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
                child:GestureDetector(
                  onTap: (){
                    pickImageFromGallery(ImageSource.gallery);
                  },
                  child: roundedRectBorderWidget(context),
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
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 5,
                              right: SizeConfig.blockVertical * 5,
                              top: 15.0),
                          child: CustomElevation(
                              height: 30.0,
                              child: RaisedButton(
                                highlightColor: colorPrimary, //Replace with actual colors
                                color: _clickForgot ? colorPrimary : editTextBgColor,
                                onPressed: () => _toggleButtonForgot(),
                                child: Text(
                                  "Tambahkan",
                                  style: TextStyle(
                                      color: _clickForgot ? backgroundColor : blackTextColor,
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
                                highlightColor: redTextColor, //Replace with actual colors
                                color: _clickForgot ? redTextColor : editTextBgColor,
                                onPressed: () => _toggleButtonForgot(),
                                child: Text(
                                  "Batal",
                                  style: TextStyle(
                                      color: _clickForgot ? backgroundColor : blackTextColor,
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
                    ))),
          )

        ],
      ));
  }

  Widget showImage() {
    print("di click");
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

}


Widget roundedRectBorderWidget(BuildContext context) {
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
        height: 125,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              FontAwesomeIcons.upload,
              color: Colors.grey[400],
              size: 26.0,
            ),
            Container(
              margin: EdgeInsets.only(top:10),
              child:Text(
                "Unggah Gambar",
                style: TextStyle(
                  color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                    fontFamily: 'poppins',
                    letterSpacing: 1.25,
                    fontSize: 15.0),
              )
            )
          ],
        ),
      ),
    ),
  );
}


