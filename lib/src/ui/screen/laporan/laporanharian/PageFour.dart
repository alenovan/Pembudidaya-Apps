import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/bloc/MonitorBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class PageFour extends StatefulWidget {
  final String idKolam;
  final int tgl;
  final int bulan;
  final int tahun;
  final String dataPageTwo;
  final String dataPageThree;
  final DateTime isoData;
  PageFour({Key key, this.idKolam, this.tgl, this.bulan, this.tahun, this.dataPageTwo, this.dataPageThree, this.isoData}) : super(key: key);

  @override
  _PageFourState createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  bool _showDetail = true;
  void _toggleDetail(status_all) async {
   var dateSelected = DateFormat("yyyy-MM-dd hh:mm:ss","id_ID").format(widget.isoData);
   print(dateSelected);
    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    if(status_all){
      var data = await bloc.weightMonitor(widget.idKolam,weightController.text.toString(),dateSelected);
      var status = data['status'];
      if(status == 1){
        var statusFeed = await bloc.feedMonitor(widget.idKolam,widget.dataPageTwo,dateSelected);
        if(statusFeed){
          var statusSr = await bloc.feedSR(widget.idKolam,widget.dataPageThree,dateSelected);
          if(statusSr){
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AlertSuccess(context, LaporanMain(
                    idKolam: widget
                        .idKolam
                        .toString(),
                    page: 2,
                    laporan_page:
                    "home",
                  )),
            );

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child:  LaporanMain(
                      idKolam: widget
                          .idKolam
                          .toString(),
                      page: 2,
                      laporan_page:
                      "home",
                    )));
          }else{
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di halaman jumlah kematian ikan");
          }
        }else{
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di halaman jumlah pakan");
        }
      }else{
        Navigator.of(context).pop();
        Navigator.of(context).pop();
        var message  = data['data']['message'].toString();
        BottomSheetFeedback.show(context, title: "Mohon Maaf", description: message);
      }
    }else{
        var statusFeed = await bloc.feedMonitor(widget.idKolam,widget.dataPageTwo,dateSelected);
        if(statusFeed){
          var statusSr = await bloc.feedSR(widget.idKolam,widget.dataPageThree,dateSelected);
          if(statusSr){
            showDialog(
              context: context,
              builder: (BuildContext context) =>
                  AlertSuccess(context, LaporanMain(
                    idKolam: widget
                        .idKolam
                        .toString(),
                    page: 2,
                    laporan_page:
                    "home",
                  )),
            );

            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child:  LaporanMain(
                      idKolam: widget
                          .idKolam
                          .toString(),
                      page: 2,
                      laporan_page:
                      "home",
                    )));
          }else{
            Navigator.of(context).pop();
            Navigator.of(context).pop();
            BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di halaman jumlah kematian ikan");
          }
        }else{
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di halaman jumlah pakan");
        }
    }

  }
  TextEditingController weightController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // print(DateFormat("yyyy-MM-dd hh:mm:ss","id_ID").format(widget.isoData));
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                   Navigator.of(context).pop()
              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Laporan",
              style: h3,
            ),
          ),
          body:  Column(
              children: [
          Expanded(child: Container(
                margin: EdgeInsets.only(
                    left: SizeConfig.blockVertical * 3,
                    right: SizeConfig.blockVertical * 3,
                    bottom: SizeConfig.blockVertical * 20),
                color: backgroundGreyColor,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Container(
                            padding: EdgeInsets.all(25.0),
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: Text(
                                    "Berapa berat ikan yang anda timbang pada hari ini ? (opsional)",
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'poppins',
                                        letterSpacing: 0.25,
                                        fontSize: 16.0),
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(top: 10.0),
                                  child: TextFormField(
                                    controller: weightController,
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
                                Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      height: 45.0,
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 3,
                                          right: SizeConfig.blockVertical * 3,
                                          top: SizeConfig.blockVertical * 3),
                                      child: CustomElevation(
                                          height: 30.0,
                                          child: RaisedButton(
                                            highlightColor:
                                            colorPrimary, //Replace with actual colors
                                            color: redTextColor,
                                            onPressed: () => {
                                              Navigator.pop(context,true)
                                            },
                                            child: Text(
                                              "Back",
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
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockVertical * 3,
                                            right: SizeConfig.blockVertical * 3,
                                            top: SizeConfig.blockVertical * 3),
                                        child: CustomElevation(
                                            height: 30.0,
                                            child: RaisedButton(
                                              highlightColor:
                                              colorPrimary, //Replace with actual colors
                                              color: colorPrimary,
                                              onPressed: () => {
                                                if(weightController.text.trim().length < 1){
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertquestionInsert(
                                                            context, false),
                                                  )
                                                }else{
                                                  showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) =>
                                                        AlertquestionInsert(
                                                            context,true),
                                                  )

                                                }

                                              },
                                              child: Text(
                                                "Next",
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
                                            ))),
                                  ],
                                )
                              ],
                            )))
                  ],
                )))
              ],
          )),);

  }
  Widget AlertquestionInsert(BuildContext context, bool success) {
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
                            onPressed: () => {_toggleDetail(success)},
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
