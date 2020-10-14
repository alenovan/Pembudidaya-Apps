import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/pakan/DetailPenentuanPakan.dart';
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
class PenentuanPakanView extends StatefulWidget {
  const PenentuanPakanView({Key key}) : super(key: key);

  @override
  _PenentuanPakanViewState createState() => _PenentuanPakanViewState();
}

class _PenentuanPakanViewState extends State<PenentuanPakanView> {
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
            child: CheckoutView()));
  }

  Future<File> imageFile;

  //Open gallery
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  GestureDetector gs = GestureDetector(
      onTap: () {
        // _togglevisibility();
      },
      child: Icon(
        Icons.search ,
        color: greyIconColor,
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[100],
        resizeToAvoidBottomPadding: false,
        appBar: AppbarForgot(context, "Penentuan pakan", LoginView(),Colors.white),
        body: Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockVertical * 5,left: SizeConfig.blockVertical * 2,right: SizeConfig.blockVertical * 2),
            child:Column(
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 2,
                      right: SizeConfig.blockVertical * 2),
                  child: Column(
                    children: [
                      Container(
                        child: TextFormField(
                          decoration: EditText(
                              context, "Cari Pabrik Pakan", 20.0, 0, 0, 0,gs),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child:Container(
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 2,
                        right: SizeConfig.blockVertical * 2),
                  child: Container(
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 3),
                    child:ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount: 20,
                      itemBuilder: (BuildContext context, int index) {
                        return GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: DetailPenentuanPakan()));
                            },
                            child:Container(
                              child: CardPenentuanPakan(context,"Pabrik Si panji","Pilih untuk lihat detail",1),

                            )
                        );
                      },
                    )
                  )),
                ),
              ],
            )

        ));
  }


}


