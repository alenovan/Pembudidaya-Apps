import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualScreenAdma.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;

class JualLanding extends StatefulWidget {
  final String idKolam;

  const JualLanding({Key key, this.idKolam}) : super(key: key);

  @override
  _JualLandingViewState createState() => _JualLandingViewState();
}

class _JualLandingViewState extends State<JualLanding> {
  var dayLeft = "";
  var currentAmount = "";
  var harvest_weight_estimation = "";
  var harvest_date_estimation = "";
  var sow_date = "";

  @override
  void initState() {
    setData();
    super.initState();
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
              data['harvest']['harvest_weight_estimation'].toStringAsFixed(0)))
          .toStringAsFixed(0)
          .toString();
      harvest_date_estimation =
          data['harvest']['harvest_date_estimation'].toString();
      var inputFormat = DateFormat('dd/MM/yyyy');
      var inputDate = inputFormat.parse(harvest_date_estimation);

      var outputFormat = DateFormat('yyyy-MM-dd hh:mm:ss');
      var outputDate = outputFormat.format(inputDate);

      var inputFormats = DateFormat('yyyy-MM-dd hh:mm:ss');
      var inputDates =
          inputFormats.parse(data['harvest']['sow_date'].toString());

      var outputFormats = DateFormat('d MMMM yyyy');
      var outputDates = outputFormats.format(inputDates);
      sow_date = outputDates;

      var dateSelected = DateTime.parse(outputDate);
      var date2 = DateTime.now();
      var difference = date2.difference(dateSelected).inDays;
      setState(() {
        dayLeft = "${difference.abs()} Hari";
      });
    });
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
                resizeToAvoidBottomPadding: false,
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
                        Container(
                          color: Colors.transparent,
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(20),
                              top: ScreenUtil().setHeight(100)),
                          child: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                              color: Colors.black,
                              size:
                                  ScreenUtil(allowFontScaling: false).setSp(70),
                            ),
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType
                                          .fade,
                                      child: LaporanMain(
                                        page: 2,
                                        laporan_page: "home",
                                        idKolam: widget.idKolam,
                                      )))
                            },
                          ),
                        ),
                        Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                margin: EdgeInsets.only(
                                    left: ScreenUtil().setWidth(20),
                                    right: ScreenUtil().setWidth(20)),
                                child: Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  elevation: 4.0,
                                  child: Container(
                                    width: double.infinity,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(80),
                                              right: ScreenUtil().setWidth(80),
                                              top: ScreenUtil().setHeight(80)),
                                          child: Text(
                                            "Jual Hasil Panen",
                                            style: h3.copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: ScreenUtil(
                                                        allowFontScaling: false)
                                                    .setSp(60)),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(80),
                                              right: ScreenUtil().setWidth(80),
                                              bottom:
                                                  ScreenUtil().setHeight(80)),
                                          child: Text(
                                            "ingin kamu jual kemana hasil panenmu ? Marketplace  Panen-panen atau Platform Bisnis Digital dari ADMA ?",
                                            style: caption.copyWith(
                                                color: Colors.grey,
                                                fontSize: ScreenUtil(
                                                        allowFontScaling: false)
                                                    .setSp(40)),
                                            textAlign: TextAlign.start,
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50),
                                              bottom:
                                                  ScreenUtil().setHeight(70)),
                                          child:GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: JualScreen(
                                                        idKolam: widget.idKolam.toString(),
                                                      )));
                                            },
                                            child:  Card(
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(15.0),
                                              ),
                                              elevation: 14.0,
                                              child: Container(
                                                height:
                                                ScreenUtil().setHeight(250),
                                                padding: EdgeInsets.all(
                                                    ScreenUtil().setHeight(50)),
                                                child: Center(
                                                  child: Image.asset(
                                                    "assets/png/panen_market.png",
                                                    fit: BoxFit.cover,
                                                    height: ScreenUtil()
                                                        .setHeight(80),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        Container(
                                          padding: EdgeInsets.only(
                                              left: ScreenUtil().setWidth(50),
                                              right: ScreenUtil().setWidth(50),
                                              bottom:
                                                  ScreenUtil().setHeight(40)),
                                          child: GestureDetector(
                                            onTap: (){
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.fade,
                                                      child: JualScreenAdma(
                                                        idKolam: widget.idKolam.toString(),
                                                      )));
                                            },
                                            child: Card(
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            elevation: 14.0,
                                            child: Container(
                                              height:
                                                  ScreenUtil().setHeight(250),
                                              padding: EdgeInsets.all(
                                                  ScreenUtil().setHeight(50)),
                                              child: Center(
                                                child: Image.asset(
                                                  "assets/png/adma.png",
                                                  fit: BoxFit.cover,
                                                  height: ScreenUtil()
                                                      .setHeight(250),
                                                ),
                                              ),
                                            ),
                                          )),

                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              )
                            ])
                      ],
                    )),
                  ],
                ))));
  }
}
