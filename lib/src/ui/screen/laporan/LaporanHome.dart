import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/Laporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageThree.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageTwo.dart';
import 'package:page_transition/page_transition.dart';
class LaporanHome extends StatefulWidget {
  int active;
  LaporanHome({Key key, @required this.active}) : super(key: key);

  @override
  _LaporanHomeState createState() => _LaporanHomeState();
}

class _LaporanHomeState extends State<LaporanHome> {
  bool _showDetail = true;
  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  int _currentIndex = 0;
  final List<int> _backstack = [0];
  List<Widget> _fragments = [Laporan(), PageOne(), PageTwo(), PageThree()];
  @override
  Widget build(BuildContext context) {
    _currentIndex = widget.active;
    print("widget_active${widget.active}");
    navigateTo(_currentIndex);
    return WillPopScope(
      onWillPop: () {
        return customPop(context);
      },
      child: Container(
        child: _fragments[_currentIndex],
      ),
    );
  }

  void navigateTo(int index) {
    _backstack.add(index);
    setState(() {
      _currentIndex = index;
    });
  }

  void navigateBack(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  Future<bool> customPop(BuildContext context) {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: DashboardView(

            )));
  }
}
