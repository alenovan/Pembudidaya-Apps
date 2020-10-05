import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanTabNavigationItem.dart';

class TabsPageLaporan extends StatefulWidget {
  final int page;
  TabsPageLaporan({Key key, this.page}) : super(key: key);

  @override
  _TabsPageLaporanState createState() => _TabsPageLaporanState();
}

class _TabsPageLaporanState extends State<TabsPageLaporan> {
  int _currentIndex = 0;
  @override
  Widget build(BuildContext context) {
    // _currentIndex = widget.page == 0 ? _currentIndex : widget.page;
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          for (final tabItem in LaporanTabNavigationItem.items) tabItem.page,
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: backgroundColor,
        unselectedItemColor: greyBottomColor,
        selectedItemColor: purpleTextColor,
        currentIndex: _currentIndex,
        onTap: (int index) => setState(() => _currentIndex = index),
        items: [
          for (final tabItem in LaporanTabNavigationItem.items)
            BottomNavigationBarItem(
              icon: tabItem.icon,
              title: tabItem.title,
            )
        ],
      ),
    );
  }
}
