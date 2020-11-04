import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_calendar_carousel/classes/event.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanDetail.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter_calendar_carousel/flutter_calendar_carousel.dart'
    show CalendarCarousel, EventList;

class KolamWidget extends StatelessWidget {
  const KolamWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardPenentuanPakan(
    BuildContext context, String title, String rating, String kilo,int price,String image) {
  final formatter = new NumberFormat("#,###");
  final Widget svgIcon = Container(
    height: 110,
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
                Row(
                  children: [
                    Container(
                      width: 60.0,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          image_link+image,
                          fit: BoxFit.cover,
                          height: 60.0,
                          errorBuilder: (BuildContext context, Object exception, StackTrace stackTrace) {
                            return Image.network(
                               "https://via.placeholder.com/300"
                            );
                          },
                        ),
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                            title,
                            style: subtitle2,
                          )),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        FontAwesomeIcons.solidStar,
                                        color: Colors.orange,
                                        size: 12.0,
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(left: 5.0),
                                        child: Text(
                                          rating,
                                          style: caption,
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(left: 3.0,top:3.0),
                                      child: Icon(
                                        Icons.circle,
                                        color: Colors.grey[300],
                                        size: 7,
                                      )),
                                  Container(
                                    margin: EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      kilo,
                                      style: caption,
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
                Container(
                    alignment: Alignment.centerRight,
                    child: Text(
                      formatter.format(price)+"/KG",
                      style: subtitle2.copyWith(color:colorPrimary),
                    )),
              ],
            ))),
  );
  return svgIcon;
}

// ignore: non_constant_identifier_names
InputDecoration EditText(BuildContext context, String label, double leftx,
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
    border: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: BorderSide.none,
    ),
    suffixIcon: gs,
  );
  return decoration;
}
