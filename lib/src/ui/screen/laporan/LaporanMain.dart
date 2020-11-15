import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/HomeLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/Laporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageFour.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageThree.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageTwo.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/DetailLelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangView.dart';

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
    var laporanPage;
    var laporanLelang;
    if (widget.laporan_page == "home") {
      laporanPage = Laporan(idKolam: widget.idKolam.toString(),);
    } else if (widget.laporan_page == "satu") {
      laporanPage = PageOne(
        idKolam: widget.idKolam.toString(),
        tgl: widget.tgl,
        bulan: widget.bulan,
        isoData: widget.isoString,
        tahun: widget.tahun,);
    } else if (widget.laporan_page == "dua") {
      // print(widget.idKolam.toString());
      laporanPage = PageTwo(idKolam: widget.idKolam.toString(),
        tgl: widget.tgl,
        bulan: widget.bulan,
        isoData: widget.isoString,
        tahun: widget.tahun,);
    } else if (widget.laporan_page == "tiga") {
      laporanPage = PageThree(idKolam: widget.idKolam.toString(),
        tgl: widget.tgl,
        bulan: widget.bulan,
        isoData: widget.isoString,
        dataPageTwo:widget.dataPageTwo,
        tahun: widget.tahun,);
    } else if (widget.laporan_page == "empat") {
      laporanPage = PageFour(idKolam: widget.idKolam.toString(),
        tgl: widget.tgl,
        bulan: widget.bulan,
        isoData: widget.isoString,
        dataPageTwo: widget.dataPageTwo,
        dataPageThree:widget.dataPageThree,
        tahun: widget.tahun,);
    }else{
      laporanPage = Laporan(idKolam: widget.idKolam.toString());
    }

    if (widget.laporan_page == "detail_lelang") {
      laporanLelang =  DetailLelangView(idKolam: widget.idKolam.toString(),idLelang: widget.idLelang.toString(),);
    }else {
      laporanLelang = LelangView(idKolam: widget.idKolam.toString());
    }


    _widgetOptions = [
      HomeLaporan(idKolam: widget.idKolam.toString()),
      laporanLelang,
      laporanPage,
    ];
    if (_statusSelected) {
      _setDefault(widget.page);
    }
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              title: Text(
                "Detail Kolam",
                style: TextStyle(
                    fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
              )),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.store,
            ),
            title: Text(
              "Lelang",
              style: TextStyle(
                  fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
            ),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calendar_today),
            title: Text(
              "Laporan",
              style: TextStyle(
                  fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
            ),
          ),
        ],
        type: BottomNavigationBarType.fixed,
        currentIndex: _selectedIndex,
        fixedColor: purpleTextColor,
        onTap: _onItemTapped,
      ),
    );
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
}
