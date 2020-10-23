
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
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
    BuildContext context, String title, String sub, int status) {
  var text;
  var color;
  if(status == 1){
    text = "Siap Panen";
    color = Colors.green;
  }else if(status == 2){
    text = "Sedang Proses";
    color = Colors.lightBlueAccent;
  }else if(status == 3){
    text = "Belum Teraktifasi";
    color = Colors.redAccent;
  }else{
    text = "Kosong";
    color = Colors.redAccent;
  }
  final Widget svgIcon = Container(

    height: 120,
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
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color:color,
                          size: 15.0,
                        ),
                       Container(
                           margin: EdgeInsets.only(left: 5.0),
                         child: Text(
                           text,
                           style: TextStyle(
                               color: color,
                               fontFamily: 'lato',
                               letterSpacing: 0.4,
                               fontSize: 13.0),
                         )
                       )
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0,left: 20),
                        child: Text(
                          title,
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: subTitleLogin),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: 5.0,left: 20),
                        child: Text(
                          sub,
                          style: TextStyle(
                              color: greyTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 12.0),
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
                      FontAwesomeIcons.times,
                      size: 30.0,
                    )),
              ),
              ListTile(
                title: Text('Akun'),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: ProfileScreen()));
                },
              ),
              ListTile(
                title: Text('Tambah Kolam'),
                onTap: () {
                  Navigator.pop(context);
                },
              ),
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
