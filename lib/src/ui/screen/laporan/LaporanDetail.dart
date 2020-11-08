import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:page_transition/page_transition.dart';

class LaporanDetail extends StatefulWidget {
  final String idKolam;
  final int bulan;
  final int tanggal;
  final int tahun;
  final String isoDate;
  LaporanDetail({Key key, this.idKolam, this.bulan, this.tanggal, this.tahun, this.isoDate}) : super(key: key);

  @override
  _LaporanDetailState createState() => _LaporanDetailState();
}

class _LaporanDetailState extends State<LaporanDetail> {
  var now = new DateTime.now();
  bool _showDetail = true;
  int activeMonth = 0;
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
          resizeToAvoidBottomPadding: false,
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
              "Laporan",
              style: h3,
            ),
          ),
          body: Container(
              color: backgroundGreyColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  // AppBarContainer(context, "Monitor", DashboardView(),Colors.white),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: InkWell(
                      onTap: () {
                        _toggleDetail();
                        print(_showDetail);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${bulan[int.parse(widget.bulan.toString())]} ${widget.tahun}",
                              style: body1.copyWith(color: colorPrimary),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  _showDetail
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
                                  color: purpleTextColor,
                                  size: 14.0,
                                )),
                          ]),
                    ),
                  ),
                  Container(
                      color: backgroundGreyColor,
                      margin:
                      EdgeInsets.only(left: 20.0, right: 20.0, top: 30.0),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          children: [
                            CardRekap(context, "Pakan",
                                "0 Kg", ""),
                            CardRekap(context, "Ikan Mati",
                                "0", ""),
                            CardRekap(context, "Berat Ikan",
                                "0 Kg", ""),
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

