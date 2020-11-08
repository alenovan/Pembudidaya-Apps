import 'dart:ffi';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AreaAndLineChart.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class LaporanHomeWidget extends StatelessWidget {
  const LaporanHomeWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardColumn(BuildContext context, String title, String sub,
    Alignment align, double left) {
  final Widget svgIcon = Container(
    height: 100,
    width: double.infinity,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
          padding: EdgeInsets.only(left: left),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  alignment: align,
                  child: Text(
                    title,
                    style: subtitle2.copyWith(color: colorPrimary),
                  )),
              Container(
                  alignment: align,
                  child: Text(
                    sub,
                    style: h3.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 1.15),
                  )),
            ],
          ),
        )),
  );
  return svgIcon;
}

Widget CardRow(BuildContext context, String title, String sub) {
  final Widget svgIcon = Container(
    height: 100,
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Container(
            padding: EdgeInsets.only(
                left: SizeConfig.blockVertical * 3, right: 15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        child: Text(
                      title,
                      style: subtitle2.copyWith(color: colorPrimary),
                    )),
                    Container(
                        child: Text(
                      sub,
                      style: h3.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 1.15),
                    )),
                  ],
                ),
                Container(
                    margin: EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerRight,
                    child: CustomElevation(
                        height: 40.0,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: colorPrimary,
                          onPressed: () => {},
                          child: Text(
                            "Request",
                            style: overline.copyWith(color: Colors.white),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))),
              ],
            ))),
  );
  return svgIcon;
}

Widget buildCardChart(
    {@required String title,
    @required int percent,
    @required int status,
    @required String statusCount,
    @required String date,
    @required chartData}) {
  var statusData;
  if (status == 1) {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_up,
        size: 12.0,
      ),
      Text(
        " "+  statusCount + "%",
        style: overline.copyWith(color: Colors.green),
      )
    ]);
  } else {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_down,
        color: Colors.red,
        size: 12.0,
      ),
      Text(
        " "+  statusCount + "%",
        style: overline.copyWith(color: Colors.red),
      )
    ]);
  }
  return Card(
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 3),
          child: Text(
            title,
            style: subtitle2,
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockVertical * 2),
              child: Text(
                percent.toString() + "%",
                style: body2,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockVertical * 1),
              child: statusData,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 1),
          child: Text(
            date,
            style: body2.copyWith(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: SizeConfig.blockVertical * 3,
            bottom: SizeConfig.blockHorizotal * 3,
          ),
          width: double.infinity,
          height: 200,
          child: AreaAndLineChart(
            chartData,
            animate: true,
          ),
        ),
      ],
    ),
  );
}

Widget buildCardChartGram(
    {@required String title,
    @required int percent,
    @required int status,
    @required String statusCount,
    @required String date,
    @required chartData}) {
  var statusData;
  if (status == 1) {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_up,
        size: 12.0,
      ),
      Text(
        " "+  statusCount + "%",
        style: overline.copyWith(color: Colors.green),
      )
    ]);
  } else {
    statusData = Row(children: <Widget>[
      Icon(
        Icons.trending_down,
        color: Colors.red,
        size: 12.0,
      ),
      Text(
        " "+  statusCount + "%",
        style: overline.copyWith(color: Colors.red),
      )
    ]);
  }
  return Card(
    elevation: 4,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 3),
          child: Text(
            title,
            style: subtitle2,
          ),
        ),
        Row(
          children: [
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockVertical * 2),
              child: Text(
                percent.toString() + "gr",
                style: body2,
              ),
            ),
            Container(
              padding: EdgeInsets.only(left: SizeConfig.blockVertical * 1),
              child: statusData,
            ),
          ],
        ),
        Container(
          padding: EdgeInsets.only(
              left: SizeConfig.blockVertical * 2,
              top: SizeConfig.blockHorizotal * 1),
          child: Text(
            date,
            style: body2.copyWith(color: Colors.grey),
          ),
        ),
        Container(
          padding: EdgeInsets.only(
            left: SizeConfig.blockVertical * 3,
            bottom: SizeConfig.blockHorizotal * 3,
          ),
          width: double.infinity,
          height: 200,
          child: AreaAndLineChart(
            chartData,
            animate: true,
          ),
        ),
      ],
    ),
  );
}
