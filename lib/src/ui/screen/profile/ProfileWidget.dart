import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

// ignore: non_constant_identifier_names
Widget AppbarProfile(BuildContext context, String title, Widget page) {
  SizeConfig().init(context);
  final Widget appBar = AppBar(
    toolbarHeight: 180.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Text('My App'),
    actions: <Widget>[
      IconButton(
        icon: Icon(
          Icons.settings,
          color: Colors.black,
        ),
        onPressed: () {
          // do something
        },
      )
    ],
  );
  return appBar;
}


// ignore: non_constant_identifier_names
Widget AppbarForgot(BuildContext context, String title,Color color,String status) {
  SizeConfig().init(context);
  var lokasi;
  if(status == "dashboard"){
    lokasi = DashboardView();
  }else{
    lokasi = ProfileScreen();
  }
  final Widget appBar = Container(
    margin: EdgeInsets.only(top:SizeConfig.blockVertical*8,bottom:SizeConfig.blockVertical*4,),
    child: Row(
      children: [
        Container(
            margin: EdgeInsets.only(
                left: SizeConfig.blockHorizotal*5),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.rightToLeft, child: lokasi));
                /* Write listener code here */
              },
              child: IconTheme(
                data: IconThemeData(color: appBarTextColor),
                child: Icon(Icons.arrow_back),
              ),
            )),
        Container(
          margin: EdgeInsets.only(
              left: SizeConfig.blockHorizotal*4),
          child:  Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: h3,
              ),
              Text(
                "*Harap isi sesuai Dengan Ktp",
                style: caption.copyWith(color:Colors.red),
              )
            ],
          ),
        )
      ],
    ),
  );
  return appBar;
}
// ignore: non_constant_identifier_names
Widget ProfileMenu(BuildContext context, String title, Widget page) {
  SizeConfig().init(context);
  final Widget appBar = Container(
      child: GestureDetector(
    onTap: () => {
      if(page != null){
        Navigator.push(
            context, PageTransition(type: PageTransitionType.fade, child: page))
      }
    },
    child: Container(
        height: 50.0,
        padding: EdgeInsets.only(left: 20.0, right: 20.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    child: Text(
                  title,
                  style: subtitle1,
                )),
                Row(
                  children: [
                    IconButton(
                      onPressed: () => {},
                      tooltip: MaterialLocalizations.of(context)
                          .openAppDrawerTooltip,
                      icon: Icon(FontAwesomeIcons.chevronRight,
                          size: 17.0, color: colorPrimary),
                    )
                  ],
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(right: 20.0),
              color: greyLineColor,
              height: 0.5,
            ),
          ],
        )),
  ));
  return appBar;
}


