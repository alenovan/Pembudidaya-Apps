import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
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
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
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
  var lastsr = "";
  var lastpakan = "";
  var lastweight = "";
  var saveFeed = false;
  var saveSr = false;
  var saveWeight = false;

  void _simpanLaporan(DateTime date) async {
    var dateSelected = DateFormat("yyyy-MM-dd hh:mm:ss", "id_ID").format(date);
    LoadingDialog.show(context);
    if (!saveFeed) {
      var statusFeed = await monitor.bloc.feedMonitor(
          widget.idKolam, pakanController.text.toString(), dateSelected);
      if (statusFeed["message"] == "") {
        AppExt.popScreen(context);
        setState(() {
          saveFeed = true;
        });
        lastpakan = pakanController.text.toString();
        BottomSheetFeedback.show_success(context,
            title: "Selamat",
            description: "Monitoring Pakan Tanggal ${date.day} Berhasil");
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf",
            description: "Berat Pakan = " + statusFeed["message"]);
      }
    }

    if (!saveSr) {
      var statusSr = await monitor.bloc
          .feedSR(widget.idKolam, srController.text.toString(), dateSelected);
      if (statusSr["message"] == "") {
        AppExt.popScreen(context);
        setState(() {
          saveSr = true;
        });
        lastsr = srController.text.toString();
        BottomSheetFeedback.show_success(context,
            title: "Selamat",
            description: "Monitoring Kematian Ikan Tanggal ${date.day} Berhasil");
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf",
            description: "Kematian Ikan = " + statusSr["message"]);
      }
    }

    if (!saveWeight) {
      var statusWeight = await monitor.bloc.weightMonitor(
          widget.idKolam, weightController.text.toString(), dateSelected);
      if (statusWeight["message"] == "") {
        AppExt.popScreen(context);
        setState(() {
          saveWeight = true;
        });
        lastweight = weightController.text.toString();
        BottomSheetFeedback.show_success(context,
            title: "Selamat",
            description: "Monitoring Berat Ikan Tanggal ${date.day} Berhasil");
        Timer(Duration(seconds: 2), () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade,
                  child: LaporanMain(
                    page: 1,
                    laporan_page: "home",
                    idKolam: widget.idKolam,
                  )));
        });
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf",
            description: "Berat Ikan = " + statusWeight["message"]);
      }
    }

    // if (weightController.text.trim().length >= 1) {
    //   // print(weightController.text);
    //   var statusFeed = await monitor.bloc.feedMonitor(
    //       widget.idKolam, pakanController.text.toString(), dateSelected);
    //   if (statusFeed["message"] == "") {
    //     saveFeed = true;
    //     var statusSr = await monitor.bloc
    //         .feedSR(widget.idKolam, srController.text.toString(), dateSelected);
    //     if (statusSr["message"] == "") {
    //       saveSr = true;
    //       var statusWeight = await monitor.bloc.weightMonitor(
    //           widget.idKolam, weightController.text.toString(), dateSelected);
    //       if (statusWeight["message"] == "") {
    //         saveWeight = true;
    //         AppExt.popScreen(context);
    //         BottomSheetFeedback.show_success(context, title: "Selamat", description: "Monitoring Tanggal ${date.day} Berhasil");
    //         Timer(Duration(seconds: 2), () {
    //           Navigator.push(
    //               context,
    //               PageTransition(
    //                   type: PageTransitionType
    //                       .fade,
    //                   child: LaporanMain(
    //                     page: 1,
    //                     laporan_page: "home",
    //                     idKolam: widget.idKolam,
    //                   )));
    //         });
    //       } else {
    //         AppExt.popScreen(context);
    //         BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Berat Ikan = "+statusWeight["message"]);
    //       }
    //     } else {
    //       AppExt.popScreen(context);
    //       BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Ikan Mati = "+statusSr["message"]);
    //     }
    //   } else {
    //     AppExt.popScreen(context);
    //     BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Berat Pakan = "+statusFeed["message"]);
    //   }
    // } else {
    //   var statusFeed = await monitor.bloc.feedMonitor(
    //       widget.idKolam, pakanController.text.toString(), dateSelected);
    //   if (statusFeed) {
    //     var statusSr = await monitor.bloc
    //         .feedSR(widget.idKolam, srController.text.toString(), dateSelected);
    //     if (statusSr) {
    //       AppExt.popScreen(context);
    //       BottomSheetFeedback.show_success(context, title: "Selamat", description: "Monitoring Tanggal ${date.day} Berhasil");
    //       Timer(Duration(seconds: 2), () {
    //         Navigator.push(
    //             context,
    //             PageTransition(
    //                 type: PageTransitionType
    //                     .fade,
    //                 child: LaporanMain(
    //                   page: 1,
    //                   laporan_page: "home",
    //                   idKolam: widget.idKolam,
    //                 )));
    //       });
    //     } else {
    //       AppExt.popScreen(context);
    //       BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali di pada jumlah kematian ikan");
    //     }
    //   } else {
    //     AppExt.popScreen(context);
    //     BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali pada jumlah pakan");
    //   }
    // }
  }

  Future<dynamic> dataInserted(date) async {
    var data = await monitor.bloc
        .analyticsMonitorByDate(widget.idKolam, date.toString());
    var datax = json.decode(json.encode(data));
    print(datax);
    return [
      datax["date"].toString(),
      tryCoba(datax["feed_spent"].toString()).toString(),
      tryCoba(datax["fish_died"].toString()).toString(),
      tryCoba(datax["weight"].toString()).toString()
    ];
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    var data = dataInserted(widget.date.toIso8601String());
    data.then((val) {
      setState(() {
        if (val[1].toString() != "-1") {
          saveFeed = true;
          _status_null_laporan = false;
          pakanController.text = val[1].toString();
        }
        if (val[2].toString() != "-1") {
          saveSr = true;
          _status_null_laporan = false;
          srController.text = val[2].toString();
        }
        if (val[3].toString() != "-1") {
          saveWeight = true;
          _status_null_laporan = false;
          weightController.text = val[3].toString();
        }
      });
    });
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
                fontSize: 20.sp),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            child: TextFormField(
              readOnly: saveFeed,
              controller: pakanController,
              decoration:
                  EditTextDecorationText(context, "Kilogram", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: subTitleLogin),
              onChanged: (e) {
                // if (saveFeed) {
                //   pakanController.text = lastpakan;
                // }
              },
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
                fontSize: 20.sp),
          ),
          SizedBox(
            height: ScreenUtil().setHeight(20),
          ),
          Container(
            child: TextFormField(
              readOnly: saveSr,
              controller: srController,
              decoration: EditTextDecorationText(context, "0", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              onChanged: (e) {
                // if (saveFeed) {
                //   srController.text = lastsr;
                // }
              },
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
                  fontSize: 20.sp)),
          SizedBox(
            height: 10,
          ),
          Container(
            child: TextFormField(
              readOnly: saveWeight,
              onChanged: (e) {
                // if (saveFeed) {
                //   weightController.text = lastweight;
                // }
              },
              controller: weightController,
              decoration: EditTextDecorationText(context, "0", 20.0, 0, 0, 0),
              keyboardType: TextInputType.number,
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'lato',
                  letterSpacing: 0.4,
                  fontSize: 20.sp),
            ),
          ),
          Container(
            height:70.h,
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.only(
                left: SizeConfig.blockVertical * 5,
                right: SizeConfig.blockVertical * 5,
                top: 15.0),
            child: CustomElevation(
                height: 80.h,
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
                        fontSize:
                            20.sp),
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
          "Laporan Tanggal ${widget.date.day} Ada yang Kosong",
          textAlign: TextAlign.center,
          style: subtitle2.copyWith(
              color: Colors.black,
              fontSize: 20.sp),
        ),
        Text("Segera buat laporan anda !",
            textAlign: TextAlign.center,
            style: subtitle2.copyWith(
                color: Colors.black,
                fontSize: 20.sp)),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 40.h,
          width: MediaQuery.of(context).size.width,
          margin: EdgeInsets.only(
              left: SizeConfig.blockVertical * 5,
              right: SizeConfig.blockVertical * 5,
              top: 15.0),
          child: CustomElevation(
              height: 40.h,
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
                      fontSize: 20.sp),
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
                        fontSize:25.sp),
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
                      fontSize: 20.sp),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    date,
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize:
                            20.sp),
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
                      fontSize: 20.sp),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    pakan + " Kg",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize:
                            20.sp),
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
                      fontSize: 20.sp),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    mati + " ekor",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize:
                            20.sp),
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
                      fontSize: 20.sp),
                ),
                Container(
                  padding: EdgeInsets.only(top: 5.0),
                  child: Text(
                    berat + " gram",
                    textAlign: TextAlign.start,
                    style: caption.copyWith(
                        color: greyTextColor,
                        fontSize:
                            20.sp),
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
