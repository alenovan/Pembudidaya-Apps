import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';

class KolamWidget extends StatelessWidget {
  const KolamWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardPenentuanPakan(BuildContext context, String title, String rating,
    String kilo, int price, String image) {
  ScreenUtil.instance = ScreenUtil()..init(context);
  final formatter = new NumberFormat("#,###");
  final Widget svgIcon = Container(
    height: ScreenUtil().setHeight(420),
    child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
        ),
        child: Container(
            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), right: ScreenUtil().setWidth(20)),
                  width: ScreenUtil().setWidth(220),
                  padding: EdgeInsets.only(
                    top: SizeConfig.blockHorizotal * 2,
                    bottom: SizeConfig.blockVertical * 2,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: Image.network(
                      image,
                      fit: BoxFit.cover,
                      errorBuilder: (BuildContext context, Object exception,
                          StackTrace stackTrace) {
                        return Image.network("https://via.placeholder.com/300");
                      },
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockHorizotal * 3,
                            left: SizeConfig.blockVertical * 2,
                          ),
                          child: Text(
                            title,
                            style: subtitle2.copyWith(fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockHorizotal * 1,
                            left: SizeConfig.blockVertical * 2,
                          ),
                          child: Text(
                        "Rp."+formatter.format(price),
                        style: subtitle2.copyWith(color: Colors.black,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(45)),
                      )),
                      Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockHorizotal * 1,
                            left: SizeConfig.blockVertical * 1,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                                  child: Icon(
                                    Icons.circle,
                                    color: Colors.grey[300],
                                    size: ScreenUtil(allowFontScaling: false).setSp(30),
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: ScreenUtil().setWidth(40)),
                                child: Text(
                                  " "+kilo,
                                  style: caption.copyWith(fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                ),
                              )
                            ],
                          )),
                      Container(
                          margin: EdgeInsets.only(
                            top: SizeConfig.blockHorizotal * 1,
                            left: SizeConfig.blockVertical * 1,
                          ),
                          child: Row(
                            children: [
                              Container(
                                  margin: EdgeInsets.only(left: ScreenUtil().setWidth(10), top: ScreenUtil().setWidth(2)),
                                  child: Icon(
                                    Boxicons.bx_dollar_circle,
                                    color: colorPrimary,
                                    size: ScreenUtil(allowFontScaling: false).setSp(60),
                                  )),
                              Container(
                                margin: EdgeInsets.only(left: ScreenUtil().setWidth(20), top: ScreenUtil().setWidth(4)),
                                child: Text(
                                  " COD",
                                  style: caption.copyWith(color: colorPrimary,fontWeight: FontWeight.bold,fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                ),
                              )
                            ],
                          )),
                    ],
                  ),
                ),
                // Container(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       formatter.format(price)+"/KG",
                //       style: subtitle2.copyWith(color:colorPrimary),
                //     )),
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
    contentPadding: EdgeInsets.fromLTRB(leftx, rightx, topx, bottomx),// control your hints text size
    hintText: label,
    filled: true,
    isDense: true,
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
