import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/Models/ChartKematianModel.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/riwayat/RiwayatKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/LaporanHomeWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as checkout;
import 'package:lelenesia_pembudidaya/src/bloc/LaporanBloc.dart' as laporan;
import 'package:date_range_picker/date_range_picker.dart' as DateRangePicker;
import 'package:intl/date_symbol_data_local.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class HomeLaporan extends StatefulWidget {
  final String idKolam;

  HomeLaporan({Key key, @required this.idKolam}) : super(key: key);

  @override
  _HomeLaporanState createState() => _HomeLaporanState();
}

class _HomeLaporanState extends State<HomeLaporan> {
  var loop = 0;
  var _totalPertumbuhan = 0;
  var _totalPakan = 0;
  var _stock_pakan = 0;
  var _tanggal_panen = "";
  var _tanggal_tebar = "";
  var _target_jual = 0;
  DateTime time = DateTime.now();
  bool _disposed = false;
  var _jumlah_ikan = "";
  var _berat_ikan = 0;
  var _informasi_modal = "0";
  var _perkiraan_omset = "";
  var _laba = "";
  var _jumlah_ikan_first = 0;
  var _berat_ikan_current = 0;
  var _nama_kolam = "";
  var _omset;
  var id_order = "";
  var _berat_ikan_cart_total = 0;
  var current_sr_percent = 0.0;
  var status_checkout = false;
  var text_status_checkout = "Loading";
  final formatter = new NumberFormat("#,###");

  //for kematian
  List<DateTime> tingkatKematianDateRange = [];
  var itemsKematian = List<ChartKematianModel>();

  //for berat
  List<DateTime> tingkatBeratDateRange = [];
  var itemsBerat = List<ChartKematianModel>();

  //for pakan
  List<DateTime> tingkatPakanDateRange = [];
  var itemsPakan = List<ChartKematianModel>();

  void update() async {
    var detail = await bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    setState(() {
      _nama_kolam = data['name'].toString();
      _stock_pakan = data['harvest']['current_stocked_feed'];
      _tanggal_panen = data['harvest']['harvest_date_estimation'].toString();
      _target_jual = data['harvest']['target_price'];
      _jumlah_ikan = data['harvest']['current_amount'].toString();
      _berat_ikan_current = (data['harvest']['current_weight'] *
          data['harvest']['current_amount']);
      _jumlah_ikan_first = data['harvest']['seed_amount'];
      _berat_ikan = int.parse(data['harvest']['harvest_weight_estimation'].toStringAsFixed(0));
      current_sr_percent =
          double.parse(data['harvest']['current_sr'].toString());
      _laba =
          formatter.format(int.parse(data['harvest']['profit_estimation'].toStringAsFixed(0))).toString() +
              ",-";
      _omset = formatter.format(data['harvest']['revenue']).toString();
      _informasi_modal = formatter.format(data['harvest']['budget']).toString();
      id_order = data['harvest']['last_order_id'].toString();
      _tanggal_tebar = DateFormat('dd/MM/yyyy').format(DateTime.parse(data['harvest']['sow_date']));
      _berat_ikan_cart_total = 0;
    });
    detailOrder();
  }

