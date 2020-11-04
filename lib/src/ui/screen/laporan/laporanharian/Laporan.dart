import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:page_transition/page_transition.dart';

class Laporan extends StatefulWidget {
  final String idKolam;

  Laporan({Key key, this.idKolam}) : super(key: key);

  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  var now = new DateTime.now();
  bool _showDetail = true;
  int activeMonth = 0;
  var bulan = [
    "",
    'Januari',
    'Februari',
    'Maret',
    'April',
    'Mei',
    'Juni',
    "Juli",
    "Agustus",
    "September",
    "Oktober",
    "November",
    "Desember"
  ];

  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  void setMontActive(dynamic day) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        activeMonth = day.month;
      });
    });
  }

  DateTime _currentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Widget _eventIcon = new Container(
      decoration: new BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(1000)),
          border: Border.all(color: Colors.blue, width: 2.0)),
      child: new Icon(
        Icons.person,
        color: Colors.amber,
      ),
    );
    EventList<Event> _markedDateMap = new EventList<Event>(
      events: {
        new DateTime(2019, 2, 10): [
          new Event(
            date: new DateTime(2019, 2, 10),
            title: 'Event 1',
            icon: _eventIcon,
          ),
        ],
      },
    );
    CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

    // void initState() {
    /// Add more events to _markedDateMap EventList
    // _markedDateMap.add(
    //     new DateTime(2019, 2, 25),
    //     new Event(
    //       date: new DateTime(2019, 2, 25),
    //       title: 'Event 5',
    //       icon: _eventIcon,
    //     ));

    // _markedDateMap.add(
    //     new DateTime(2019, 2, 10),
    //     new Event(
    //       date: new DateTime(2019, 2, 10),
    //       title: 'Event 4',
    //       icon: _eventIcon,
    //     ));

    // _markedDateMap.addAll(new DateTime(2019, 2, 11), [
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 1',
    //     icon: _eventIcon,
    //   ),
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 2',
    //     icon: _eventIcon,
    //   ),
    //   new Event(
    //     date: new DateTime(2019, 2, 11),
    //     title: 'Event 3',
    //     icon: _eventIcon,
    //   ),
    // ]);
    //   super.initState();
    // }

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child:Scaffold(
          resizeToAvoidBottomPadding: false,
          backgroundColor: backgroundGreyColor,
          body: Container(
              color: backgroundGreyColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  AppBarContainer(context, "Monitor", DashboardView(),Colors.white),
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                    child: InkWell(
                      onTap: () {
                        _toggleDetail();
                        print(_showDetail);
                      },
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "${bulan[int.parse(activeMonth.toString())]} ${now.year}",
                              style: body1.copyWith(color: colorPrimary),
                            ),
                            Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  _showDetail
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
                                  color: purpleTextColor,
                                  size: 14.0,
                                )),
                          ]),
                    ),
                  ),
                  Container(
                      color: backgroundGreyColor,
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0),
                      child: Column(
                        children: [
                          Visibility(
                              visible: _showDetail ? true : false,
                              child: Wrap(
                                children: [
                                  Card(
                                      elevation: 10,
                                      shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0),
                                      ),
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            left: 16.0,
                                            right: 16.0,
                                            bottom: 16.0),
                                        child: Wrap(
                                          children: [
                                            CalendarCarousel<Event>(
                                              onDayPressed: (DateTime date,
                                                  List<Event> events) {
                                                if (date.day == now.day &&
                                                    date.month == now.month &&
                                                    date.year == now.year) {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          // duration: Duration(microseconds: 1000),
                                                          child: LaporanMain(
                                                            tgl: date.day,
                                                            bulan: date.month,
                                                            tahun: date.year,
                                                            page: 2,
                                                            laporan_page:
                                                                "satu",
                                                          )));
                                                } else {
                                                  BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Laporan hanya bisa dilakukan pada tanggal hari ini");
                                                }
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
                                              thisMonthDayBorderColor:
                                                  Colors.transparent,
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
                                                setMontActive(day);
                                                if (day.day > now.day) {

                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .grey)));
                                                } else if (day.day == now.day &&
                                                    day.month == now.month &&
                                                    day.year == now.year) {
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .white)));
                                                } else {
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2));
                                                }
                                              },
                                              headerText: bulan[int.parse(
                                                  activeMonth.toString())],
                                              todayButtonColor: purpleTextColor,
                                              todayBorderColor: purpleTextColor,
                                              todayTextStyle: TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'poppins',
                                                  letterSpacing: 0.14,
                                                  fontSize: 18.02),
                                              weekdayTextStyle: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.36,
                                                  fontSize: 11.81),
                                              markedDatesMap: _markedDateMap,
                                              height:
                                                  SizeConfig.blockHorizotal *
                                                      90,
                                              // selectedDateTime: DateTime(2020, 10, ),
                                              daysHaveCircularBorder: false,

                                              /// null for not rendering any border, true for circular border, false for rectangular border
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              )),
                          Visibility(
                              visible: _showDetail ? false : true,
                              child: Column(
                                children: [
                                  Container(
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 0.0, 10.0, 0.0),
                                          child: Row(
                                            children: [
                                              CardInfo(context, "Ikan Mati",
                                                  "80", "Ekor"),
                                              CardInfo(context, "Pakan", "100",
                                                  "Kg"),
                                              CardInfo(context, "Berat", "1000",
                                                  "Kg"),
                                            ],
                                          ))),
                                  Container(
                                      margin: EdgeInsets.only(top: 12.0),
                                      child: SingleChildScrollView(
                                          scrollDirection: Axis.vertical,
                                          padding: EdgeInsets.fromLTRB(
                                              10.0, 0.0, 10.0, 0.0),
                                          child: Container(
                                              child: Column(
                                            children: [
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          // duration: Duration(microseconds: 1000),
                                                          child: LaporanMain(
                                                            page: 2,
                                                            laporan_page:
                                                                "satu",
                                                          )));
                                                  // print("aaaaaa");
                                                },
                                                child: CardDateLapora(context,
                                                    "1 September 2020"),
                                              ),
                                              GestureDetector(
                                                child: CardDateLapora(context,
                                                    "1 September 2020"),
                                              ),
                                              GestureDetector(
                                                child: CardDateLapora(context,
                                                    "1 September 2020"),
                                              )
                                            ],
                                          )))),
                                ],
                              ))
                        ],
                      ))
                ],
              ))),
    );
  }
}
