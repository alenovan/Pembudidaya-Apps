import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LaporanWidget.dart';
import 'package:intl/intl.dart' show DateFormat;

class LaporanHome extends StatefulWidget {
  LaporanHome({Key key}) : super(key: key);

  @override
  _LaporanHomeState createState() => _LaporanHomeState();
}

class _LaporanHomeState extends State<LaporanHome> {
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
          backgroundColor: Colors.white,
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
                        Icon(
                          Icons.arrow_drop_up,
                          color: purpleTextColor,
                        ),
                      ],
                    ),
                  ),
                  Container(
                      color: backgroundGreyColor,
                      margin:
                          EdgeInsets.only(left: 20.0, right: 20.0, top: 20.0),
                      child: Card(
                          elevation: 10,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Container(
                              height: 350.0,
                              child: Calendar(
                                  _markedDateMap, _currentDate, context))))
                ],
              ))),
    );
  }
}
