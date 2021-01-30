import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/laporanv2/BottomSheetLaporan.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:lelenesia_pembudidaya/src/bloc/MonitorBloc.dart' as monitor;
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class LaporanScreen extends StatefulWidget {
  final String idKolam;

  LaporanScreen({Key key, @required this.idKolam}) : super(key: key);

  @override
  _HomeLaporanState createState() => _HomeLaporanState();
}

class _HomeLaporanState extends State<LaporanScreen> {

  ScrollController _controller_scroll;
  bool silverCollapsed = false;
  var status_checkout = false;
  String _month_active = "";
  String myTitle = "";
  Color silverColor = Colors.transparent;
  Color tmblColor = Colors.black;
  DateTime _currentDate2 = DateTime.now();
  var _calendarController;
  Map<DateTime, List> _holidays;
  CalendarCarousel _calendarCarousel;
  AnimationController _animationController;
  Map<DateTime, List> _events= {};
  //var date
  int activeMonth = 0;
  int activeYear = 0;
  //end date
  //var fish
  var total_fish_died = 0;
  var total_feed_spent = 0;
  var last_fish_weight = 0;
  DateTime _tanggal_tebar = DateTime(2021,01,01);
  List<String> dateInsert = List<String>();
  //end var fish

  //get set data
  void detailKolam() async {
    var detail = await kolam.bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    setState(() {
      _tanggal_tebar = DateTime.parse(data['harvest']['sow_date']);
      activeYear = _currentDate2.year;
      activeMonth = _currentDate2.month;
    });
    var dataEvent = await monitor.bloc.analyticsCalendar(
        widget.idKolam,
        "${activeYear}-${activeMonth}-01T00:00:00Z",
        "${activeYear}-${activeMonth}-31T00:00:00Z");
    setState(() {
      dateInsert = dataEvent;
      for (var listIkan in dateInsert) {
        _events[DateFormat("yyyy-MM-dd").parse(listIkan)] = ["aaa"];
      }
    });
    message(context, "Mohon Tunggu");
    DateTime date = DateTime.now();
    var dataz = dataInserted("${activeYear}-${activeMonth}-${date.day}T00:00:00Z");
    dataz.then((val) {
      AppExt.popScreen(context);

      if (val[1] == "0") {
        laporan_null_screen_one(context, date);
      } else {
        laporan_not_null(context, val[0], val[1].toString(),
            val[2].toString(), val[3].toString());
      }
    });
  }

  Future<dynamic> dataInserted(date) async  {
    var data = await monitor.bloc.analyticsMonitorByDate(
        widget.idKolam, date.toString());
    var datax = json.decode(json.encode(data));
    print(datax);
    return [datax["date"].toString(),tryCoba(datax["feed_spent"].toString()).toString(),tryCoba(datax["fish_died"].toString()).toString(),tryCoba(datax["weight"].toString()).toString()];
  }





