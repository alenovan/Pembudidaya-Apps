import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class LaporanWidget extends StatelessWidget {
  const LaporanWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget Calendar(EventList<Event> _markedDateMap, DateTime _currentDate,
    BuildContext context) {
  var month = 0;
  return Container(
    margin: EdgeInsets.all(16.0),
    child: Wrap(
      children: [
        CalendarCarousel<Event>(
          onDayPressed: (DateTime date, List<Event> events) {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.leftToRight,
                    // duration: Duration(microseconds: 1000),
                    child: LaporanDetail()));
          },
          weekendTextStyle: TextStyle(
            color: Colors.black,
          ),
          iconColor: Colors.black,
          headerTextStyle: TextStyle(
              color: purpleTextColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins',
              letterSpacing: 0.14,
              fontSize: 18.02),
          thisMonthDayBorderColor: Colors.transparent,
          customDayBuilder: (
            bool isSelectable,
            int index,
            bool isSelectedDay,
            bool isToday,
            bool isPrevMonthDay,
            TextStyle textStyle,
            bool isNextMonthDay,
            bool isThisMonthDay,
            DateTime day,
          ) {
            // this.month = day.month;
            if (day.day > 15) {
              return Center(
                  child: Text(day.day.toString(),
                      style: body2.copyWith(color: Colors.grey)));
            } else {
              return Center(child: Text(index.toString(), style: body2));
            }

          },
          todayButtonColor: purpleTextColor,
          todayBorderColor: purpleTextColor,
          selectedDayBorderColor: Colors.red,
          selectedDayButtonColor: Colors.red,
          weekFormat: false,
          weekdayTextStyle: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.w500,
              fontFamily: 'lato',
              letterSpacing: 0.36,
              fontSize: 11.81),
          markedDatesMap: _markedDateMap,
          height: SizeConfig.blockHorizotal * 90,
          selectedDateTime: _currentDate,
          daysHaveCircularBorder: false,

          /// null for not rendering any border, true for circular border, false for rectangular border
        )
      ],
    ),
  );
}

// ignore: non_constant_identifier_names
Widget AppbarForgot(BuildContext context, String title, Widget page) {
  SizeConfig().init(context);
  final Widget appBar = AppBar(
    toolbarHeight: 80.0,
    backgroundColor: Colors.white,
    elevation: 0.0,
    title: Container(
        child: Text(
      title,
      style: TextStyle(
          color: appBarTextColor,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
          letterSpacing: 0.15,
          fontSize: textAppBar),
    )),
    leading: Container(
        margin: EdgeInsets.only(left: 20.0),
        child: GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.rightToLeft, child: page));
            /* Write listener code here */
          },
          child: IconTheme(
            data: IconThemeData(color: appBarTextColor),
            child: Icon(Icons.arrow_back),
          ),
        )),
  );
  return appBar;
}

Widget TitleText(BuildContext context, String title, double sizex, double leftx,
    double rightx, double topx, double bottomx) {
  SizeConfig().init(context);
  final Widget titlex = Container(
    margin:
        EdgeInsets.only(left: leftx, right: rightx, top: topx, bottom: bottomx),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
              color: blackTextColor,
              fontWeight: FontWeight.w500,
              fontFamily: 'poppins',
              fontSize: sizex),
        ),
      ],
    ),
  );

  return titlex;
}

Widget CardInfo(
    BuildContext context, String title, String number, String satuan) {
  final Widget svgIcon = Container(
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Column(
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: appBarTextColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'lato',
                      letterSpacing: 0.4,
                      fontSize: subTitleLogin),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    child: RichText(
                        text: TextSpan(children: <TextSpan>[
                      TextSpan(
                        text: number,
                        style: TextStyle(
                            color: purpleTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: cardNumber),
                      ),
                      TextSpan(
                        text: satuan,
                        style: TextStyle(
                            color: purpleTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: textsubTitleLogin),
                      ),
                    ]))),
              ],
            ))),
  );
  return svgIcon;
}

Widget CardDateLapora(BuildContext context, String title) {
  final Widget svgIcon = Container(
    height: SizeConfig.blockVertical * 11,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      color: appBarTextColor,
                      fontWeight: FontWeight.w700,
                      fontFamily: 'lato',
                      letterSpacing: 0.4,
                      fontSize: subTitleLogin),
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Icon(
                      FontAwesomeIcons.chevronCircleRight,
                      color: purpleTextColor,
                      size: SizeConfig.blockHorizotal * 6,
                    ))
              ],
            ))),
  );
  return svgIcon;
}

Widget CardLelang(
    BuildContext context, String title, String number, String date) {
  final Widget svgIcon = Container(
    height: SizeConfig.blockVertical * 14,
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
                    Text(
                      date,
                      style: TextStyle(
                          color: greyTextColor,
                          fontFamily: 'lato',
                          letterSpacing: 0.4,
                          fontSize: 12.0),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 5.0),
                        child: Text(
                          title,
                          style: subtitle2.copyWith(color:Colors.black,fontSize: 20.0),
                        ))
                  ],
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      number,
                      style: subtitle2.copyWith(color:Colors.black),
                    ))
              ],
            ))),
  );
  return svgIcon;
}


Widget CardLelangBerlangsung(
    BuildContext context, String title, String date) {
  final Widget svgIcon = Container(
    height: SizeConfig.blockVertical * 14,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: InkWell(
          onTap: (){
            Navigator.push(
                context,
                PageTransition(
                    type: PageTransitionType.fade,
                    child: LaporanMain(
                      page: 1, laporan_page: "detail_lelang",idKolam: "20",idLelang: "2",)));
          },
          child: Container(
              padding: EdgeInsets.only(left: 15.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        date,
                        style: TextStyle(
                            color: greyTextColor,
                            fontFamily: 'lato',
                            letterSpacing: 0.4,
                            fontSize: 12.0),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 5.0),
                          child: Text(
                            title,
                            style: subtitle2.copyWith(color:Colors.black,fontSize: 20.0),
                          ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child:  Icon(
                        FontAwesomeIcons.chevronCircleRight,
                        color: purpleTextColor,
                        size: SizeConfig.blockHorizotal * 8,
                      ))
                ],
              )),
        )),
  );
  return svgIcon;
}



// ignore: non_constant_identifier_names
Widget DetailNull(BuildContext context) {
  SizeConfig().init(context);
  final String assetName = "assets/svg/detail.svg";
  final Widget svgIcon = Container(
    child: SvgPicture.asset(
      assetName,
      height: SizeConfig.blockVertical * 30,
      width: SizeConfig.blockHorizotal * 30,
    ),
  );
  return svgIcon;
}
