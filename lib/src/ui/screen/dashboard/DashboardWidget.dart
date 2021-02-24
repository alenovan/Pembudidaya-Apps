import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/riwayat/RiwayatPakan.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolamView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:page_transition/page_transition.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return null;
  }
}

Widget CardKolam(BuildContext context, String title, String sub, String status,
    String sr, int fcr, int current_amount) {
  ScreenUtil.instance = ScreenUtil()
    ..init(context);
  var text;
  var color;
  if (status == "0") {
    text = "Belum Teraktivasi";
    color = Colors.grey;
  } else if (status == "1") {
    text = "Kosong";
    color = Colors.redAccent;
  } else if (status == "2") {
    text = "Sedang Budidaya";
    color = blueAqua;
  } else if (status == "3") {
    text = "Siap Panen";
    color = Colors.green;
  } else if (status == "-1") {
    text = "Belum Aktivasi Akun";
    color = Colors.redAccent;
  } else {
    text = status;
    color = Colors.redAccent;
  }
  final Widget svgIcon = Container(
    height: ScreenUtil().setHeight(310),
    child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ScreenUtil().setWidth(50)),
        ),
        child: Container(
            padding: EdgeInsets.only(left: ScreenUtil().setWidth(50),
                right: ScreenUtil().setWidth(50)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.circle,
                          color: color,
                          size: 15.0,
                        ),
                        Container(
                            margin: EdgeInsets.only(left: ScreenUtil().setWidth(20)),
                            child: Text(
                              text,
                              style: caption.copyWith(color: color,
                                  fontSize: SizeConfig.blockVertical * 1.5),
                            ))
                      ],
                    ),
                    Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(60)),
                        child: Text(
                          "Kolam " + title,
                          style: subtitle1.copyWith(
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(50)),
                        )),
                    Container(
                        margin: EdgeInsets.only(top: ScreenUtil().setWidth(20), left: ScreenUtil().setWidth(60)),
                        child: Text(
                          sub,
                          style: overline.copyWith(
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(40)),
                        )),
                  ],
                ),
                sr != "0" ? Container(
                    alignment: Alignment.centerRight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "SR : ${sr}",
                          style: overline.copyWith(color: blueAqua,
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(40)),
                        ),
                        Text(
                          "FCR : ${fcr}",
                          style: overline.copyWith(color: blueAqua,
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(40)),
                        ),
                        Text(
                          "Jumlah Ikan : ${current_amount}",
                          style: overline.copyWith(color: blueAqua,
                              fontSize: ScreenUtil(allowFontScaling: false)
                                  .setSp(40)),
                        )
                      ],
                    )):Text(""),
              ],
            ))),
  );
  return svgIcon;
}


// ignore: non_constant_identifier_names
Widget Drawers(BuildContext context) {
  SizeConfig().init(context);
  final Widget drawer = Container(
    width: SizeConfig.blockHorizotal * 65,
    child: Drawer(
      child: Container(
          color: colorPrimaryLightSlider,
          child: Stack(
            children: [
              Positioned(
                child: Column(
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 5,
                              left: SizeConfig.blockHorizotal * 3,
                              bottom: SizeConfig.blockVertical * 5),
                          child: IconButton(
                            icon: Icon(
                              MaterialIcons.close,
                              size: 30.0,
                              color: Colors.white,
                            ),
                            onPressed: () => { Navigator.of(context).pop()},
                          )),
                    ),
                    Divider(
                      color: greyLineColor,
                    ),
                    Container(
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(FontAwesome.user_circle, color: Colors.white),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Akun",
                                  style: subtitle1.copyWith(
                                      color: Colors.white, fontSize: 17.0),
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: ProfileScreen()));
                        },
                      ),
                    ),
                    Divider(
                      color: greyLineColor,
                    ),
                    Container(
                      child: ListTile(
                        title: Row(
                          children: [
                            Icon(Icons.assignment,
                                color: Colors.white),
                            Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Tambah Kolam",
                                  style: subtitle1.copyWith(
                                      color: Colors.white, fontSize: 17.0),
                                ))
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              PageTransition(
                                  type: PageTransitionType.fade,
                                  child: TambahKolamView()));
                        },
                      ),
                    ),
                    Divider(
                      color: greyLineColor,
                    ),
                    Container(
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(Boxicons.bx_cart,
                                  color: Colors.white),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Pesanan",
                                  style: subtitle1.copyWith(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: RiwayatPakan()));
                          },
                        )),
                    Divider(
                      color: greyLineColor,
                    ),
                    Container(
                        child: ListTile(
                          title: Row(
                            children: [
                              Icon(Boxicons.bx_log_out,
                                  color: Colors.white),
                              Container(
                                margin: EdgeInsets.only(left: 20.0),
                                child: Text(
                                  "  Keluar",
                                  style: subtitle1.copyWith(
                                      color: Colors.white, fontSize: 17.0),
                                ),
                              )
                            ],
                          ),
                          onTap: () {
                            FlutterSession().set("token", " ");
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: LoginView()));
                          },
                        )),
                    Divider(
                      color: greyLineColor,
                    ),
                  ],
                ),
              ),
              // Container(
              //   child: Text("aaa"),
              // )
            ],
          )),
    ), // We'll populate the Drawer in the next step!
  );
  return drawer;
}

InputDecoration EditTextSearch(BuildContext context, String label, double leftx,
    double rightx, double topx, double bottomx, GestureDetector gs) {
  SizeConfig().init(context);
  final InputDecoration decoration = InputDecoration(
    contentPadding: EdgeInsets.fromLTRB(leftx, rightx, topx, bottomx),
    // control your hints text size
    hintText: label,
    filled: true,
    isDense: true,
    fillColor: Colors.white,
    hintStyle: TextStyle(
      color: greyTextColor,
    ),
    enabledBorder: new OutlineInputBorder(
      borderRadius: new BorderRadius.circular(25.0),
      borderSide: const BorderSide(color: Colors.grey, width: 0.0),
    ),
    border: const OutlineInputBorder(),
    suffixIcon: gs,
  );
  return decoration;
}