  @override
  void initState() {
    detailKolam();
    super.initState();

    _calendarController = CalendarController();
    initializeDateFormatting(); //very important
    _controller_scroll = ScrollController();
    _controller_scroll.addListener(() {
      if (_controller_scroll.offset > 20 &&
          !_controller_scroll.position.outOfRange) {
        if (!silverCollapsed) {
          myTitle = "Detail Kolam";
          silverCollapsed = true;

          setState(() {
            silverColor = colorPrimary;
            tmblColor = Colors.white;
          });
        }
      }
      if (_controller_scroll.offset <= 20 &&
          !_controller_scroll.position.outOfRange) {
        if (silverCollapsed) {
          myTitle = "";
          silverCollapsed = false;
          silverColor = Colors.transparent;
          setState(() {
            silverColor = Colors.transparent;
            tmblColor = Colors.black;
          });
        }
      }
    });
    initializeDateFormatting(); //very important
    _controller_scroll = ScrollController();
    _controller_scroll.addListener(() {
      if (_controller_scroll.offset > 20 &&
          !_controller_scroll.position.outOfRange) {
        if (!silverCollapsed) {
          myTitle = "Detail Kolam";
          silverCollapsed = true;

          setState(() {
            silverColor = colorPrimary;
            tmblColor = Colors.white;
          });
        }
      }
      if (_controller_scroll.offset <= 20 &&
          !_controller_scroll.position.outOfRange) {
        if (silverCollapsed) {
          myTitle = "";
          silverCollapsed = false;
          silverColor = Colors.transparent;
          setState(() {
            silverColor = Colors.transparent;
            tmblColor = Colors.black;
          });
        }
      }
    });

  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        resizeToAvoidBottomPadding: false,
        backgroundColor: Colors.white,
        body: Stack(
          children: [
            Container(
              width: double.infinity,
              child: Image.asset(
                "assets/png/header_laporan.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: ScreenUtil().setHeight(500),
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 3,
                      top: SizeConfig.blockHorizotal * 10),
                  child: IconButton(
                    icon: Icon(Icons.arrow_back,
                        color: Colors.black,
                        size: ScreenUtil(allowFontScaling: true).setSp(80)),
                    onPressed: () => {
                      Navigator.push(
                          context,
                          PageTransition(
                              type: PageTransitionType.fade,
                              child: DetailKolam(
                                idKolam: widget.idKolam,
                              )))
                    },
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      padding: EdgeInsets.only(
                          left: SizeConfig.blockVertical * 3,
                          right: SizeConfig.blockVertical * 3),
                      child: _buildTableCalendarWithBuilders(),
                    ),
                    Container(
                      padding: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 5,
                        right: SizeConfig.blockVertical * 3,
                        top: ScreenUtil().setHeight(280),
                        bottom: ScreenUtil().setHeight(180),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.squareFull,
                                color: Colors.red,
                                size: ScreenUtil(allowFontScaling: true)
                                    .setSp(40),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 2,
                                    top: ScreenUtil().setHeight(2),
                                    right: SizeConfig.blockVertical * 3),
                                child: Text(
                                  "Belum ada Laporan",
                                  style: overline.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ScreenUtil(allowFontScaling: true)
                                              .setSp(40)),
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            children: [
                              Icon(
                                FontAwesomeIcons.squareFull,
                                color: colorPrimary,
                                size: ScreenUtil(allowFontScaling: true)
                                    .setSp(40),
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 2,
                                    right: SizeConfig.blockVertical * 3),
                                child: Text(
                                  "Hari Ini",
                                  style: overline.copyWith(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          ScreenUtil(allowFontScaling: true)
                                              .setSp(40)),
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  Widget _buildTableCalendarWithBuilders() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      initialCalendarFormat: CalendarFormat.month,
      formatAnimation: FormatAnimation.slide,
      startingDayOfWeek: StartingDayOfWeek.sunday,
      availableGestures: AvailableGestures.all,
      availableCalendarFormats: const {CalendarFormat.month: ''},
      calendarStyle: CalendarStyle(
        outsideDaysVisible: true,
        weekendStyle: TextStyle().copyWith(
            color: Colors.black,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        weekdayStyle: TextStyle().copyWith(
            color: Colors.black,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        markersColor: colorPrimary,
        holidayStyle: TextStyle().copyWith(
            color: Colors.transparent,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        outsideStyle: TextStyle().copyWith(
            color: Colors.grey,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        outsideWeekendStyle: TextStyle().copyWith(
            color: Colors.grey,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
      ),
      daysOfWeekStyle: DaysOfWeekStyle(
        weekdayStyle: TextStyle().copyWith(
            color: Colors.black,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
        weekendStyle: TextStyle().copyWith(
            color: Colors.red[600],
            fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
      ),
      headerVisible: true,
      headerStyle: HeaderStyle(
        titleTextStyle: h3.copyWith(
            color: tmblColor,
            fontSize: ScreenUtil(allowFontScaling: true).setSp(50)),
        formatButtonShowsNext: false,
        centerHeaderTitle: true,
        leftChevronIcon: Icon(
          FontAwesomeIcons.angleLeft,
          color: tmblColor,
          size: ScreenUtil(allowFontScaling: true).setSp(70),
        ),
        rightChevronIcon: Icon(
          FontAwesomeIcons.angleRight,
          color: tmblColor,
          size: ScreenUtil(allowFontScaling: true).setSp(70),
        ),
        headerPadding: EdgeInsets.only(
            top: ScreenUtil().setHeight(100),
            bottom: ScreenUtil().setHeight(300)),
        leftChevronPadding: EdgeInsets.only(left: ScreenUtil().setWidth(80)),
        rightChevronPadding:
            EdgeInsets.only(right: ScreenUtil().setWidth(80)),
      ),
      builders: CalendarBuilders(
        selectedDayBuilder: (context, date, _) {
          return InkWell(
            onTap: (){
            message(context, "Mohon Tunggu");
            var data = dataInserted(date.toIso8601String());
            data.then((val) {
              AppExt.popScreen(context);
              if(val[1] == "0"){
                laporan_null_screen_one(context,date);
              }else{
                laporan_not_null(context, val[0], val[1].toString(),
                    val[2].toString(), val[3].toString());
              }

            });
          },
          child:Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(
                  color: colorPrimary,
                  fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
            ),
          ));
        },
        todayDayBuilder: (context, date, _) {
          return Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(36.0),
                border: Border.all(width: 2, color: Colors.white)),
            child: Text(
              '${date.day}',
              style: TextStyle().copyWith(
                  color: colorPrimary,
                  fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
            ),
          );
        },
        dayBuilder: (context, date,dayBuilder){
          var data;
          if(date.isBefore(_tanggal_tebar) ){
            data = Container(
              margin: const EdgeInsets.all(4.0),
              alignment: Alignment.center,
              child: Text(
                '${date.day}',
                style: TextStyle().copyWith(
                    color: Colors.black,
                    fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
              ),
            );
          }else{
            if(date.isAfter(_currentDate2) ){
              data = Container(
                margin: const EdgeInsets.all(4.0),
                alignment: Alignment.center,
                child: Text(
                  '${date.day}',
                  style: TextStyle().copyWith(
                      color: Colors.grey,
                      fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
                ),
              );
            }else{
              data = GestureDetector(
                onTap: (){
                  laporan_null_screen_one(context,date);
                },
                child:Container(
                  margin: const EdgeInsets.all(4.0),
                  alignment: Alignment.center,
                  color: Colors.red,
                  child: Text(
                    '${date.day}',
                    style: TextStyle().copyWith(
                        color: Colors.white,
                        fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
                  ),
                ),
              );
            }

          };
          return data;
          //pengecekan if nanti taruh disini
        },
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];
          if (events.isNotEmpty) {
            children.add(
              Align(
                alignment: Alignment.center,
                child: _buildInsertMarker(date),
              ),
            );
          }

          return children;
        },
      ),
      onVisibleDaysChanged: _onVisibleDaysChanged,
      onCalendarCreated: _onCalendarCreated,
    );
  }



  Widget _buildInsertMarker(DateTime date) {
    return InkWell(
      onTap: (){
        message(context,"Mohon Tunggu");
        var data = dataInserted(date.toIso8601String());
         data.then((val){
           AppExt.popScreen(context);
           laporan_not_null(context,val[0],val[1].toString(),val[2].toString(),val[3].toString());
        });
      },
      child: Container(
        color: colorPrimary,
        height: ScreenUtil().setHeight(100),
        width: ScreenUtil().setHeight(100),
        child: Align(
          alignment: Alignment.center,
          child: Text(
            date.day.toString(),
            style: TextStyle().copyWith(
                color: Colors.white,
                fontSize: ScreenUtil(allowFontScaling: true).setSp(40)),
          ),
        ),
      ),
    );
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {}

  void _onCalendarCreated(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onCalendarCreated');
  }

  void displayBottomSheet(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (ctx) {
          return Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: Center(
              child: Text("Welcome to AndroidVille!"),
            ),
          );
        });
  }

  void laporan_null_screen_one(BuildContext context,DateTime date) {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
              child: BottomSheetLaporan(date: date,idKolam: widget.idKolam,),
            ),
          );
        });
  }

  void laporan_not_null(BuildContext context,String date,String pakan,String mati,String berat) {
    showModalBottomSheet(
        barrierColor: Colors.white.withOpacity(0),
        isScrollControlled: true,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(top: Radius.circular(15))),
        context: context,
        builder: (BuildContext bc) {
          return Container(
            decoration: new BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(15)),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 4,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.fromLTRB(15, 20, 15, 45),
              child: bottomSheetInserted(context,date,(int.parse(pakan)/1000).toString(),mati,berat),
            ),
          );
        });
  }






}
