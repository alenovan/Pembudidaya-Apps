import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  bool _showPassword = true;
  bool _clickLogin = true;
  TextEditingController nohpController = new TextEditingController();
  TextEditingController sandiController = new TextEditingController();

  void _togglevisibility() {
    setState(() {
      _showPassword = !_showPassword;
    });
  }

  void _toggleButtonLogin() {
    // setState(() {
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final GlobalKey<ScaffoldState> _scaffoldKey =
        new GlobalKey<ScaffoldState>();

    GestureDetector gs = GestureDetector(
        onTap: () {
          // _togglevisibility();
        },
        child: Icon(
          Icons.search,
          color: colorPrimary,
        ));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomPadding: false,
        drawer: Drawers(context),
        body: Stack(
          children: [
            new Positioned(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    // color: Colors.red,
                    height: SizeConfig.blockHorizotal * 35,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                            child: Align(
                          alignment: Alignment.centerLeft,
                          child: Container(
                              margin: EdgeInsets.only(
                                  left: SizeConfig.blockVertical * 3),
                              child: IconButton(
                                onPressed: () =>
                                    _scaffoldKey.currentState.openDrawer(),
                                tooltip: MaterialLocalizations.of(context)
                                    .openAppDrawerTooltip,
                                icon: Icon(FontAwesomeIcons.bars,
                                    color: colorPrimary, size: 30.0),
                              )),
                        )),
                        Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockVertical * 5),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: IconButton(
                                      onPressed: () => _scaffoldKey.currentState
                                          .openDrawer(),
                                      tooltip: "Notifikasi",
                                      icon: Icon(
                                        FontAwesomeIcons.solidBell,
                                        color: colorPrimary,
                                        size: 30.0,
                                      ))),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -23.0, 0.0),
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 4,
                        right: SizeConfig.blockVertical * 4),
                    child: Column(
                      children: [
                        Container(
                          child: TextFormField(
                            decoration: EditTextSearch(
                                context, "Cari Kolam", 20.0, 0, 0, 0,gs),
                            keyboardType: TextInputType.text,
                            style: TextStyle(
                                color: blackTextColor,
                                fontFamily: 'lato',
                                letterSpacing: 0.4,
                                fontSize: subTitleLogin),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                      transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                      margin: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 4,
                          right: SizeConfig.blockVertical * 4,),
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                        scrollDirection: Axis.vertical,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return GestureDetector(
                              onTap: () {
                                if (index == 1) {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: LaporanMain(
                                              page: 0, laporan_page: "home")));
                                } else {
                                  Navigator.push(
                                      context,
                                      PageTransition(
                                          type: PageTransitionType.fade,
                                          child: TambahKolam()));
                                }
                              },
                              child: Container(
                                margin: EdgeInsets.only(
                                  bottom: SizeConfig.blockHorizotal * 2,),
                                child: CardKolam(
                                    context,
                                    "Kolam lele MK0000" + index.toString(),
                                    "Pilih untuk lihat detail",
                                    index),
                              ));
                        },
                      )),
                ],
              ),
            ),
          ],
        ));
  }
}