  void detailOrder() async {
    var detail = await checkout.bloc.getCheckOrderId(id_order.toString());
    await WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        status_checkout = detail;

        if (status_checkout) {
          text_status_checkout = "Checkout";
        } else {
          text_status_checkout = "Request";
        }
      });
    });
    AppExt.popScreen(context);
  }

  void dateRangeKematian(data) {
    setState(() {
      tingkatKematianDateRange = data;
    });
    chartKematian();
  }

  void dateRangeBerat(data) {
    setState(() {
      tingkatBeratDateRange = data;
    });
    chartBerat();
  }

  void dateRangePakan(data) {
    setState(() {
      tingkatPakanDateRange = data;
    });
    chartPakan();
  }

  void chartKematian() {
    itemsKematian.clear();
    laporan.bloc
        .analyticsKematian(
        widget.idKolam,
        tingkatKematianDateRange[0].toIso8601String(),
        tingkatKematianDateRange[1].toIso8601String())
        .then((value) {
      List<ChartKematianModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsKematian.addAll(dataKolam);
      });
    });
  }

  void chartBerat() {
    itemsBerat.clear();
    _totalPertumbuhan = 0;
    laporan.bloc
        .analyticsBerat(
        widget.idKolam,
        tingkatBeratDateRange[0].toIso8601String(),
        tingkatBeratDateRange[1].toIso8601String())
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
  }

  void chartPakan() {
    itemsPakan.clear();
    _totalPakan=0;
    laporan.bloc
        .analyticsPakan(
        widget.idKolam,
        tingkatPakanDateRange[0].toIso8601String(),
        tingkatPakanDateRange[1].toIso8601String())
        .then((value) {
      List<ChartKematianModel> dataKolam = new List();
      setState(() {
        dataKolam = value;
        itemsPakan.addAll(dataKolam);
        for (var pakan in itemsPakan) {
          _totalPakan += pakan.y;
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    initializeDateFormatting(); //very important
    tingkatKematianDateRange.add(new DateTime.now());
    tingkatKematianDateRange
        .add((new DateTime.now()).add(new Duration(days: 7)));

    tingkatBeratDateRange.add(new DateTime.now());
    tingkatBeratDateRange.add((new DateTime.now()).add(new Duration(days: 7)));

    tingkatPakanDateRange.add(new DateTime.now());
    tingkatPakanDateRange.add((new DateTime.now()).add(new Duration(days: 7)));

    _nama_kolam = "...";
    _stock_pakan = 0;
    _tanggal_panen = "Loading";
    _tanggal_tebar = "Loading";
    _target_jual = 0;
    _jumlah_ikan = "0";
    _berat_ikan = 0;
    _jumlah_ikan_first = 0;
    _berat_ikan_current = 0;
    _informasi_modal = "Loading";
    _perkiraan_omset = "Loading";
    _laba = "Loading";
    _omset = 0;
    Future.delayed(Duration.zero, () {
      if (!_disposed){
        LoadingDialog.show(context);
      }
      try{
        update();
        chartKematian();
      } on SocketException {
        AppExt.popScreen(context);
      }

    });
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft,
                        child: DashboardView()))
              },
            ),
            actions: <Widget>[
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Row(
                      children: [
                        Icon(Icons.history, color: colorPrimary),
                        Text(
                          "  Riwayat Kolam",
                          style: body2,
                        )
                      ],
                    ),
                  ),
                ],
                onSelected: (value) {
                  if (value == 1) {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: RiwayatKolam(
                              idKolam: widget.idKolam,
                            )));
                  }
                },
                icon: Icon(Icons.more_vert, color: Colors.white),
              )
            ],
            backgroundColor: colorPrimary,
            brightness: Brightness.light,
          ),
          body: Column(
            children: [
              Stack(
                children: [
                  Container(
                      width: double.infinity,
                      decoration: new BoxDecoration(
                        color: colorPrimary,
                        borderRadius: BorderRadius.vertical(
                            bottom:
                            Radius.circular(50.0)),
                      ),
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3,
                          bottom: SizeConfig.blockHorizotal * 25),
                      child:  Text(" ")),
                  Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 3,
                        right: SizeConfig.blockVertical * 3),
                    child:  CardKolam(context, "aa",
                        "Ikan Lele",  "1",1,1,1),
                  )
                ],
              ),
              Expanded(
                child: Container(
                    padding: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 3,
                        right: SizeConfig.blockVertical * 3),
                    child:homeData()
                ),
              )
            ],
          )),
    );
  }


  Widget AlertQuestionPakan(BuildContext context) {
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
                "Berapa pakan yang anda butuhkan ? (Kilogram)",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 15.0),
                textAlign: TextAlign.start,
              ),
              Container(
                margin: EdgeInsets.only(top: 10.0),
                child: TextFormField(
                  decoration:
                  EditTextDecorationText(context, "", 20.0, 0, 0, 0),
                  keyboardType: TextInputType.number,
                  style: TextStyle(
                      color: blackTextColor,
                      fontFamily: 'lato',
                      letterSpacing: 0.4,
                      fontSize: subTitleLogin),
                ),
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
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: CheckoutView(
                                        idKolam: widget.idKolam,
                                      )))
                            },
                            child: Text(
                              "Iya",
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

  Widget homeData() {
    final Widget datax = SingleChildScrollView(
      physics: new BouncingScrollPhysics(),
      child: Container(
          child: Column(children: [
            Container(
              margin: EdgeInsets.only(
                top: SizeConfig.blockVertical * 3,
              ),
              child: Container(
                height: 100,
                child: Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Container(
                        padding: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3, right: 15.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                    child: Text(
                                      "Stock Pakan",
                                      style: subtitle2.copyWith(color: colorPrimary),
                                    )),
                                Container(
                                    child: Text(
                                      (_stock_pakan / 1000).toString() + " Kg",
                                      style: h3.copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 1.15),
                                    )),
                              ],
                            ),
                            Container(
                                margin: EdgeInsets.only(top: 10.0),
                                alignment: Alignment.centerRight,
                                child: CustomElevation(
                                    height: 40.0,
                                    child: RaisedButton(
                                      highlightColor: colorPrimary,
                                      //Replace with actual colors
                                      color: colorPrimary,
                                      onPressed: () => {
                                        if (status_checkout)
                                          {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade,
                                                    child: CheckoutView(
                                                      idKolam: widget.idKolam,
                                                    )))
                                          }
                                        else
                                          {
                                            showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  AlertQuestionPakan(context),
                                            )
                                          }
                                      },
                                      child: Text(
                                        status_checkout
                                            ? "Checkout"
                                            : text_status_checkout,
                                        style:
                                        overline.copyWith(color: Colors.white),
                                      ),
                                      shape: new RoundedRectangleBorder(
                                        borderRadius:
                                        new BorderRadius.circular(30.0),
                                      ),
                                    ))),
                          ],
                        ))),
              ),
            ),
            Container(
              child: CardColumn(context, "Tanggal Tebar Benih", _tanggal_tebar,
                  Alignment.centerLeft, SizeConfig.blockVertical * 3),
            ),

            Container(
              child: CardColumn(context, "Tanggal Panen", _tanggal_panen,
                  Alignment.centerLeft, SizeConfig.blockVertical * 3),
            ),

            Container(
              child: CardColumn(
                  context,
                  "Jumlah ikan (Terkini/Awal)",
                  "${_jumlah_ikan.toString()} / ${_jumlah_ikan_first.toString()} Ekor",
                  Alignment.centerLeft,
                  SizeConfig.blockVertical * 3),
            ),
            Container(
              child: CardColumn(
                  context,
                  "Berat Ikan (Terkini/Perkiraan)",
                  "${(_berat_ikan_current / 1000).toStringAsFixed(1)} / ${(_berat_ikan / 1000).toStringAsFixed(1)} Kg",
                  Alignment.centerLeft,
                  SizeConfig.blockVertical * 3),
            ),

            // Row(
            //   children: <Widget>[
            //     Expanded(
            //         child: Container(
            //           child: CardColumn(
            //               context, "Jml Ikan Terkini", _jumlah_ikan.toString(), Alignment.center, 0),
            //         )),
            //     Expanded(
            //       child: Container(
            //         child: CardColumn(
            //             context, "Berat Ikan Terkini", _berat_ikan_current.toString(), Alignment.center, 0),
            //       ),
            //     ),
            //   ],
            // ),
            Card(
              elevation: 4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 2,
                                top: SizeConfig.blockHorizotal * 3),
                            child: Text(
                              "Tingkat Kematian",
                              style: subtitle2,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 2),
                                child: Text(
                                  current_sr_percent.floor().toString() + "%",
                                  style: body2,
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 1),
                                child: Row(children: <Widget>[
                                  Icon(
                                    Icons.trending_down,
                                    color: Colors.red,
                                    size: 12.0,
                                  ),
                                  Text(
                                    " " +
                                        (current_sr_percent - 100)
                                            .floor()
                                            .abs()
                                            .toString() +
                                        "%",
                                    style: overline.copyWith(color: Colors.red),
                                  )
                                ]),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.0, right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: colorPrimaryLight,
                              primaryColor: colorPrimary,
                            ),
                            child: Builder(
                              builder: (context) => CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor: colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () async {
                                      final List<DateTime> picked =
                                      await DateRangePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate:
                                          tingkatKematianDateRange[0],
                                          initialLastDate:
                                          tingkatKematianDateRange[1],
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2021));
                                      if (picked != null && picked.length == 2) {
                                        dateRangeKematian(picked);
                                      }
                                    },
                                    child: Text(
                                      "Filter",
                                      style: overline.copyWith(color: Colors.white),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                  buildCardChart(
                      status: 1,
                      statusCount: "4",
                      context: context,
                      date:
                      " ${DateFormat('d MMMM').format(tingkatKematianDateRange[0])} - ${DateFormat('d MMMM').format(tingkatKematianDateRange[1])}",
                      chartData: _createKematianData())
                ],
              ),
            ),
            Card(
              elevation: 4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 2,
                                top: SizeConfig.blockHorizotal * 3),
                            child: Text(
                              "Jumlah Pakan Keluar",
                              style: subtitle2,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 2),
                                child: Text(
                                  "${_totalPakan} " + "Gram",
                                  style: body2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.0, right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: colorPrimaryLight,
                              primaryColor: colorPrimary,
                            ),
                            child: Builder(
                              builder: (context) => CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor: colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () async {
                                      final List<DateTime> picked =
                                      await DateRangePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate:
                                          tingkatPakanDateRange[0],
                                          initialLastDate:
                                          tingkatPakanDateRange[1],
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2021));
                                      if (picked != null && picked.length == 2) {
                                        dateRangePakan(picked);
                                      }
                                    },
                                    child: Text(
                                      "Filter",
                                      style: overline.copyWith(color: Colors.white),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                  buildCardChart(
                      status: 1,
                      statusCount: "4",
                      context: context,
                      date:
                      "${DateFormat('d MMMM').format(tingkatPakanDateRange[0])} - ${DateFormat('d MMMM').format(tingkatPakanDateRange[1])}",
                      chartData: _createPakanData())
                ],
              ),
            ),
            Card(
              elevation: 4,
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 2,
                                top: SizeConfig.blockHorizotal * 3),
                            child: Text(
                              "Pertumbuhan",
                              style: subtitle2,
                            ),
                          ),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 2),
                                child: Text(
                                  "${_totalPertumbuhan}" + " Gr",
                                  style: body2,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20.0, right: 10.0),
                          alignment: Alignment.centerRight,
                          child: Theme(
                            data: Theme.of(context).copyWith(
                              accentColor: colorPrimaryLight,
                              primaryColor: colorPrimary,
                            ),
                            child: Builder(
                              builder: (context) => CustomElevation(
                                  height: 30.0,
                                  child: RaisedButton(
                                    highlightColor: colorPrimary,
                                    //Replace with actual colors
                                    color: colorPrimary,
                                    onPressed: () async {
                                      final List<DateTime> picked =
                                      await DateRangePicker.showDatePicker(
                                          context: context,
                                          initialFirstDate:
                                          tingkatBeratDateRange[0],
                                          initialLastDate:
                                          tingkatBeratDateRange[1],
                                          firstDate: new DateTime(2015),
                                          lastDate: new DateTime(2021));
                                      if (picked != null && picked.length == 2) {
                                        dateRangeBerat(picked);
                                      }
                                    },
                                    child: Text(
                                      "Filter",
                                      style: overline.copyWith(color: Colors.white),
                                    ),
                                    shape: new RoundedRectangleBorder(
                                      borderRadius: new BorderRadius.circular(30.0),
                                    ),
                                  )),
                            ),
                          )),
                    ],
                  ),
                  buildCardChart(
                      status: 1,
                      statusCount: "4",
                      context: context,
                      date:
                      "${DateFormat('d MMMM').format(tingkatBeratDateRange[0])} - ${DateFormat('d MMMM').format(tingkatBeratDateRange[1])}",
                      chartData: _createBeratData())
                ],
              ),
            ),
            Container(
              child: CardColumn(
                  context,
                  "Informasi Modal",
                  "Rp.${_informasi_modal},-",
                  Alignment.centerLeft,
                  SizeConfig.blockVertical * 3),
            ),
            Container(
              child: CardColumn(context, "Perkiraan Omset", "Rp.${_omset},-",
                  Alignment.centerLeft, SizeConfig.blockVertical * 3),
            ),
            Container(
              child: CardColumn(context, "Laba / Keuntungan", "Rp.$_laba",
                  Alignment.centerLeft, SizeConfig.blockVertical * 3),
            ),
            Container(
              child: CardColumn(
                  context,
                  "Target Harga Jual",
                  "Rp.${formatter.format(_target_jual).toString()}/ Kg",
                  Alignment.centerLeft,
                  SizeConfig.blockVertical * 3),
            ),
            Container(
                margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
                width: double.infinity,
                child: CustomElevation(
                    height: 40.0,
                    child: RaisedButton(
                      highlightColor: redTextColor,
                      //Replace with actual colors
                      color: redTextColor,
                      onPressed: () => {},
                      child: Text(
                        "Panen",
                        style: h3.copyWith(color: Colors.white),
                      ),
                      shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(30.0),
                      ),
                    ))),
            SizedBox(
              height: 20.0,
            )
          ])),
    );
    return datax;
  }

  List<charts.Series<ChartKematianModel, DateTime>> _createKematianData() {
    return [
      new charts.Series<ChartKematianModel, DateTime>(
        id: 'Tingkat Kematian',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(colorPrimary),
        domainFn: (ChartKematianModel income, _) => income.x,
        measureFn: (ChartKematianModel income, _) => income.y,
        data: itemsKematian,
      )
    ];
  }

  List<charts.Series<ChartKematianModel, DateTime>> _createBeratData() {
    return [
      new charts.Series<ChartKematianModel, DateTime>(
        id: 'Tingkat Berat',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(colorPrimary),
        domainFn: (ChartKematianModel income, _) => income.x,
        measureFn: (ChartKematianModel income, _) => income.y,
        data: itemsBerat,
      )
    ];
  }

  List<charts.Series<ChartKematianModel, DateTime>> _createPakanData() {
    return [
      new charts.Series<ChartKematianModel, DateTime>(
        id: 'Tingkat Berat',
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(colorPrimary),
        domainFn: (ChartKematianModel income, _) => income.x,
        measureFn: (ChartKematianModel income, _) => income.y,
        data: itemsPakan,
      )
    ];
  }
}
