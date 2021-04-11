import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/Models/ChartKematianModel.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/bloc/MonitorBloc.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LaporanBloc.dart' as laporan;
class LaporanMingguanDetail extends StatefulWidget {
  final String idKolam;
  final DateTime startTime;
  final DateTime endTime;
  final int minggu;
  LaporanMingguanDetail({Key key, this.idKolam, this.startTime, this.endTime, this.minggu}) : super(key: key);

  @override
  _LaporanMingguanDetailState createState() => _LaporanMingguanDetailState();
}

class _LaporanMingguanDetailState extends State<LaporanMingguanDetail> {
  var now = new DateTime.now();
  bool _showDetail = true;
  int activeMonth = 0;
  bool _disposed = false;
  var _totalPertumbuhan = 0;
  var _totalPakan = 0;
  var _totalKematian = 0;
  var bulan = [
    "",
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }
  var total_fish_died = 0;
  var total_feed_spent = 0;
  var last_fish_weight = 0;
  var date = "";
  List<String> values = List<String>();

  //for kematian
  List<DateTime> tingkatKematianDateRange = [];
  var itemsKematian = List<ChartKematianModel>();

  //for berat
  List<DateTime> tingkatBeratDateRange = [];
  var itemsBerat = List<ChartKematianModel>();

  //for pakan
  List<DateTime> tingkatPakanDateRange = [];
  var itemsPakan = List<ChartKematianModel>();

  void chartKematian() {
    _totalKematian = 0;
    itemsKematian.clear();
    laporan.bloc
        .analyticsKematian(
        widget.idKolam,
        widget.startTime.toIso8601String(),
        widget.endTime.toIso8601String())
        .then((value) {
      List<ChartKematianModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsKematian.addAll(dataKolam);
        for (var berat in itemsKematian) {
          _totalKematian += berat.y;
        }
        AppExt.popScreen(context);
      });
    });
  }

  void chartBerat() {
    _totalPertumbuhan = 0;
    laporan.bloc
        .analyticsBerat(
        widget.idKolam,
        widget.startTime.toIso8601String(),
        widget.endTime.toIso8601String())
        .then((value) {
      List<ChartKematianModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsBerat.addAll(dataKolam);
        for (var berat in itemsBerat) {
          _totalPertumbuhan += berat.y;
        }
      });
    });
    chartKematian();
  }

  void chartPakan() {
    itemsPakan.clear();
    _totalPakan=0;
    laporan.bloc
        .analyticsPakan(
        widget.idKolam,
        widget.startTime.toIso8601String(),
        widget.endTime.toIso8601String())
        .then((value) {
      List<ChartKematianModel> dataKolam = new List();
      setState(() {
        print(value);
        dataKolam = value;
        itemsPakan.addAll(dataKolam);
        for (var pakan in itemsPakan) {
          _totalPakan += pakan.y;
        }

      });
    });
    chartBerat();
  }

  int tryCoba(String data) {
    try {
      return int.parse(data);
    } catch (_) {
      return 0;
    }
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      if (!_disposed) {
        LoadingDialog.show(context);
      }
    });

    chartPakan();

  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }




  @override
  Widget build(BuildContext context) {
    Widget _eventIcon = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Colors.blue, width: 2.0)),
      child: new Icon(
        Icons.person,
        color: Colors.amber,
      ),
    );

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: backgroundGreyColor,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child:  LaporanMain(
                          idKolam: widget
                              .idKolam
                              .toString(),
                          page: 2,
                          laporan_page:
                          "home",
                        )))
              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Laporan Minggu Ke-${widget.minggu}",
              style: h3,
            ),
          ),
          body: Container(
              color: backgroundGreyColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                      color: backgroundGreyColor,
                      margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            CardRekap(context, "Pakan",
                                "${_totalPakan/1000} Kg", ""),
                            CardRekap(context, "Ikan Mati",
                                "${_totalKematian} Ekor", ""),
                            CardRekap(context, "Berat Ikan",
                                "${_totalPertumbuhan}", ""),
                          ],
                        ),
                      ))
                ],
              ))),
    );
  }
  Widget CardRekap(
      BuildContext context, String title, String number, String date) {
    final Widget svgIcon = Container(
      height: SizeConfig.blockVertical * 14,
      child: Card(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            bulan[widget.startTime.month]+" ${widget.startTime.year}",
                            style: subtitle2.copyWith(
                                color: Colors.grey, fontSize: 12.0),
                          )),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            title,
                            style: subtitle2.copyWith(
                                color: Colors.black, fontSize: 23.0),
                          ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        number,
                        style: subtitle2.copyWith(
                            color: Colors.black, fontSize: 20.0),
                      ))
                ],
              ))),
    );
    return svgIcon;
  }
}

