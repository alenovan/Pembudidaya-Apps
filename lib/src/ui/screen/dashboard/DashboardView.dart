import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModelsNew.dart';
import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/ListAlamatPengiriman.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/TambahAlamatView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/menu/menu_screen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/notification/NotificationView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataMapsScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  DbHelper _dbHelper;
  var statusAktivasi = false;
  List<ListKolamModelsNew> dataKolam = new List();
  var items = List<ListKolamModelsNew>();
  var itemsDetail = List<ListKolamModelsNew>();
  TextEditingController _searchBoxController = TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  void fetchData() {
    var cek = 0;
    bloc.fetchAllKolam().then((value) {
      setState(() {
        dataKolam = value;
        items.addAll(dataKolam);
      });
    });
  }

  void cek_profil() async {
    var blox = await profile.bloc.getProfile();
    debugPrint("KTP=>" + blox['data']['ktp_photo'].toString());
    setState(() {
      statusAktivasi = blox['data']['ktp_photo'].toString() == "null" ||
              blox['data']['ktp_photo'].toString() == ""
          ? false
          : true;
    });
  }

  onItemChanged(String query) {
    List<ListKolamModelsNew> dummySearchList = List<ListKolamModelsNew>();
    dummySearchList.addAll(dataKolam);
    if (query.isNotEmpty) {
      List<ListKolamModelsNew> dummyListData = List<ListKolamModelsNew>();
      dummySearchList.forEach((item) {
        if (item.name.toLowerCase().contains(query.toLowerCase())) {
          print(item.name);
          dummyListData.add(item);
        }
      });
      setState(() {
        items.clear();
        items.addAll(dummyListData);
      });
      return;
    } else {
      setState(() {
        items.clear();
        items.addAll(dataKolam);
      });
    }
  }

  @override
  void initState() {
    cek_profil();
    super.initState();
    _dbHelper = DbHelper.instance;
    _dbHelper.initDb();
    fetchData();
  }

  Future<Null> refreshList() async {
    refreshKey.currentState?.show(atTop: false);
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      items.clear();
    });
    fetchData();

    return null;
  }

  void check_database(int id) async {
    var db = await _dbHelper.select_count(id);
    print(db);
    if (db == 0) {
      var data = SqliteDataPenentuanPanen(id, 0, "", 0, 0, 0, 0, 0, 0, 0, 0, 0);
      _dbHelper.insert(data);
    }
  }

  @override
  void dispose() {
    super.dispose();
    // bloc.dispose();
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
          size: ScreenUtil(allowFontScaling: true).setSp(65),
        ));

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ));
    return WillPopScope(
        onWillPop: _onBackPressed,
        child: Scaffold(
            key: _scaffoldKey,
            backgroundColor: Colors.white,
            drawer: Drawers(context),
            body: Container(
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/png/background.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    // add this
                    children: [
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(50),
                            top: ScreenUtil().setHeight(60)),
                        child: IconButton(
                          icon: Icon(FontAwesomeIcons.bars,
                              color: Colors.black,
                              size:20.sp),
                          onPressed: () =>
                              {_scaffoldKey.currentState.openDrawer()},
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            top: ScreenUtil().setHeight(20),
                            left: ScreenUtil().setWidth(80),
                            right: ScreenUtil().setWidth(80)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hallo, Pembudidaya ",
                              style: h3.copyWith(
                                  color: Colors.black,
                                  fontSize: 20.sp),
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              "Selamat datang di eksosistem panen ikan !",
                              style: caption.copyWith(
                                  color: Colors.grey,
                                  fontWeight: FontWeight.w700,
                                  fontSize: 19.sp),
                              textAlign: TextAlign.start,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            new Theme(
                              data: new ThemeData(
                                primaryColor: colorPrimary,
                                primaryColorDark: colorPrimary,
                              ),
                              child: TextFormField(
                                controller: _searchBoxController,
                                onChanged: onItemChanged,
                                decoration: EditTextSearch(
                                    context,
                                    "Cari Kolam",
                                    20.0,
                                    0,
                                    0,
                                    20.h,
                                    gs),
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    color: blackTextColor,
                                    fontFamily: 'lato',
                                    letterSpacing: 0.4,
                                    fontSize: subTitleLogin),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          child: Container(
                        // transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                        margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 1,
                          left: ScreenUtil().setWidth(80),
                          right: ScreenUtil().setWidth(80),
                        ),
                        height: MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                          future: bloc.fetchAllKolam(),
                          builder: (context, AsyncSnapshot<dynamic> snapshot) {
                            if (snapshot.hasData) {
                              return RefreshIndicator(
                                key: refreshKey,
                                child: buildList(snapshot),
                                onRefresh: refreshList,
                              );
                            } else if (snapshot.hasError) {
                              return Text(snapshot.error.toString());
                            }
                            return ListView.builder(
                                itemCount: 5,
                                // Important code
                                itemBuilder: (context, index) => Container(
                                      height: ScreenUtil().setHeight(320),
                                      child: Card(
                                        elevation: 4,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Shimmer.fromColors(
                                              period:
                                                  Duration(milliseconds: 1000),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0, right: 10.0),
                                                width:
                                                    ScreenUtil().setWidth(180),
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
                                                child: SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(80),
                                                ),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              period:
                                                  Duration(milliseconds: 1000),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 2.0),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
                                                child: SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(80),
                                                ),
                                              ),
                                            ),
                                            Shimmer.fromColors(
                                              period:
                                                  Duration(milliseconds: 1000),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,
                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 10.0,
                                                    top: 2.0),
                                                width: double.infinity,
                                                decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.all(
                                                            Radius.circular(
                                                                16.0))),
                                                child: SizedBox(
                                                  height: ScreenUtil()
                                                      .setHeight(80),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ));
                          },
                        ),
                      )),
                      SizedBox(
                        height: ScreenUtil().setHeight(40),
                      )
                    ],
                  )
                ],
              ),
            )));
  }

  Future<bool> _onBackPressed() {
    return showDialog(
          context: context,
          builder: (context) => Container(
            child: Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.0),
              ),
              elevation: 0.0,
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Apakah anda ingin keluar dari aplikasi ini ? ",
                      style: TextStyle(
                          color: blackTextColor,
                          fontFamily: 'poppins',
                          letterSpacing: 0.25,
                          fontSize:
                              ScreenUtil(allowFontScaling: false).setSp(45)),
                      textAlign: TextAlign.center,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                            height: 35.0,
                            margin: EdgeInsets.only(
                                top: SizeConfig.blockVertical * 3),
                            child: CustomElevation(
                                height: 35.0,
                                child: RaisedButton(
                                  highlightColor: colorPrimary,
                                  //Replace with actual colors
                                  color: colorPrimary,
                                  onPressed: () => {SystemNavigator.pop()},
                                  child: Text(
                                    "Ya",
                                    style: TextStyle(
                                        color: backgroundColor,
                                        fontWeight: FontWeight.w500,
                                        fontFamily: 'poppins',
                                        letterSpacing: 1.25,
                                        fontSize:
                                            ScreenUtil(allowFontScaling: false)
                                                .setSp(40)),
                                  ),
                                  shape: new RoundedRectangleBorder(
                                    borderRadius:
                                        new BorderRadius.circular(30.0),
                                  ),
                                ))),
                        Container(
                          height: 35.0,
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 3),
                          child: CustomElevation(
                              height: 35.0,
                              child: RaisedButton(
                                highlightColor: colorPrimary,
                                //Replace with actual colors
                                color: redTextColor,
                                onPressed: () =>
                                    {Navigator.pop(context, false)},
                                child: Text(
                                  "Tidak",
                                  style: TextStyle(
                                      color: backgroundColor,
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'poppins',
                                      letterSpacing: 1.25,
                                      fontSize:
                                          ScreenUtil(allowFontScaling: false)
                                              .setSp(40)),
                                ),
                                shape: new RoundedRectangleBorder(
                                  borderRadius: new BorderRadius.circular(30.0),
                                ),
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ) ??
        false;
  }

  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    if (!snapshot.hasData) {
      return ListView.builder(
          itemCount: 10,
          // Important code
          itemBuilder: (context, index) => Shimmer.fromColors(
              baseColor: Colors.grey[400],
              highlightColor: Colors.white,
              child: Container(
                height: ScreenUtil().setHeight(320),
                child: Card(
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    )),
              )));
    } else {
      return ListView.builder(
        physics: new BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          var fish_type;
          if (items[index].status.toString() == "2" ||
              items[index].status.toString() == "3") {
            if (items[index].harvest.fishTypeId == 1) {
              fish_type = "Ikan Lele";
            } else if (items[index].harvest.fishTypeId == 2) {
              fish_type = "Ikan Nila";
            } else {
              fish_type = "Ikan Mas";
            }
          }
          return InkWell(
              onTap: () {
                check_database(items[index].id);
                if (items[index].status.toString() == "0") {
                  if (!statusAktivasi) {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          AlertquestionAktivasi(context),
                    );
                  } else {
                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade,
                            child: TambahKolam(
                              idKolam: items[index].id.toString(),
                            )));
                  }
                } else if (items[index].status.toString() == "1") {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: MenuScreen(
                            idKolam: items[index].id.toString(),
                          )));
                } else {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: DetailKolam(
                            // page: 0,
                            idIkan: items[index].harvest.fishTypeId.toString(),
                            idKolam: items[index].id.toString(),
                          )));
                }
              },
              child: Container(
                child: items[index].harvest == null
                    ? CardKolam(
                        context,
                        items[index].name,
                        "Kolam Belum di tentukan",
                        !statusAktivasi ? "-1" : items[index].status.toString(),
                        "0",
                        0,
                        0)
                    : CardKolam(
                        context,
                        items[index].name,
                        fish_type,
                        !statusAktivasi ? "-1" : items[index].status.toString(),
                        items[index].harvest.currentSr.toString() + " %",
                        int.parse(items[index]
                            .harvest
                            .feedConversionRatio
                            .toString()),
                        int.parse(
                            items[index].harvest.currentAmount.toString())),
              ));
        },
      );
    }
  }
}

