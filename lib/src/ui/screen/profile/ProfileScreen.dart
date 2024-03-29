import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_session/flutter_session.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/ProfileWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _noHp = "-";
  String _nama = "-";
  String _ktp_number = " ";
  String _ktp_photo = " ";
  var loop = 0;
  var blox;
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  void update() async {
    blox = await bloc.getProfile();
    setState(() {
      _noHp = blox['data']['phone_number'].toString() == "null"
          ? " "
          : blox['data']['phone_number'].toString();
      _nama = blox['data']['name'].toString() == "null"
          ? " "
          : blox['data']['name'].toString();
      _ktp_number = blox['data']['ktp_number'].toString() == "null"
          ? " "
          : blox['data']['ktp_number'].toString();
      _ktp_photo = blox['data']['ktp_photo'].toString() == "null"
          ? " "
          : blox['data']['ktp_photo'].toString();
    });
  }

  @override
  void initState() {
    update();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    SizeConfig().init(context);
    GestureDetector gs = GestureDetector(
        onTap: () {
          // _togglevisibility();
        },
        child: Icon(
          Icons.search,
          color: colorPrimary,
        ));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        drawer: Drawers(context),
        body: Stack(
          children: [
            new Positioned(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    color: Colors.white,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                    margin: EdgeInsets.only(
                                top: SizeConfig.blockHorizotal * 3,
                      bottom: SizeConfig.blockHorizotal * 3,),
                          child:  AppBarContainer(
                              context, "", null, Colors.white),
                        ),
                        Container(
                          child:Container(
                              margin: EdgeInsets.only(
                                  top: SizeConfig.blockVertical * 10),
                              child: Align(
                                alignment: Alignment.center,
                                child: Column(
                                  children: [
                                    new Container(
                                        margin: EdgeInsets.only(top:ScreenUtil().setHeight(80)),
                                        width: 100.0,
                                        height: 100.0,
                                        decoration: new BoxDecoration(
                                            shape: BoxShape.circle,
                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: new NetworkImage(
                                                    "https://img.freepik.com/free-photo/abstract-surface-textures-white-concrete-stone-wall_74190-8184.jpg?size=626&ext=jpg")))),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top:ScreenUtil().setHeight(10)),
                                        child: Text(
                                          _nama,
                                          style: subtitle1.copyWith(
                                              fontSize: ScreenUtil(
                                                  allowFontScaling:
                                                  true)
                                                  .setSp(55)),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                            top:ScreenUtil().setHeight(10)),
                                        child: Text(
                                          _noHp,
                                          style:
                                          caption.copyWith(color: colorPrimary,fontSize: ScreenUtil(
                                              allowFontScaling:
                                              true)
                                              .setSp(45)),
                                        ))
                                  ],
                                ),
                              ))
                        ),
                      ],
                    ),
                  ),
                  Visibility(
                    visible: false,
                      child: ListView(
                    children: [
                      Container(
                          child: Container(
                              height: 50.0,
                              padding: EdgeInsets.only(left: 20.0, right: 20.0,top:40),
                              color: Colors.white,
                              child: Column(
                                children: [
                                  InkWell(
                                      onTap: () => {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type:
                                                        PageTransitionType.fade,
                                                    child: BiodataScreen()))
                                          },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Container(
                                              child: Text(
                                            "Aktivasi Akun",
                                            style: subtitle1,
                                          )),
                                          Row(
                                            children: [
                                              Container(
                                                  alignment:
                                                      Alignment.centerRight,
                                                  child: Text(
                                                    "Akun Belum Teraktivasi",
                                                    style: overline.copyWith(
                                                        color: Colors.red),
                                                  )),
                                              IconButton(
                                                onPressed: () => {
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type:
                                                              PageTransitionType
                                                                  .fade,
                                                          child:
                                                              BiodataScreen()))
                                                },
                                                tooltip:
                                                    MaterialLocalizations.of(
                                                            context)
                                                        .openAppDrawerTooltip,
                                                icon: Icon(
                                                    FontAwesomeIcons
                                                        .chevronRight,
                                                    size: 17.0,
                                                    color: colorPrimary),
                                              )
                                            ],
                                          )
                                        ],
                                      )),
                                ],
                              ))),
                      Container(
                        color: colorGreyBackground,
                        height: 40.0,
                      ),
                    ],
                  )),
                  SizedBox(
                    height: 30.0,
                  ),
                  ProfileMenu(context, "Ketentuan Layanan", null),
                  ProfileMenu(context, "Kebijakan Privasi", null),
                  ProfileMenu(context, "Pusat Bantuan", null),
                  ProfileMenu(context, "Saran", null),
                  Container(
                    padding: EdgeInsets.only(left: 40.0, right: 50.0,top: 20.0),
                    child: GestureDetector(
                      onTap: () {
                        // FlutterSession().set("token", " ");
                        // Navigator.push(
                        //     context,
                        //     PageTransition(
                        //         type: PageTransitionType.fade, child: LoginView()));
                      },
                      child:  Container(
                          margin: EdgeInsets.only(bottom: 50.0),
                          width: 300,
                          height: 50,
                          child: OutlineButton(
                            onPressed: () {
                              FlutterSession().set("token", " ");
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: LoginView()));
                            },
                            child: Text(
                              "Keluar",
                              style: TextStyle(
                                fontFamily: "popins",
                                fontSize: 18.0,
                                fontWeight: FontWeight.w500,
                                color: Colors.red,
                              ),
                            ),
                            borderSide: BorderSide(color: Colors.red,width: 2),
                            shape: StadiumBorder(),
                          )),
                    ),
                  )
                ],
              ),
            ),

          ],
        ));
  }


}
