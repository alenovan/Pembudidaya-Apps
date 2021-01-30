import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanv2/LaporanScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/bloc/MonitorBloc.dart' as monitor;
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class BottomSheetLaporan extends StatefulWidget {
  DateTime date;
  final String idKolam;

  BottomSheetLaporan({Key key, @required this.date, this.idKolam})
      : super(key: key);

  @override
  _MyBottomSheetState createState() => _MyBottomSheetState();
}

class _MyBottomSheetState extends State<BottomSheetLaporan> {
  bool _status_null_laporan = true;
  TextEditingController srController = TextEditingController();
  TextEditingController pakanController = TextEditingController();
  TextEditingController weightController = TextEditingController();

  void _simpanLaporan(DateTime date) async {
    var dateSelected = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID").format(date);
    LoadingDialog.show(context);
    if (weightController.text.trim().length >= 1) {
      // print(weightController.text);
      var statusFeed = await monitor.bloc.feedMonitor(
          widget.idKolam, pakanController.text.toString(), dateSelected);
      if (statusFeed) {
        var statusSr = await monitor.bloc
            .feedSR(widget.idKolam, srController.text.toString(), dateSelected);
        if (statusSr) {
          Timer(Duration(seconds: 2), () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType
                        .fade,
                    child: LaporanMain(
                      page: 2,
                      laporan_page: "home",
                      idKolam: widget.idKolam,
                    )));
          });
          // var statusWeight = await monitor.bloc.weightMonitor(
          //     widget.idKolam, weightController.text.toString(), dateSelected);
          // if (statusWeight) {
          //   AppExt.popScreen(context);
          //   BottomSheetFeedback.show_success(context, title: "Selamat", description: "Monitoring Tanggal ${date.day} Berhasil");
          //   Timer(Duration(seconds: 2), () {
          //     Navigator.push(
          //         context,
          //         PageTransition(
          //             type: PageTransitionType
          //                 .fade,
          //             child: LaporanMain(
          //               page: 2,
          //               laporan_page: "home",
          //               idKolam: widget.idKolam,
          //             )));
          //   });
          // } else {
          //   AppExt.popScreen(context);
          //   BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di pada jumlah berat ikan");
          // }
        } else {
          AppExt.popScreen(context);
          BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di pada jumlah kematian ikan");
        }
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali pada jumlah pakan");
      }
    } else {
      var statusFeed = await monitor.bloc.feedMonitor(
          widget.idKolam, pakanController.text.toString(), dateSelected);
      if (statusFeed) {
        var statusSr = await monitor.bloc
            .feedSR(widget.idKolam, srController.text.toString(), dateSelected);
        if (statusSr) {
          AppExt.popScreen(context);
          BottomSheetFeedback.show_success(context, title: "Selamat", description: "Monitoring Tanggal ${date.day} Berhasil");
          Timer(Duration(seconds: 2), () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType
                        .fade,
                    child: LaporanMain(
                      page: 2,
                      laporan_page: "home",
                      idKolam: widget.idKolam,
                    )));
          });
        } else {
          AppExt.popScreen(context);
          BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di pada jumlah kematian ikan");
        }
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali pada jumlah pakan");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    double _screenWidth = MediaQuery.of(context).size.width;
    var frameInsert = Container(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              width: _screenWidth * (15 / 100),
              height: 7,
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.15),
                borderRadius: BorderRadius.circular(7.5 / 2),
              ),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(40),
          ),
          Text(
            "Berapa pakan yang kamu habiskan hari ini ? (Kilogram)",
            textAlign: TextAlign.start,
            style: caption.copyWith(
                color: Colors.black,
                fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            child: TextFormField(
              controller: pakanController,
              decoration:
                  EditTextDecorationText(context, "Kilogram", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: subTitleLogin),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
            "Berapa ikan yang mati pada hari ini ?",
            textAlign: TextAlign.left,
            style: caption.copyWith(
                color: Colors.black,
                fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            child: TextFormField(
              controller: srController,
              decoration: EditTextDecorationText(context, "0", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: subTitleLogin),
            ),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Text(
              "Berapa berat ikan yang anda timbang pada hari ini ? gram per ekor (opsional)",
              textAlign: TextAlign.start,
              style: caption.copyWith(
                  color: Colors.black,
                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40))),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              controller: weightController,
              decoration: EditTextDecorationText(context, "0", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
            ),
          ),
          Container(
            height: ScreenUtil().setHeight(120),
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 5,
                right: SizeConfig.blockVertical * 5,
                top: 15.0),
            child: CustomElevation(
                height: ScreenUtil().setHeight(120),
                child: RaisedButton(
                  highlightColor: colorPrimary,
                  color: colorPrimary,
                  onPressed: () {
                    // setState(() {
                    //   _status_null_laporan = true;
                    // });]
                    _simpanLaporan(widget.date);
                  },
                  child: Text(
                    "Simpan laporan",
                    style: TextStyle(
                        color: backgroundColor,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'poppins',
                        letterSpacing: 1.25,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                  ),
                  shape: new RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(30.0),
                  ),
                )),
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );

    var frameNull = Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          child: Icon(
            FontAwesomeIcons.angleUp,
            color: angleUpIcon,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Laporan Tanggal ${widget.date.day} Kosong",
          textAlign: TextAlign.center,
          style: subtitle2.copyWith(
              color: Colors.black,
              fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
        ),
        Text("Segera buat laporan anda !",
            textAlign: TextAlign.center,
            style: subtitle2.copyWith(
                color: Colors.black,
                fontSize: ScreenUtil(allowFontScaling: false).setSp(40))),
        SizedBox(
          height: 10,
        ),
        Container(
          height: ScreenUtil().setHeight(120),
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: SizeConfig.blockVertical * 5,
              right: SizeConfig.blockVertical * 5,
              top: 15.0),
          child: CustomElevation(
              height: ScreenUtil().setHeight(120),
              child: RaisedButton(
                highlightColor: colorPrimary,
                //Replace with actual colors
                color: colorPrimary,
                onPressed: () {
                  setState(() {
                    _status_null_laporan = false;
                  });
                },
                child: Text(
                  "Buat Laporan",
                  style: TextStyle(
                      color: backgroundColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'poppins',
                      letterSpacing: 1.25,
                      fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                ),
                shape: new RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(30.0),
                ),
              )),
        ),
        SizedBox(
          height: 10,
        ),
      ],
    );
    return AnimatedContainer(
        child: AnimatedCrossFade(
            firstChild: frameNull,
            secondChild: frameInsert,
            crossFadeState: _status_null_laporan
                ? CrossFadeState.showFirst
                : CrossFadeState.showSecond,
            duration: Duration(milliseconds: 400)),
        duration: Duration(milliseconds: 400));
  }
}

