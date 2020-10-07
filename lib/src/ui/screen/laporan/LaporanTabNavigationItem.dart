import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';

class LaporanTabNavigationItem {
  final Widget page;
  final Widget title;
  final Icon icon;
  int active;

  LaporanTabNavigationItem({
    @required this.page,
    @required this.title,
    @required this.icon,
  });

  static List<LaporanTabNavigationItem> get items => [
        LaporanTabNavigationItem(
          page: LaporanHome(
            active: 0,
          ),
          icon: Icon(Icons.home),
          title: Text(
            "Detail Kolam",
            style: TextStyle(
                fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
          ),
        ),
        LaporanTabNavigationItem(
          page: LaporanHome(
            active: 1,
          ),
          icon: Icon(
            Icons.store,
          ),
          title: Text(
            "Lelang",
            style: TextStyle(
                fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
          ),
        ),
        LaporanTabNavigationItem(
          page: LaporanHome(
            active: 2,
          ),
          icon: Icon(Icons.calendar_today),
          title: Text(
            "Laporan",
            style: TextStyle(
                fontFamily: 'lato', letterSpacing: 0.25, fontSize: 12.0),
          ),
        ),
      ];
}
