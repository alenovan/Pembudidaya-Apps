import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/riwayat/RiwayatKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/LaporanHomeWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:page_transition/page_transition.dart';

class HomeLaporan extends StatefulWidget {
  final String idKolam;

  HomeLaporan({Key key, @required this.idKolam}) : super(key: key);

  @override
  _HomeLaporanState createState() => _HomeLaporanState();
}

class _HomeLaporanState extends State<HomeLaporan> {
  var loop = 0;
  var _stock_pakan = "";
  var _tanggal_panen = "";
  var _target_jual = 0 ;
  var _jumlah_ikan = "";
  var _berat_ikan = "";
  var _informasi_modal = 0;
  var _perkiraan_omset = "";
  var _laba = "";
  var _jumlah_ikan_first = 0;
  var _berat_ikan_current = 0;
  var _nama_kolam = "";
  var _omset;
  final formatter = new NumberFormat("#,###");
  void update() async {
    var detail = await bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    var modalPakan = (data['harvest']['feed_requirement_estimation'] / 1000) * data['harvest']['feed_price'] ;
    var modalIkan = data['harvest']['seed_amount'] *  data['harvest']['seed_price'];
    var jmlIkanPerkilo = 1000 / data['harvest']['harvest_weight_estimation'];
    var omset = (data['harvest']['current_amount'] / jmlIkanPerkilo) * data['harvest']['target_price'];
    setState(() {
      _nama_kolam = data['name'].toString();
      _stock_pakan = data['harvest']['current_stocked_feed'].toString() + " gr";
      _tanggal_panen = data['harvest']['harvest_date_estimation'].toString();
      _target_jual = data['harvest']['target_price'];
      _jumlah_ikan = data['harvest']['current_amount'].toString();
      _berat_ikan =
          data['harvest']['harvest_weight_estimation'].toString();
      _jumlah_ikan_first = data['harvest']['seed_amount'];
      _berat_ikan_current= data['harvest']['current_weight'];
      _laba = formatter
              .format(data['harvest']['profit_estimation'])
              .toString() +
          ",-";
      _omset = omset;
      _informasi_modal = modalIkan.toInt()+modalPakan.toInt();
    });
  }

  @override
  void initState() {
    _nama_kolam = "...";
    _stock_pakan = "Loading";
    _tanggal_panen = "Loading";
    _target_jual = 0;
    _jumlah_ikan = "0";
    _berat_ikan = "0";
    _jumlah_ikan_first = 0;
    _berat_ikan_current = 0;
    _informasi_modal = 0;
    _perkiraan_omset = "Loading";
    _laba = "Loading";
    _omset = 0;
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
          resizeToAvoidBottomPadding: false,
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
            actions: <Widget>[
              PopupMenuButton<int>(
                itemBuilder: (context) => [
                  // PopupMenuItem(
                  //   value: 1,
                  //   child: Row(
                  //     children: [
                  //       Icon(Icons.store, color: colorPrimary),
                  //       Text("  Status Pesanan Pakan", style: body2)
                  //     ],
                  //   ),
                  // ),
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
                        context, PageTransition(type: PageTransitionType.fade, child: RiwayatKolam(idKolam: widget.idKolam,)));
                  }
                },
                icon: Icon(Icons.more_vert, color: Colors.black),
              )
            ],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Detail Kolam",
              style: h3,
            ),
          ),
          body: Column(
            children: [
              // AppBarContainer(context, "Detail Kolam", DashboardView(),Colors.white),
              Expanded(
                  child: Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3),
                      color: backgroundGreyColor,
                      child: homeData()))
            ],
          )),
    );
  }

  Widget nullHomeData() {
    final Widget nullData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(alignment: Alignment.center, child: DetailNull(context)),
        Text(
          laporanhometextnull,
          textAlign: TextAlign.center,
          style: TextStyle(
              color: blackTextColor,
              fontFamily: 'poppins',
              letterSpacing: 0.25,
              fontSize: 16.0),
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
                onPressed: () => {},
                child: Text(
                  "isi",
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
        )
      ],
    );
    return nullData;
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
                "Berapa pakan yang anda butuhkan ? (Gram)",
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
                            onPressed: () =>
                            {
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
                              _stock_pakan,
                              style: h3.copyWith(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w500,
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
                                    showDialog(
                                      context: context,
                                      builder: (BuildContext context) =>
                                          AlertQuestionPakan(context),
                                    )
                                  },
                                  child: Text(
                                    "Request",
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
          child: CardColumn(context, "Tanggal Panen", _tanggal_panen,
              Alignment.centerLeft, SizeConfig.blockVertical * 3),
        ),
        Row(
          children: <Widget>[
            Expanded(
                child: Container(
              child: CardColumn(
                  context, "Jumlah Ikan", _jumlah_ikan_first.toString(), Alignment.center, 0),
            )),
            Expanded(
              child: Container(
                child: CardColumn(
                    context, "Berat Ikan ", _berat_ikan, Alignment.center, 0),
              ),
            ),
          ],
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
        Container(
          child: buildCardChart(
              title: "Tingkat Kematian",
              percent: 95,
              status: 1,
              statusCount: "4",
              date: "1 September - 30 September",
              chartData: _createSampleData()),
        ),
        Container(
          child: buildCardChartGram(
              title: "Jumlah Pakan Keluar",
              percent: 3000,
              status: 1,
              statusCount: "4",
              date: "1 September - 30 September",
              chartData: _createSampleData()),
        ),
        Container(
          child: buildCardChart(
              title: "Berat Lele",
              percent: 95,
              status: 2,
              statusCount: "4",
              date: "1 September - 30 September",
              chartData: _createSampleData()),
        ),
        Container(
          child: CardColumn(context, "Informasi Modal", "Rp.${formatter.format(_informasi_modal).toString()},-",
              Alignment.centerLeft, SizeConfig.blockVertical * 3),
        ),
        Container(
          child: CardColumn(context, "Perkiraan Omset", "Rp.${formatter.format(_omset).toString()},-",
              Alignment.centerLeft, SizeConfig.blockVertical * 3),
        ),
        Container(
          child: CardColumn(context, "Laba / Keuntungan", "Rp.$_laba",
              Alignment.centerLeft, SizeConfig.blockVertical * 3),
        ),
        Container(
          child: CardColumn(context, "Target Harga Jual", "Rp.${formatter.format(_target_jual).toString()},-",
              Alignment.centerLeft, SizeConfig.blockVertical * 3),
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
}

List<charts.Series<LinearIncome, int>> _createSampleData() {
  final myFakeDesktopData = [
    new LinearIncome(0, 0),
    new LinearIncome(1, 0),
    new LinearIncome(2, 0),
    new LinearIncome(3, 0),
    new LinearIncome(4, 0),
    new LinearIncome(5, 0),
    new LinearIncome(6, 0),
  ];

  return [
    new charts.Series<LinearIncome, int>(
      id: 'Desktop',
      colorFn: (_, __) => charts.ColorUtil.fromDartColor(colorPrimary),
      domainFn: (LinearIncome income, _) => income.week,
      measureFn: (LinearIncome income, _) => income.income,
      data: myFakeDesktopData,
    )
  ];
}

class LinearIncome {
  final int week;
  final int income;

  LinearIncome(this.week, this.income);
}