Widget AlertquestionAktivasi(BuildContext context) {
  final Widget data = Container(
    child: Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      elevation: 0.0,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Akun anda belum di aktivasi , silahkan aktivasi akun anda terlebih dahulu",
              style: TextStyle(
                  color: blackTextColor,
                  fontFamily: 'poppins',
                  letterSpacing: 0.25,
                  fontSize: 15.sp),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Container(
                    height: 35.h,
                    margin: EdgeInsets.only(top: SizeConfig.blockVertical * 3),
                    child: CustomElevation(
                        height: 35.h,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: colorPrimary,
                          onPressed: () => {
                            // Navigator.push(
                            //     context,
                            //     PageTransition(
                            //         type: PageTransitionType.fade,
                            //         child: BiodataScreen(
                            //           from: "dashboard",
                            //         )))

                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: BiodataScreen(
                                      from: "dashboard",
                                    )))
                          },
                          child: Text(
                            "Ya",
                            style: TextStyle(
                                color: backgroundColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                                letterSpacing: 1.25,
                                fontSize: 20.sp),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))),
                Container(
                  height: 35.h,
                  margin: EdgeInsets.only(top: SizeConfig.blockVertical * 3),
                  child: CustomElevation(
                      height: 35.h,
                      child: RaisedButton(
                        highlightColor: colorPrimary,
                        //Replace with actual colors
                        color: redTextColor,
                        onPressed: () => {Navigator.pop(context, true)},
                        child: Text(
                          "Tidak",
                          style: TextStyle(
                              color: backgroundColor,
                              fontWeight: FontWeight.w500,
                              fontFamily: 'poppins',
                              letterSpacing: 1.25,
                              fontSize: 20.sp),
                        ),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                      )),
                ),
              ],
            )
          ],
        ),
      ),
    ),
  );
  return data;
}
