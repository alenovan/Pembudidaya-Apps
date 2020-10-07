import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
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
  return Container(
    margin: EdgeInsets.symmetric(horizontal: 16.0),
    child: CalendarCarousel<Event>(
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
      // showWeekDays: null,
      iconColor: Colors.black,

      /// for pass null when you do not want to render weekDays
      headerText: 'September',
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
        // if (day.day == 15) {
        //   return Center(
        //     child: Icon(Icons.local_airport),
        //   );
        // } else {
        //   return null;
        // }
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
      height: 420.0,
      selectedDateTime: _currentDate,
      daysHaveCircularBorder: false,

      /// null for not rendering any border, true for circular border, false for rectangular border
    ),
  );
}

// ignore: non_constant_identifier_names
Widget AppbarForgot(BuildContext context, String title, Widget page) {
  SizeConfig().init(context);
  final Widget appBar = AppBar(
    toolbarHeight: 100.0,
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
            width: 150.0,
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
