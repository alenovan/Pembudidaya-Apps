
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

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}


Widget CardPenentuanPakan(
    BuildContext context, String title, String sub, String satuan) {
  final Widget svgIcon = Container(
    height: 110,
    child:Container(
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
                          'https://via.placeholder.com/300',
                        ),
                      ),
                    ),
                    Container(
                      transform: Matrix4.translationValues(0.0, -10.0, 0.0),
                      margin: EdgeInsets.only(left: 10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              child: Text(
                                title,
                                style: TextStyle(
                                    color: purpleTextColor,
                                    fontFamily: 'poppins',
                                    letterSpacing: 0.4,
                                    fontSize: subTitleLogin),
                              )),
                          Container(
                              margin: EdgeInsets.only(top: 5.0),
                              child: Row(
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        child: Text(
                                          sub,
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'lato',
                                              letterSpacing: 0.4,
                                              fontSize: 12.0),
                                        ),
                                      )
                                    ],
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(left: 3.0),
                                    child: Text(
                                      "/ "+satuan,
                                      style: TextStyle(
                                          color: greyTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 12.0),
                                    ),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                ),
              ],
            )),
  );
  return svgIcon;
}
