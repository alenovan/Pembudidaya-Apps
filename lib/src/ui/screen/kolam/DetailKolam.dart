import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class DetailKolam extends StatefulWidget {
  final String idKolam;
  final String idIkan;

  const DetailKolam({Key key, this.idKolam, this.idIkan}) : super(key: key);

  @override
  _DetailKolamViewState createState() => _DetailKolamViewState();
}

class _DetailKolamViewState extends State<DetailKolam> {
  var dayLeft = "";
  var currentAmount = "";
  var harvest_weight_estimation = "";
  var harvest_date_estimation = "";
  var sow_date = "";
  var ikanName = "";
  var ikanAssets = "";
  double ikanTop = 0.0;
  double ikanLeft = 0.0;
  @override
  void initState() {
    super.initState();
    setData();
  }

  dispose() {
    super.dispose();
  }


  void setData() async {
    var detail = await kolam.bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    print(data);
    setState(() {
      currentAmount = data['harvest']['current_amount'].toString() + " Ekor";
      harvest_weight_estimation = (int.parse(
          data['harvest']['harvest_weight_estimation']))
          .toStringAsFixed(0)
          .toString();
      harvest_date_estimation=data['harvest']['harvest_date_estimation'].toString();
      var inputFormat = DateFormat('dd/MM/yyyy');
      var inputDate = inputFormat.parse(harvest_date_estimation);

      var outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      var outputDate = outputFormat.format(inputDate);

      var inputFormats = DateFormat('yyyy-MM-dd hh:mm:ss');
      var inputDates = inputFormats.parse(data['harvest']['sow_date'].toString());

      var outputFormats = DateFormat('d MMMM yyyy');
      var outputDates = outputFormats.format(inputDates);
      sow_date = outputDates;
      var fish_type = data['harvest']['fish_type_id'].toString();
      if(fish_type == "1"){
        ikanName = "Ikan Lele";
        ikanAssets = "assets/png/ikan_lele.png";
        ikanLeft = ScreenUtil().setWidth(100);
      }else if(fish_type == "2"){
        ikanName = "Ikan Nila";
        ikanAssets = "assets/png/ikan_nila.png";
        ikanTop = ScreenUtil().setHeight(200);
        ikanLeft = ScreenUtil().setWidth(20);
      }else{
        ikanName = "Ikan Mas";
        ikanAssets = "assets/png/ikan_mas.png";
        ikanLeft = ScreenUtil().setWidth(100);
        ikanTop = ScreenUtil().setHeight(200);

      }
      var dateSelected = DateTime.parse(outputDate);
      var date2 = DateTime.now();
      var difference = date2.difference(dateSelected).inDays;
      setState(() {
        dayLeft = "${difference.abs()} Hari";
      });
    });


  }