void message(BuildContext context, String message) {
  ScreenUtil.instance = ScreenUtil()..init(context);
  double _screenWidth = MediaQuery.of(context).size.width;
  showModalBottomSheet(
      barrierColor: Colors.white.withOpacity(0),
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
      context: context,
      builder: (BuildContext bc) {
        return Container(
          decoration: new BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 4,
                blurRadius: 7,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Container(
                    width: _screenWidth * (15 / 100),
                    height: 7,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(7.5 / 2),
                    ),
                  ),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(50),
                ),
                Container(
                  padding: EdgeInsets.only(top: 20),
                  child: Text(
                    message,
                    textAlign: TextAlign.center,
                    style: subtitle2.copyWith(
                        color: Colors.black,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                  ),
                )
              ],
            ),
          ),
        );
      });
}

Widget bottomSheetInserted(BuildContext context, String date, String pakan,
    String mati, String berat) {
  ScreenUtil.instance = ScreenUtil()..init(context);
  double _screenWidth = MediaQuery.of(context).size.width;
  var data = Container(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Container(
            width: _screenWidth * (15 / 100),
            height: 7,
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.15),
              borderRadius: BorderRadius.circular(7.5 / 2),
            ),
          ),
        ),
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Hari Ini",
                  textAlign: TextAlign.start,
                  style: caption.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    date,
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                  ),
                )
              ],
            ),
            Icon(Icons.more_vert, color: Colors.black),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                FontAwesome.circle,
                color: colorPrimary,
                size: 14.0,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Pakan Keluar",
                  textAlign: TextAlign.start,
                  style: caption.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    pakan + " Kg",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                FontAwesome.circle,
                color: colorPrimary,
                size: 14.0,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Jumlah Ikan Mati",
                  textAlign: TextAlign.start,
                  style: caption.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    mati + " ekor",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(40),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: 10.0, right: 10.0),
              child: Icon(
                FontAwesome.circle,
                color: colorPrimary,
                size: 14.0,
              ),
            ),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Berat Ikan Saat Ini",
                  textAlign: TextAlign.start,
                  style: caption.copyWith(
                      color: Colors.black,
                      fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    berat + " gram",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                  ),
                )
              ],
            ),
          ],
        ),
        SizedBox(
          height: ScreenUtil().setHeight(80),
        ),
      ],
    ),
  );
  return data;
}
