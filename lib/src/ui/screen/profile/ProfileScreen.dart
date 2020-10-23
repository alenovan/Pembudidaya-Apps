import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
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
        backgroundColor: colorGreyBackground,
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
                    color: Colors.white,
                    height: SizeConfig.blockHorizotal * 65,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                            child: Align(
                          alignment: Alignment.topLeft,
                          child: Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockHorizotal * 5,
                                  left: SizeConfig.blockVertical * 3),
                              child: IconButton(
                                onPressed: () =>
                                    _scaffoldKey.currentState.openDrawer(),
                                tooltip: MaterialLocalizations.of(context)
                                    .openAppDrawerTooltip,
                                icon: Icon(FontAwesomeIcons.arrowLeft,
                                    size: 20.0),
                              )),
                        )),
                        Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockHorizotal * 10,
                                right: SizeConfig.blockVertical * 5),
                            child: Align(
                              alignment: Alignment.topRight,
                              child: Text(
                                "EDIT",
                                style: TextStyle(
                                    color: colorPrimary,
                                    fontFamily: 'lato',
                                    letterSpacing: 0.4,
                                    fontSize: subTitleLogin),
                              ),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockVertical * 10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Column(
                                children: [
                                  new Container(
                                      width: 100.0,
                                      height: 100.0,
                                      decoration: new BoxDecoration(
                                          shape: BoxShape.circle,
                                          image: new DecorationImage(
                                              fit: BoxFit.fill,
                                              image: new NetworkImage(
                                                  "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg")))),
                                  Container(
                                      margin: EdgeInsets.only(
                                          top: SizeConfig.blockVertical * 2),
                                      child: Text(
                                        "Alenovan Wiradhika Putra",
                                        style: TextStyle(
                                            fontFamily: 'lato',
                                            letterSpacing: 0.15,
                                            fontSize: 20.0),
                                      )),
                                  Container(
                                      child: Text(
                                    "081334367717",
                                    style: TextStyle(
                                        color: colorPrimary,
                                        fontFamily: 'lato',
                                        letterSpacing: 0.15,
                                        fontSize: 16.0),
                                  ))
                                ],
                              ),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    color: colorGreyBackground,
                    height: 40.0,
                  ),
                  Container(
                      child: Container(
                          height: 50.0,
                          padding: EdgeInsets.only(left: 20.0, right: 20.0),
                          color: Colors.white,
                          child: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      child: Text(
                                    "Aktivasi Akun",
                                    style: TextStyle(
                                        color: appBarTextColor,
                                        fontFamily: 'lato',
                                        letterSpacing: 0.4,
                                        fontSize: 18.0),
                                  )),
                                  Row(
                                    children: [
                                      Container(
                                          alignment: Alignment.centerRight,
                                          child: Text(
                                            "Akun Belum Teraktivasi",
                                            style: TextStyle(
                                                color: redTextColor,
                                                fontFamily: 'lato',
                                                letterSpacing: 0.4,
                                                fontSize: 14.0),
                                          )),
                                      IconButton(
                                        onPressed: () => _scaffoldKey
                                            .currentState
                                            .openDrawer(),
                                        tooltip:
                                            MaterialLocalizations.of(context)
                                                .openAppDrawerTooltip,
                                        icon: Icon(
                                            FontAwesomeIcons.chevronRight,
                                            size: 17.0,
                                            color: colorPrimary),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ],
                          ))),
                  Container(
                    color: colorGreyBackground,
                    height: 40.0,
                  ),
                  ProfileMenu(context, "Ketentuan Layanan", BiodataScreen()),
                  ProfileMenu(context, "Kebijakan Privasi", BiodataScreen()),
                  ProfileMenu(context, "Pusat Bantuan", BiodataScreen()),
                  ProfileMenu(context, "Saran", BiodataScreen()),
                ],
              ),
            ),
            Align(
              alignment: FractionalOffset.bottomCenter,
              child:
                  Container(
                    color: Colors.white,
                    height: 45.0,
                    width: MediaQuery.of(context).size.width,
                    child: Align(
                      alignment: Alignment.center, // Align however you like (i.e .centerRight, centerLeft)
                      child: Text(
                        "KELUAR",
                        style: TextStyle(
                            color: redTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: 16.0),
                      ),
                    ),


              ),
            )
          ],
        ));
  }
}
