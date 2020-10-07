import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/home/HomeLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/Laporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageThree.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageTwo.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangView.dart';

class Test extends StatefulWidget {
  final int page;
  final String laporan_page;
  Test({Key key, this.page, this.laporan_page}) : super(key: key);

  @override
  _TestState createState() => _TestState();
}

class _TestState extends State<Test> {
  int _selectedIndex = 0;
  bool _statusSelected = true;
  var _widgetOptions;
  @override
  Widget build(BuildContext context) {
    var laporanPage;
    if (widget.laporan_page == "home") {
      laporanPage = Laporan();
    } else if (widget.laporan_page == "satu") {
      laporanPage = PageOne();
    } else if (widget.laporan_page == "dua") {
      laporanPage = PageTwo();
    } else if (widget.laporan_page == "tiga") {
      laporanPage = PageThree();
    }
    _widgetOptions = [
      HomeLaporan,
      LelangView(),
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
      print(_selectedIndex);
    });
  }

  void _setDefault(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
