import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/menu/menu_list_item.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:page_transition/page_transition.dart';

class MenuScreen extends StatefulWidget {
  final String idKolam;

  const MenuScreen({Key key, @required this.idKolam}) : super(key: key);

  @override
  _MenuScreenState createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil();
    final double _screenWidth = MediaQuery.of(context).size.width;
    final double _screenHeight = MediaQuery.of(context).size.height;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.dark),
      child: Scaffold(
        backgroundColor: navScaffoldBg,
        body: Container(
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                child: Image.asset(
                  "assets/png/header_laporan.png",
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: ScreenUtil().setHeight(530),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppBarContainer(
                      context, "", DashboardView(), Colors.transparent),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(50)),
                    child: Text(
                      "Hallo Pembudidaya",
                      style: h3.copyWith(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize:
                              ScreenUtil(allowFontScaling: false).setSp(60)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(
                        top: ScreenUtil().setHeight(10),
                        left: ScreenUtil().setWidth(70),
                        right: ScreenUtil().setWidth(60)),
                    child: Text(
                      "Tentukan jenis ikan apa yang akan anda budidayakan !",
                      style: caption.copyWith(
                          color: Colors.grey,
                          fontWeight: FontWeight.w700,
                          fontSize:
                              ScreenUtil(allowFontScaling: false).setSp(40)),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(80),
                          left: ScreenUtil().setWidth(70),
                          right: ScreenUtil().setWidth(50)),
                      child: SingleChildScrollView(
                        physics: new BouncingScrollPhysics(),
                        child: Column(
                          children: [
                            SizedBox(
                              height: 15,
                            ),
                            menu_list_item(
                              label: "Lele",
                              color: Color(0xFF98ACF8),
                              image: AssetImage("assets/menu/lele.png"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: PenentuanPanenView(
                                          idIkan: "1",
                                          idKolam: widget.idKolam,
                                        )));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),

                            menu_list_item(
                              label: "Mas",
                              color: Color(0xFF98ACF8),
                              image: AssetImage("assets/menu/mas.png"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: PenentuanPanenView(
                                          idIkan: "3",
                                          idKolam: widget.idKolam,
                                        )));
                              },
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            menu_list_item(
                              label: "Nila",
                              color: Color(0xFF98ACF8),
                              image: AssetImage("assets/menu/nila.png"),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: PenentuanPanenView(
                                          idIkan: "2",
                                          idKolam: widget.idKolam,
                                        )));
                              },
                            ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // menu_list_item(
                            //   label: "Mujaer",
                            //   color: Color(0xFF98ACF8),
                            //   image: AssetImage("assets/menu/menu_ikan_mujaer_mask.png"),
                            //   onTap: () => {},
                            // ),
                            // SizedBox(
                            //   height: 10,
                            // ),
                            // menu_list_item(
                            //   label: "Bawal",
                            //   color: Color(0xFF98ACF8),
                            //   image: AssetImage("assets/menu/menu_ikan_bawal_mask.png"),
                            //   onTap: () => {},
                            // ),
                            SizedBox(
                              height: 10,
                            ),
                            menu_list_item(
                              label: "Bandeng",
                              color: Color(0xFF98ACF8),
                              image: AssetImage("assets/menu/bandeng.png"),
                              onTap: () => {},
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            menu_list_item(
                              label: "Patin",
                              color: Color(0xFF98ACF8),
                              image: AssetImage("assets/menu/patin.png"),
                              onTap: () => {},
                            ),
                            SizedBox(
                              height: 10.0,
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
