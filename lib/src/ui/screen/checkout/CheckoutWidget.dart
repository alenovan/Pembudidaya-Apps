import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:shimmer/shimmer.dart';

class CheckoutWidget extends StatelessWidget {
  const CheckoutWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardPenentuanPakan(BuildContext context, String title, String sub,
    String satuan, String image) {
  ScreenUtil.instance = ScreenUtil()..init(context);
  final formatter = new NumberFormat("#,###");
  final double _screenWidth = MediaQuery.of(context).size.width;
  final Widget svgIcon = Container(
    height: ScreenUtil().setHeight(200),
    child: Container(
        child: Row(
          children: [
            Container(
              width: ScreenUtil().setHeight(200),
              child: ClipRRect(
                  borderRadius: BorderRadius.circular(8.0),
                  child: Image.network(
                    image_link + image,
                    fit: BoxFit.cover,
                    height: SizeConfig.blockHorizotal * 17,
                    errorBuilder: (BuildContext context, Object exception,
                        StackTrace stackTrace) {
                      return Image.network(
                        image_link + image,
                        height: SizeConfig.blockHorizotal * 17,
                        fit: BoxFit.cover,
                        frameBuilder: (context, child, frame,
                            wasSynchronouslyLoaded) {
                          if (wasSynchronouslyLoaded) {
                            return child;
                          } else {
                            return AnimatedSwitcher(
                              duration: const Duration(milliseconds: 500),
                              child: frame != null
                                  ? child
                                  : Shimmer.fromColors(
                                baseColor: Colors.grey[300],
                                highlightColor: Colors.grey[200],
                                period: Duration(milliseconds: 1000),
                                child: Container(
                                  width: _screenWidth * (20 / 100),
                                  height: _screenWidth * (15 / 100),
                                  decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(10),
                                      color: Colors.white),
                                ),
                              ),
                            );
                          }
                        },
                      );
                    },
                  )),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                      child: Text(
                        title,
                        style: TextStyle(
                            color: purpleTextColor,
                            fontFamily: 'poppins',
                            letterSpacing: 0.4,
                            fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                      )),
                  Container(
                      margin: EdgeInsets.only(top: 5.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                                ),
                              )
                            ],
                          ),
                         Row(
                           children: [
                                Container(
                                  child: Icon(
                                    Boxicons.bx_minus_circle,
                                    color: colorPrimary, size: ScreenUtil(allowFontScaling: false).setSp(70),
                                  ),
                                ),
                             Container(
                               padding: EdgeInsets.only(left: 5.0,right: 5.0),
                               child: Text(
                                 "100",
                                 style: TextStyle(
                                     color: Colors.black,
                                     fontFamily: 'lato',
                                     letterSpacing: 0.4,
                                     fontSize: ScreenUtil(allowFontScaling: false).setSp(35)),
                               ),
                             ),
                             Container(
                               child: Icon(
                                 Boxicons.bx_plus_circle,
                                 color: colorPrimary,
                                 size: ScreenUtil(allowFontScaling: false).setSp(70),
                               ),
                             ),
                           ],
                         )
                        ],
                      )),
                ],
              ),
            )
          ],
        )),
  );
  return svgIcon;
}
