import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/LaporanHomeWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AreaAndLineChart.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat, NumberFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';
import 'package:charts_flutter/flutter.dart' as charts;
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
  var _target_jual = "";
  var _jumlah_ikan = "";
  var _berat_ikan = "";
  var _informasi_modal = "";
  var _perkiraan_omset = "";
  var _laba = "";
  var _nama_kolam = "";


  void update() async {
    var detail  = await bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    setState(() {
      _nama_kolam = data['name'].toString();
       _stock_pakan = data['harvest']['current_stocked_feed'].toString()+" gr";
      _tanggal_panen = data['harvest']['harvest_date_estimation'].toString();
      _target_jual = NumberFormat.currency(name: 'Rp. ').format(data['harvest']['target_price']).toString()+",-";
      _jumlah_ikan = data['harvest']['seed_amount'].toString();
      _berat_ikan = data['harvest']['harvest_weight_estimation'].toString() +" gr";
      _informasi_modal = data['harvest']['current_weight'].toString();
      _perkiraan_omset = "";
      _laba = NumberFormat.currency(name: 'Rp. ').format(data['harvest']['profit_estimation']).toString()+",-";
    });
  }
  @override
  void initState() {
    _nama_kolam = "...";
    _stock_pakan = "Loading";
    _tanggal_panen = "Loading";
    _target_jual = "Loading";
    _jumlah_ikan = "Loading";
    _berat_ikan = "Loading";
    _informasi_modal = "Loading";
    _perkiraan_omset = "Loading";
    _laba = "Loading";
    update();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body:  Column(
          children: [
            AppBarContainer(context, "Detail Kolam", DashboardView(),Colors.white),
            Expanded(child: Container(
                padding: EdgeInsets.only(
                    left: SizeConfig.blockVertical * 3,
                    right: SizeConfig.blockVertical * 3),
                color: backgroundGreyColor,
                child: homeData()))
          ],
        )),
    );
  }

  Widget nullHomeData(){
    final Widget nullData = Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Align(
            alignment: Alignment.center,
            child: DetailNull(context)),
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
                highlightColor:
                colorPrimary, //Replace with actual colors
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

  Widget homeData(){
    final Widget datax = SingleChildScrollView(
      physics: new BouncingScrollPhysics(),
      child: Container(
      child:Column(
      children: [
        Container(
          margin: EdgeInsets.only(
              top: SizeConfig.blockVertical * 3,),
          child: CardRow(context,"Stock Pakan",_stock_pakan),
        ),
        Container(
          margin: EdgeInsets.only(
          right: SizeConfig.blockHorizotal * 15),
          child: CardColumn(context,"Tanggal Panen",_tanggal_panen,Alignment.centerLeft,SizeConfig.blockVertical * 3),
        ),
        Container(
          margin: EdgeInsets.only(
              right: SizeConfig.blockHorizotal * 15),
          child: CardColumn(context,"Target Harga Jual",_target_jual,Alignment.centerLeft,SizeConfig.blockVertical * 3),
        ),


        Container(
          child: buildCardChart(
              title: "Tingkat Kematian",
              percent: 95,
              status: 1,
              statusCount: "4",
              date: "September",
              chartData: _createSampleData()),

        ),

        Container(
          child: buildCardChart(
              title: "Tingkat Kematian",
              percent: 95,
              status: 1,
              statusCount: "4",
              date: "September",
              chartData: _createSampleData()),

        ),

        Row(
            children: <Widget>[
              Expanded(child: Container(
                child: CardColumn(context,"Jumlah Ikan",_jumlah_ikan,Alignment.center,0),
              )),
              Expanded(child: Container(
                child: CardColumn(context,"Berat Ikan ",_berat_ikan,Alignment.center,0),
              ),),
            ],
        ),
        Container(
          margin: EdgeInsets.only(
              right: SizeConfig.blockHorizotal * 15),
          child: CardColumn(context,"Informasi Modal",_informasi_modal,Alignment.centerLeft,SizeConfig.blockVertical * 3),
        ),
        Container(
          margin: EdgeInsets.only(
              right: SizeConfig.blockHorizotal * 15),
          child: CardColumn(context,"Perkiraan Omset",_perkiraan_omset,Alignment.centerLeft,SizeConfig.blockVertical * 3),
        ),
        Container(
          margin: EdgeInsets.only(
              right: SizeConfig.blockHorizotal * 15),
          child: CardColumn(context,"Laba / Keuntungan",_laba,Alignment.centerLeft,SizeConfig.blockVertical * 3),
        ),

        Container(
            margin: EdgeInsets.only(
                top: SizeConfig.blockVertical * 2),
          width: double.infinity,
            child: CustomElevation(
                height: 40.0,
                child: RaisedButton(
                  highlightColor: colorPrimary,
                  //Replace with actual colors
                  color: colorPrimary,
                  onPressed: () => {},
                  child: Text(
                    "Reset Panen",
                    style: h3.copyWith(color:Colors.white),
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
    new LinearIncome(1, 100000),
    new LinearIncome(2, 100000),
    new LinearIncome(3, 150000),
    new LinearIncome(4, 200000),
    new LinearIncome(5, 100000),
    new LinearIncome(6, 150000),
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
