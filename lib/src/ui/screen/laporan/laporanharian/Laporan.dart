import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/bloc/MonitorBloc.dart';
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
  int activeYear = 0;
  var fistDateInMonth = "";
  var total_fish_died = 0;
  var total_feed_spent = 0;
  var last_fish_weight = 0;
  List<String> values = List<String>();
  var bulan = [
    '',
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
    // print("data");
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  void setMontActive(dynamic day) async {
    await WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        activeMonth = day.month;
        activeYear = day.year;
        fistDateInMonth = "$activeYear-$activeMonth-01T00:00:00+0000";
      });
    });
  }

  DateTime _currentDate = DateTime.now();
  var lastDateInMonth = DateTime.now().toIso8601String();

  void dataCalendar() async {
    var data = await bloc.analyticsMonitor(
        widget.idKolam, activeMonth.toString(), activeYear.toString());
    var datax = json.decode(json.encode(data));
    try {
      setState(() {
        total_fish_died = tryCoba(datax["total_fish_died"]);
        total_feed_spent = tryCoba(datax["total_feed_spent"]);
        last_fish_weight = tryCoba(datax["last_fish_weight"]);
      });
    } catch (_) {
      setState(() {
        total_fish_died = 0;
        total_feed_spent = 0;
        last_fish_weight = 0;
      });
    }

    var dataEvent = await bloc.analyticsCalendar(
        widget.idKolam, "${activeYear}-${activeMonth}-01T00:00:00Z","${activeYear}-${activeMonth}-31T00:00:00Z");
    print(dataEvent);
    setState(() {
      values = dataEvent;
    });
  }

  int tryCoba(int data) {
    try {
      return data;
    } catch (_) {
      return 0;
    }
  }

  @override
  void initState() {
    setState(() {
      activeMonth = now.month;
      activeYear = now.year;
    });
    dataCalendar();
    super.initState();
  }

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
        new DateTime(2020, 11, 2): [
          new Event(
            date: new DateTime(2020, 11, 2),
            title: 'Event 1',
            icon: _eventIcon,
            dot: Container(
              margin: EdgeInsets.symmetric(horizontal: 1.0),
              color: Colors.red,
              height: 5.0,
              width: 5.0,
            ),
          ),
        ],
      },
    );
    CalendarCarousel _calendarCarousel, _calendarCarouselNoHeader;

    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: DefaultTabController(
            length: 2,
            child: Scaffold(
                appBar: AppBar(
                  backgroundColor: Colors.white,
                  brightness: Brightness.light,
                  title: Text(
                    "Monitor",
                    style: h3,
                  ),
                  elevation: 0,
                  leading: IconButton(
                    icon: Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  bottom: PreferredSize(
                      child: TabBar(
                          indicatorColor: colorPrimary,
                          isScrollable: false,
                          unselectedLabelColor: Colors.white.withOpacity(0.3),
                          tabs: [
                            Tab(
                              child: Text(
                                'Laporan',
                                style: caption,
                              ),
                            ),
                            Tab(
                              child: Text(
                                'Rekap Bulanan',
                                style: caption,
                              ),
                            ),
                          ]),
                      preferredSize: Size.fromHeight(30.0)),
                ),
                body: TabBarView(
                  children: <Widget>[
                    Container(
                      child: Center(
                        child: Container(
                          margin: EdgeInsets.only(
                              left: 20.0, right: 20.0, top: 20.0),
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(
                                      left: 20.0, right: 20.0, bottom: 10.0),
                                  child: Text(
                                    "Silahkan klik tanggal untuk melihat / melakukan laporan harian",
                                    style: TextStyle(
                                        color: blackTextColor,
                                        fontFamily: 'poppins',
                                        letterSpacing: 0.25,
                                        fontSize: 15.0),
                                    textAlign: TextAlign.center,
                                  )),
                              Wrap(
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
                                                            idKolam: widget
                                                                .idKolam
                                                                .toString(),
                                                            tgl: date.day,
                                                            bulan: date.month,
                                                            tahun: date.year,
                                                            isoString: date,
                                                            page: 2,
                                                            laporan_page:
                                                                "satu",
                                                          )));
                                                } else if (date.day < now.day) {
                                                  var tambahan = "";
                                                  if (date.day < 10) {
                                                    tambahan = "0";
                                                  }
                                                  if (values.contains(
                                                      "${date.year}-${date.month}-${tambahan}${date.day}")) {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                                PageTransitionType
                                                                    .leftToRight,
                                                            child:
                                                                LaporanDetail(
                                                                  isoDate: date.toIso8601String(),
                                                                  idKolam: widget.idKolam,
                                                                  tanggal: date.day,
                                                                  tahun: date.year,
                                                                  bulan: date.month,
                                                                )));
                                                  } else {
                                                    Navigator.push(
                                                        context,
                                                        PageTransition(
                                                            type:
                                                            PageTransitionType
                                                                .fade,
                                                            // duration: Duration(microseconds: 1000),
                                                            child: LaporanMain(
                                                              idKolam: widget
                                                                  .idKolam
                                                                  .toString(),
                                                              tgl: date.day,
                                                              bulan: date.month,
                                                              tahun: date.year,
                                                              isoString: date,
                                                              page: 2,
                                                              laporan_page:
                                                              "satu",
                                                            )));
                                                  }
                                                } else {
                                                  BottomSheetFeedback.show(
                                                      context,
                                                      title: "Mohon Maaf",
                                                      description:
                                                          "Laporan hanya bisa dilakukan pada tanggal hari ini");
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
                                                if (day.day > now.day &&
                                                    day.month == now.month) {
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .grey)));
                                                } else if (day.month >
                                                    now.month) {
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .grey)));
                                                } else if (day.month <=
                                                    now.month) {
                                                  var tambahan = "";
                                                  if (day.day < 10) {
                                                    tambahan = "0";
                                                  }
                                                  if (values.contains(
                                                      "${day.year}-${day.month}-${tambahan}${day.day}")) {
                                                    return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .black)),
                                                    );
                                                  } else if (day.day ==
                                                          now.day &&
                                                      day.month == now.month) {
                                                    Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .white)),
                                                    );
                                                  } else if (day.year !=
                                                      now.year) {
                                                    Center(
                                                        child: Text(
                                                            day.day.toString(),
                                                            style: body2.copyWith(
                                                                color: Colors
                                                                    .grey)));
                                                  } else {
                                                    return Container(
                                                        width: 100,
                                                        height: 50,
                                                        color: Colors.red,
                                                        child: Center(
                                                          child: Text(
                                                              day.day
                                                                  .toString(),
                                                              style: body2.copyWith(
                                                                  color: Colors
                                                                      .white)),
                                                        ));
                                                  }
                                                } else if (day.day == now.day &&
                                                    day.month == now.month &&
                                                    day.year == now.year) {
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .white)));
                                                } else if (day.year !=
                                                    now.year) {
                                                  Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2.copyWith(
                                                              color: Colors
                                                                  .grey)));
                                                } else {
                                                  // print(day.toIso8601String());
                                                  return Center(
                                                      child: Text(
                                                          day.day.toString(),
                                                          style: body2));
                                                }
                                              },
                                              todayButtonColor: values.contains("${now.year}-${now.month}-${now.day}") ? Colors.green[400]:colorPrimary,
                                              // dayButtonColor:values.contains("${now.year}-${now.month}-${now.day}") ? Colors.green:colorPrimary,
                                              daysTextStyle:TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w500,
                                                  fontFamily: 'poppins',
                                                  letterSpacing: 0.14,
                                                  fontSize: 18.02),
                                              todayBorderColor: values.contains("${now.year}-${now.month}-${now.day}") ? Colors.green[400]:colorPrimary,
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
                                              markedDateIconBorderColor:
                                                  Colors.white,
                                              height:
                                                  SizeConfig.blockHorizotal *
                                                      90,
                                              selectedDateTime: DateTime(
                                                  activeYear, activeMonth, 01),
                                              selectedDayButtonColor:
                                                  Colors.transparent,
                                              selectedDayBorderColor:
                                                  Colors.transparent,
                                              daysHaveCircularBorder: false,
                                              onCalendarChanged:
                                                  (DateTime date) {
                                                dataCalendar();
                                                this.setState(() {
                                                  setMontActive(date);
                                                });
                                              },

                                              /// null for not rendering any border, true for circular border, false for rectangular border
                                            )
                                          ],
                                        ),
                                      ))
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                      child: SingleChildScrollView(
                          physics: ScrollPhysics(),
                          child: Container(
                              color: backgroundGreyColor,
                              margin: EdgeInsets.only(
                                  left: 20.0, right: 20.0, top: 30.0),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    CardRekap(
                                        context,
                                        "Pakan",
                                        "${total_feed_spent} Kg",
                                        "${bulan[int.parse(activeMonth.toString())]} ${now.year}"),
                                    CardRekap(
                                        context,
                                        "Ikan Mati",
                                        "${total_fish_died} Ekor",
                                        "${bulan[int.parse(activeMonth.toString())]} ${now.year}"),
                                    CardRekap(
                                        context,
                                        "Berat Ikan",
                                        "${last_fish_weight}",
                                        "${bulan[int.parse(activeMonth.toString())]} ${now.year}"),
                                  ],
                                ),
                              ))),
                    ),
                  ],
                )))
        // body: Container(
        //     color: backgroundGreyColor,
        //     child: Column(
        //       mainAxisSize: MainAxisSize.min,
        //       children: <Widget>[
        //         // AppBarContainer(context, "Monitor", DashboardView(),Colors.white),
        //         Container(
        //           margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
        //           child: InkWell(
        //             onTap: () {
        //               _toggleDetail();
        //               print(_showDetail);
        //             },
        //             child: Row(
        //                 mainAxisAlignment: MainAxisAlignment.center,
        //                 children: [
        //                   Text(
        //                     "${bulan[int.parse(activeMonth.toString())]} ${now.year}",
        //                     style: body1.copyWith(color: colorPrimary),
        //                   ),
        //                   Container(
        //                       padding: EdgeInsets.only(left: 10.0),
        //                       child: Icon(
        //                         _showDetail
        //                             ? FontAwesomeIcons.chevronUp
        //                             : FontAwesomeIcons.chevronDown,
        //                         color: purpleTextColor,
        //                         size: 14.0,
        //                       )),
        //                 ]),
        //           ),
        //         ),
        //         Container(
        //             color: backgroundGreyColor,
        //             margin:
        //                 EdgeInsets.only(left: 20.0, right: 20.0, top: 13.0),
        //             child: Column(
        //               children: [
        //                 Visibility(
        //                     visible: _showDetail ? true : false,
        //                     child: Wrap(
        //                       children: [
        //                         Card(
        //                             elevation: 10,
        //                             shape: RoundedRectangleBorder(
        //                               borderRadius:
        //                                   BorderRadius.circular(15.0),
        //                             ),
        //                             child: Container(
        //                               margin: EdgeInsets.only(
        //                                   left: 16.0,
        //                                   right: 16.0,
        //                                   bottom: 16.0),
        //                               child: Wrap(
        //                                 children: [
        //                                   CalendarCarousel<Event>(
        //                                     onDayPressed: (DateTime date,
        //                                         List<Event> events) {
        //                                       if (date.day == now.day &&
        //                                           date.month == now.month &&
        //                                           date.year == now.year) {
        //                                         Navigator.push(
        //                                             context,
        //                                             PageTransition(
        //                                                 type:
        //                                                     PageTransitionType
        //                                                         .fade,
        //                                                 // duration: Duration(microseconds: 1000),
        //                                                 child: LaporanMain(
        //                                                   idKolam: widget
        //                                                       .idKolam
        //                                                       .toString(),
        //                                                   tgl: date.day,
        //                                                   bulan: date.month,
        //                                                   tahun: date.year,
        //                                                   page: 2,
        //                                                   laporan_page:
        //                                                       "satu",
        //                                                 )));
        //                                       } else {
        //                                         BottomSheetFeedback.show(
        //                                             context,
        //                                             title: "Mohon Maaf",
        //                                             description:
        //                                                 "Laporan hanya bisa dilakukan pada tanggal hari ini");
        //                                       }
        //                                     },
        //                                     weekendTextStyle: TextStyle(
        //                                       color: Colors.black,
        //                                     ),
        //                                     iconColor: Colors.black,
        //                                     headerTextStyle: TextStyle(
        //                                         color: purpleTextColor,
        //                                         fontWeight: FontWeight.w500,
        //                                         fontFamily: 'poppins',
        //                                         letterSpacing: 0.14,
        //                                         fontSize: 18.02),
        //                                     thisMonthDayBorderColor:
        //                                         Colors.transparent,
        //                                     customDayBuilder: (
        //                                       bool isSelectable,
        //                                       int index,
        //                                       bool isSelectedDay,
        //                                       bool isToday,
        //                                       bool isPrevMonthDay,
        //                                       TextStyle textStyle,
        //                                       bool isNextMonthDay,
        //                                       bool isThisMonthDay,
        //                                       DateTime day,
        //                                     ) {
        //                                       setMontActive(day);
        //                                       if (day.day > now.day) {
        //                                         return Center(
        //                                             child: Text(
        //                                                 day.day.toString(),
        //                                                 style: body2.copyWith(
        //                                                     color: Colors
        //                                                         .grey)));
        //                                       } else if (day.day == now.day &&
        //                                           day.month == now.month &&
        //                                           day.year == now.year) {
        //                                         return Center(
        //                                             child: Text(
        //                                                 day.day.toString(),
        //                                                 style: body2.copyWith(
        //                                                     color: Colors
        //                                                         .white)));
        //                                       } else {
        //                                         // print(day.toIso8601String());
        //                                         return Center(
        //                                             child: Text(
        //                                                 day.day.toString(),
        //                                                 style: body2));
        //                                       }
        //                                     },
        //                                     todayButtonColor: purpleTextColor,
        //                                     todayBorderColor: purpleTextColor,
        //                                     todayTextStyle: TextStyle(
        //                                         color: Colors.white,
        //                                         fontWeight: FontWeight.w500,
        //                                         fontFamily: 'poppins',
        //                                         letterSpacing: 0.14,
        //                                         fontSize: 18.02),
        //                                     weekdayTextStyle: TextStyle(
        //                                         color: Colors.black,
        //                                         fontWeight: FontWeight.w500,
        //                                         fontFamily: 'lato',
        //                                         letterSpacing: 0.36,
        //                                         fontSize: 11.81),
        //                                     markedDatesMap: _markedDateMap,
        //                                     height:
        //                                         SizeConfig.blockHorizotal *
        //                                             90,
        //                                     // selectedDateTime: DateTime(2020, 10, ),
        //                                     daysHaveCircularBorder: false,
        //
        //                                     /// null for not rendering any border, true for circular border, false for rectangular border
        //                                   )
        //                                 ],
        //                               ),
        //                             ))
        //                       ],
        //                     )),
        //                 Visibility(
        //                   visible: _showDetail ? false : true,
        //                   child: SingleChildScrollView(
        //                       physics: ScrollPhysics(),
        //                       child: Column(
        //                         children: [
        //                           Container(
        //                               child: SingleChildScrollView(
        //                                   scrollDirection: Axis.horizontal,
        //                                   padding: EdgeInsets.fromLTRB(
        //                                       10.0, 0.0, 10.0, 0.0),
        //                                   child: Row(
        //                                     children: [
        //                                       CardInfo(
        //                                           context,
        //                                           "Ikan Mati",
        //                                           total_fish_died.toString(),
        //                                           "Ekor"),
        //                                       CardInfo(
        //                                           context,
        //                                           "Pakan",
        //                                           total_feed_spent.toString(),
        //                                           "Kg"),
        //                                       CardInfo(
        //                                           context,
        //                                           "Berat",
        //                                           last_fish_weight.toString(),
        //                                           "Kg"),
        //                                     ],
        //                                   ))),
        //                           // Container(height: SizeConfig.blockVertical * 55,child:ListView.builder(
        //                           //   shrinkWrap: true,
        //                           //   scrollDirection: Axis.vertical,
        //                           //   itemCount: now.month != activeMonth ?  31:now.day,
        //                           //   itemBuilder:
        //                           //       (BuildContext context, int index) =>
        //                           //           CardDateLapora(
        //                           //               context, "${index+1} ${bulan[int.parse(activeMonth.toString())]} ${activeYear.toString()}")
        //                           // ),)
        //                         ],
        //                       )),
        //                 )
        //               ],
        //             ))
        //       ],
        //     ))),
        );
  }

  Widget CardRekap(
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
                            style: subtitle2.copyWith(
                                color: Colors.black, fontSize: 20.0),
                          ))
                    ],
                  ),
                  Container(
                      alignment: Alignment.centerRight,
                      child: Text(
                        number,
                        style: subtitle2.copyWith(
                            color: Colors.black, fontSize: 20.0),
                      ))
                ],
              ))),
    );
    return svgIcon;
  }
}
