import 'dart:async';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/otp/OtpView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class TambahKolamView extends StatefulWidget {
  const TambahKolamView({Key key}) : super(key: key);

  @override
  _TambahKolamViewState createState() => _TambahKolamViewState();
}

class _TambahKolamViewState extends State<TambahKolamView> {
  TextEditingController countController = new TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  @override
  void initState() {
    countController.text = "3";
    super.initState();
  }

  void _btnTambahKolam() async {
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    var status = await bloc.funInsertKolam(countController.text.toString());
    Navigator.of(context).pop();
    print(status);
    if (status) {
      showDialog(
        context: context,
        builder: (BuildContext context) =>
            AlertSuccess(context, DashboardView()),
      );
      Timer(const Duration(seconds: 1), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: DashboardView()));
      });
    } else {
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
    }
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => {
              Navigator.push(
                  context,
                  PageTransition(
                      type: PageTransitionType.rightToLeft,
                      child: DashboardView()))
            },
          ),
          actions: <Widget>[],
          backgroundColor: Colors.white,
          brightness: Brightness.light,
          title: Text(
            "Tambah Kolam",
            style: h3,
          ),
        ),
        // resizeToAvoidBottomPadding: false,
        // drawer: Drawers(context),
        body: Stack(
          children: [
            new Container(
              margin: EdgeInsets.only(
                  left: SizeConfig.blockVertical * 3,
                  right: SizeConfig.blockVertical * 3),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Align(
                                alignment: Alignment.center,
                                child: DetailNull(context)),
                            Text(
                              "Anda mau menambah berapa kolam ? ",
                              textAlign: TextAlign.center,
                              style: h3.copyWith(
                                  color: blackTextColor,
                                  fontWeight: FontWeight.w700),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockVertical * 2),
                              child: Text(
                                subTextNullFirst,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontFamily: 'poppins',
                                    letterSpacing: 0.25,
                                    fontSize: 14.0),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(
                                  left: 30.0, right: 30.0, top: 10.0),
                              child: Center(
                                child: Container(
                                  width: 200.0,
                                  padding:
                                  EdgeInsets.only(left: 30.0, right: 30.0),
                                  child: TextFormField(
                                    controller: countController,
                                    textAlign: TextAlign.center,
                                    decoration: EditTextDecorationText(
                                        context, "", 0, 0, 0, 0),
                                    keyboardType: TextInputType.number,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'lato',
                                        fontSize: subTitleLogin),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 45.0,
                              width: MediaQuery.of(context).size.width,
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockVertical * 3,
                                  right: SizeConfig.blockVertical * 3,
                                  top: SizeConfig.blockVertical * 3),
                              child: CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor: colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () => {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) =>
                                            AlertquestionInsert(
                                                context, DashboardView()),
                                      )
                                    },
                                    child: Text(
                                      "Tambah Kolam",
                                      style: TextStyle(
                                          color: backgroundColor,
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
                        )),
          ],
        ));
  }

  Widget AlertquestionInsert(BuildContext context, Widget success) {
    final Widget data = Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Apakah Anda Yakin ? ",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 15.0),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 35.0,
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 1,
                          right: SizeConfig.blockVertical * 1,
                          top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 35.0,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () => {_btnTambahKolam()},
                            child: Text(
                              "Ya",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                  letterSpacing: 1.25,
                                  fontSize: subTitleLogin),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ))),
                  Container(
                    height: 35.0,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 1,
                        top: SizeConfig.blockVertical * 3),
                    child: CustomElevation(
                        height: 35.0,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: redTextColor,
                          onPressed: () => {Navigator.pop(context, true)},
                          child: Text(
                            "Tidak",
                            style: TextStyle(
                                color: backgroundColor,
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
              )
            ],
          ),
        ),
      ),
    );
    return data;
  }
}
