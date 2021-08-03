import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/HomeLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/Laporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageFour.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageThree.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageTwo.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanv2/LaporanScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/DetailLelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class LaporanMain extends StatefulWidget {
  final int page;
  final String laporan_page;
  final int tgl;
  final int bulan;
  final int tahun;
  final String idKolam;
  final String idLelang;
  final DateTime isoString;
  final String dataPageTwo;
  final String dataPageThree;
  LaporanMain({Key key, this.page, this.laporan_page, this.idKolam, this.tgl, this.bulan, this.tahun, this.idLelang, this.isoString, this.dataPageTwo, this.dataPageThree}) : super(key: key);

  @override
  _LaporanMainState createState() => _LaporanMainState();
}

class _LaporanMainState extends State<LaporanMain> {
  int _selectedIndex = 0;
  bool _statusSelected = true;
  var _widgetOptions;
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    var laporanPage;
    var laporanLelang;
    laporanPage = Laporan(idKolam: widget.idKolam.toString());
    if (widget.laporan_page == "detail_lelang") {
      laporanLelang =  DetailLelangView(idKolam: widget.idKolam.toString(),idLelang: widget.idLelang.toString(),);
    }else {
      laporanLelang = LelangView(idKolam: widget.idKolam.toString());
    }


    _widgetOptions = [
      HomeLaporan(idKolam: widget.idKolam.toString()),
      LaporanScreen(idKolam: widget.idKolam.toString()),
      laporanLelang,
    ];
    if (_statusSelected) {
      _setDefault(widget.page);
    }
    return WillPopScope(
        onWillPop: _onBackPressed,
        child:Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
              color: Colors.grey[100],
              spreadRadius: 4,
              blurRadius: 7,
              offset:
              Offset(0, 3), // changes position of shadow
            ),
          ],
        ),child:BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Boxicons.bxs_report,size: 30.sp,),
              title: Text(
                "Detail Kolam",
                style: TextStyle(
                    fontFamily: 'lato', letterSpacing: 0.25, fontSize: 20.sp),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Boxicons.bx_calendar,size: 30.sp,),
            title: Text(
              "Laporan",
              style: TextStyle(
                  fontFamily: 'lato', letterSpacing: 0.25, fontSize: 20.sp),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.store,size: 30.sp,),
            title: Text(
              "Pasarkan",
              style: TextStyle(
                  fontFamily: 'lato', letterSpacing: 0.25, fontSize: 20.sp),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        fixedColor: purpleTextColor,
        backgroundColor: Colors.white,
        onTap: _onItemTapped,

      ),
    )));
  }

  void _onItemTapped(int index) {
    setState(() {
      _statusSelected = false;
      if (!_statusSelected) {
        _selectedIndex = index;
      }
      // print(_selectedIndex);
    });
  }

  void _setDefault(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<bool> _onBackPressed() {
    Navigator.of(context).pop(true);
  }

}
