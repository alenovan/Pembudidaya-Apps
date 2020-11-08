import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/riwayat/RiwayatPakan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolamView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardKolam(
    BuildContext context, String title, String sub, String status) {
  var text;
  var color;
  if (status == "0") {
    text = "Belum Aktif";
    color = Colors.red;
  } else if (status == "1") {
    text = "Kosong";
    color = Colors.redAccent;
  } else if (status == "2") {
    text = "Sedang Panen";
    color = Colors.lightBlueAccent;
  } else if (status == "3") {
    text = "Siap Panen";
    color = Colors.green;
  } else {
    text = status;
    color = Colors.redAccent;
  }
  final Widget svgIcon = Container(
    height: 120,
    child: Card(
        elevation: 4,
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
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: color,
                          size: 15.0,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: 5.0),
                            child: Text(
                              text,
                              style: caption.copyWith(color: color),
                            ))
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0, left: 20),
                        child: Text(
                          title,
                          style: subtitle1,
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 5.0, left: 20),
                        child: Text(
                          sub,
                          style: overline,
                        )),
                  ],
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      color: purpleTextColor,
                      size: SizeConfig.blockHorizotal * 8,
                    )),
              ],
            ))),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
Widget DetailNull(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/svg/fishing.svg";
  final Widget svgIcon = Container(
    child: SvgPicture.asset(
      assetName,
      height: SizeConfig.blockVertical * 30,
      width: SizeConfig.blockHorizotal * 30,
    ),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
Widget Drawers(BuildContext context) {
  SizeConfig().init(context);
  final Widget drawer = Drawer(
    child: Drawer(
      child: Container(
          color: Colors.white,
          child: Stack(
            children: [
              Positioned(
                child: ListView(
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 5,
                              left: SizeConfig.blockHorizotal * 3,
                              bottom: SizeConfig.blockVertical * 5),
                          child: Icon(
                            MaterialIcons.close,
                            size: 30.0,
                          )),
                    ),
                    Container(
                      decoration: BoxDecoration(
                          //                    <-- BoxDecoration
                          border: Border(
                              bottom: BorderSide(color: Colors.grey[300]),
                              top: BorderSide(color: Colors.grey[300]))),
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(FontAwesome.user_circle, color: colorPrimary),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Akun",
                                  style: subtitle1,
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ProfileScreen()));
                        },
                      ),
                    ),
                    Container(
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.assignment_outlined,
                                color: colorPrimary),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Tambah Kolam",
                                  style: subtitle1,
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: TambahKolamView()));
                        },
                      ),
                    ),
                    Container(
                        decoration: BoxDecoration(
                            //                    <-- BoxDecoration
                            border: Border(
                                bottom: BorderSide(color: Colors.grey[300]),
                                top: BorderSide(color: Colors.grey[300]))),
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(FontAwesome.shopping_cart,
                                  color: colorPrimary),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Pesanan",
                                  style: subtitle1,
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: RiwayatPakan()));
                          },
                        )),
                  ],
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                      margin: EdgeInsets.only(bottom: 50.0),
                      width: 250,
                      height: 50,
                      child: OutlineButton(
                        onPressed: () {
                          FlutterSession().set("token", " ");
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: LoginView()));
                        },
                        child: Text(
                          "Keluar",
                          style: TextStyle(
                            fontFamily: "popins",
                            fontSize: 18.0,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                          ),
                        ),
                        borderSide: BorderSide(color: Colors.red),
                        shape: StadiumBorder(),
                      )),
                ),
              )
              // Container(
              //   child: Text("aaa"),
              // )
            ],
          )),
    ), // We'll populate the Drawer in the next step!
  );
  return drawer;
}

InputDecoration EditTextSearch(BuildContext context, String label, double leftx,
    double rightx, double topx, double bottomx, GestureDetector gs) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    contentPadding: EdgeInsets.only(left: leftx, right: rightx),
    hintText: label,
    filled: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
      color: greyTextColor,
    ),
    enabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: const OutlineInputBorder(),
    suffixIcon: gs,
  );
  return decoration;
}
