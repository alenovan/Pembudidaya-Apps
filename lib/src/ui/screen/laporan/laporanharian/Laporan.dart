import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanHome.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/TabsPageLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanharian/PageOne.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/test.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoginWidget.dart';
import 'package:page_transition/page_transition.dart';

class Laporan extends StatefulWidget {
  Laporan({Key key}) : super(key: key);

  @override
  _LaporanState createState() => _LaporanState();
}

class _LaporanState extends State<Laporan> {
  bool _showDetail = true;
  void _toggleDetail() {
    setState(() {
      _showDetail = !_showDetail;
    });
  }

  @override
  Widget build(BuildContext context) {
    DateTime _currentDate = DateTime(2020, 9, 3);
    DateTime _currentDate2 = DateTime(2019, 2, 3);
    String _currentMonth = DateFormat.yMMM().format(DateTime(2019, 2, 3));
    DateTime _targetDateTime = DateTime(2019, 2, 3);
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
    return Container(
      child: Scaffold(
          backgroundColor: backgroundGreyColor,
          resizeToAvoidBottomPadding: false,
          appBar: AppbarForgot(context, "Monitoring", LoginView()),
          body: Container(
              margin: EdgeInsets.only(top: 20.0),
              color: backgroundGreyColor,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Container(
                    margin: EdgeInsets.only(left: 20.0, right: 20.0, top: 25.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "September 2020",
                          style: TextStyle(
                              color: purpleTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.25,
                              fontSize: subTitleLogin),
                        ),
                        InkWell(
                            onTap: () {
                              _toggleDetail();
                              print(_showDetail);
                            },
                            child: Container(
                                padding: EdgeInsets.only(left: 10.0),
                                child: Icon(
                                  _showDetail
                                      ? FontAwesomeIcons.chevronUp
                                      : FontAwesomeIcons.chevronDown,
                                  color: purpleTextColor,
                                  size: 14.0,
                                ))),
                      ],
                    ),
                  ),
                  Container(
                      color: backgroundGreyColor,
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                      child: Column(
                        children: [
                          Visibility(
                              visible: _showDetail ? true : false,
                              child: Card(
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Wrap(
                                    children: [
                                      Calendar(
                                          _markedDateMap, _currentDate, context)
                                    ],
                                  ))),
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
                                                          child: Test(
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