  void setReset() async{
    LoadingDialog.show(context);
    var status = await kolam.bloc.setResetKolam(widget.idKolam);
    if (status) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "Kolam berhasil direset");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                // duration: Duration(microseconds: 1000),
                child: DashboardView(
                )));
      });


    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }


  @override
  Widget build(BuildContext context) {

    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: WillPopScope(
            child: Scaffold(
                backgroundColor: Colors.grey[100],
                resizeToAvoidBottomInset: false,
                body: Column(
                  children: [
                    Expanded(
                        child: Stack(
                      children: [
                        Container(
                          height: ScreenUtil().setHeight(1400),
                          color: Colors.transparent,
                          child: new Container(
                              decoration: new BoxDecoration(
                                  color: colorPrimaryLight,
                                  borderRadius: new BorderRadius.only(
                                    bottomRight: const Radius.circular(80.0),
                                  )),
                              child: new Center(
                                child: Text(""),
                              )),
                        ),
                        Container(
                          width: double.infinity,
                          child: Image.asset(
                            "assets/png/rounded_background.png",
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                color: Colors.transparent,
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20),
                                    top: ScreenUtil().setHeight(60)),
                                child: IconButton(
                                  icon: Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                    size: ScreenUtil(allowFontScaling: false)
                                        .setSp(70),
                                  ),
                                  onPressed: () => {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade,
                                            child: DashboardView()))
                                  },
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(80),
                                    top: ScreenUtil().setHeight(20),
                                    right: ScreenUtil().setWidth(80)),
                                child: Text(
                                  "${ikanName}",
                                  style: h3.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ScreenUtil(allowFontScaling: false)
                                              .setSp(70)),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(80),
                                    right: ScreenUtil().setWidth(80)),
                                child: sow_date != ""?Text(
                                  "${sow_date}",
                                  style: caption.copyWith(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w700,
                                      fontSize:
                                          ScreenUtil(allowFontScaling: false)
                                              .setSp(50)),
                                  textAlign: TextAlign.start,
                                ):Shimmer.fromColors(
                                    baseColor: Colors.grey[300],
                                    highlightColor: Colors.white,
                                    child: Container(
                                      height: 20.0,
                                      width: ScreenUtil().setWidth(250),
                                      decoration: BoxDecoration(
                                          color: Colors.grey[300],
                                          borderRadius:
                                          BorderRadius.all(
                                              Radius.circular(
                                                  16.0))),
                                    )),
                              ),
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding: EdgeInsets.only(
                                      top: ikanTop,
                                        left: ikanLeft),
                                    height: ScreenUtil().setHeight(850),
                                    child: ikanAssets==""?Container():Image.asset(
                                      ikanAssets,
                                      fit: BoxFit.fitHeight,
                                    ),
                                  )),
                                  Expanded(
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          top: ScreenUtil().setHeight(100)),
                                      transform: Matrix4.translationValues(
                                          -ScreenUtil().setHeight(40),
                                          0.0,
                                          0.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(137),
                                                width:
                                                    ScreenUtil().setHeight(137),
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil().setWidth(40)),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: colorPrimary,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: colorPrimary)),
                                                child: Icon(
                                                    Boxicons.bx_calendar,
                                                    color: Colors.white,
                                                    size: ScreenUtil(
                                                            allowFontScaling:
                                                                false)
                                                        .setSp(70)),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Hari Tersisa",
                                                        style: body1.copyWith(
                                                            color: colorPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: dayLeft != ""?Text(
                                                        "${dayLeft}",
                                                        style: subtitle2.copyWith(
                                                            color: Colors.black,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ):Shimmer.fromColors(
                                                          baseColor: Colors.grey[300],
                                                          highlightColor: Colors.white,
                                                          child: Container(
                                                            height: 20.0,
                                                            width: ScreenUtil().setWidth(250),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey[300],
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          16.0))),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(60),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(137),
                                                width:
                                                    ScreenUtil().setHeight(137),
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil().setWidth(40)),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: colorPrimary,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: colorPrimary)),
                                                child: Icon(Boxicons.bx_ruler,
                                                    color: Colors.white,
                                                    size: ScreenUtil(
                                                            allowFontScaling:
                                                                true)
                                                        .setSp(70)),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Jumlah Ikan",
                                                        style: body1.copyWith(
                                                            color: colorPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: currentAmount != ""?Text(
                                                        "${currentAmount}",
                                                        style: subtitle2.copyWith(
                                                            color: Colors.black,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ):Shimmer.fromColors(
                                                          baseColor: Colors.grey[300],
                                                          highlightColor: Colors.white,
                                                          child: Container(
                                                            height: 20.0,
                                                            width: ScreenUtil().setWidth(250),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey[300],
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          16.0))),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(60),
                                          ),
                                          Row(
                                            children: [
                                              Container(
                                                height:
                                                    ScreenUtil().setHeight(137),
                                                width:
                                                    ScreenUtil().setHeight(137),
                                                margin: EdgeInsets.only(
                                                    right: ScreenUtil().setWidth(40)),
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            100),
                                                    color: colorPrimary,
                                                    border: Border.all(
                                                        width: 2,
                                                        color: colorPrimary)),
                                                child: Icon(Boxicons.bx_ruler,
                                                    color: Colors.white,
                                                    size: ScreenUtil(
                                                            allowFontScaling:
                                                                true)
                                                        .setSp(70)),
                                              ),
                                              Container(
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      child: Text(
                                                        "Prediksi Panen",
                                                        style: body1.copyWith(
                                                            color: colorPrimary,
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                    Container(
                                                      child: harvest_weight_estimation != ""?Text(
                                                        "${harvest_weight_estimation} Kg",
                                                        style: subtitle2.copyWith(
                                                            color: Colors.black,
                                                            fontSize: ScreenUtil(
                                                                allowFontScaling:
                                                                false)
                                                                .setSp(45)),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ):Shimmer.fromColors(
                                                          baseColor: Colors.grey[300],
                                                          highlightColor: Colors.white,
                                                          child: Container(
                                                            height: 20.0,
                                                            width: ScreenUtil().setWidth(250),
                                                              decoration: BoxDecoration(
                                                                  color: Colors.grey[300],
                                                                  borderRadius:
                                                                  BorderRadius.all(
                                                                      Radius.circular(
                                                                          16.0))),
                                                          )),
                                                    )
                                                  ],
                                                ),
                                              )
                                            ],
                                          ),
                                          SizedBox(
                                            height: ScreenUtil().setHeight(60),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType
                                                          .fade,
                                                      child: LaporanMain(
                                                        page: 0,
                                                        laporan_page: "home",
                                                        idKolam: widget.idKolam,
                                                      )));
                                            },
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: ScreenUtil()
                                                      .setHeight(137),
                                                  width: ScreenUtil()
                                                      .setHeight(137),
                                                  margin: EdgeInsets.only(
                                                      right: ScreenUtil().setWidth(40)),
                                                  padding: EdgeInsets.all(10),
                                                  decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              100),
                                                      color: colorPrimary,
                                                      border: Border.all(
                                                          width: 2,
                                                          color: colorPrimary)),
                                                  child: Icon(
                                                      Boxicons
                                                          .bx_dots_vertical_rounded,
                                                      color: Colors.white,
                                                      size: ScreenUtil(
                                                              allowFontScaling:
                                                                  false)
                                                          .setSp(70)),
                                                ),
                                                Container(
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Container(
                                                        child: Text(
                                                          "Detail",
                                                          style: body1.copyWith(
                                                              color:
                                                                  colorPrimary,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: ScreenUtil(
                                                                  allowFontScaling:
                                                                  false)
                                                                  .setSp(45)),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              )
                            ])
                      ],
                    )),
                    Container(
                        transform: Matrix4.translationValues(
                            00.0, -ScreenUtil().setHeight(300), 0.0),
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(80),
                            right: ScreenUtil().setWidth(80)),
                        width: double.infinity,
                        child: CustomElevation(
                            height: ScreenUtil().setHeight(130),
                            child: RaisedButton(
                              highlightColor: redTextColor,
                              //Replace with actual colors
                              color: redTextColor,
                              onPressed: () => {
                                setReset()
                              },
                              child: Text(
                                "Reset Kolam",
                                style: h3.copyWith(
                                    color: Colors.white,
                                    fontSize: ScreenUtil(allowFontScaling: false)
                                        .setSp(50)),
                              ),
                              shape: new RoundedRectangleBorder(
                                borderRadius: new BorderRadius.circular(30.0),
                              ),
                            ))),
                  ],
                ))));
  }
}
