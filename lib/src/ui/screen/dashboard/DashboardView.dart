import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModelsNew.dart';
import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/notification/NotificationView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/profile/aktivasi/BiodataScreen.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;

class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  DbHelper _dbHelper;
  var statusAktivasi = false;
  List<ListKolamModelsNew> dataKolam = new List();
  var items = List<ListKolamModelsNew>();
  TextEditingController _searchBoxController = TextEditingController();

  void fetchData() {
    bloc.fetchAllKolam().then((value) {
      setState(() {
        dataKolam = value;
        items.addAll(dataKolam);
        // dataPakan.addAll(value);

      });
    });
  }

  void cek_profil() async {
    var blox = await profile.bloc.getProfile();
    setState(() {
      statusAktivasi = blox['data']['ktp_photo'].toString() == "null"
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
    super.initState();
    _dbHelper = DbHelper.instance;
    _dbHelper.initDb();
    fetchData();
    cek_profil();
  }

  void check_database(int id) async {
    var db = await _dbHelper.select_count(id);
    print(db);
    if (db == 0) {
      var data = SqliteDataPenentuanPanen(
          id,
          "",
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0,
          0
      );
      _dbHelper.insert(data);
    }
  }

  @override
  void dispose() {
    bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
        resizeToAvoidBottomPadding: false,
        drawer: Drawers(context),
        body: Stack(
          children: [
            new Positioned(
              child: ListView(
                physics: const NeverScrollableScrollPhysics(),
                padding: EdgeInsets.zero,
                children: <Widget>[
                  Container(
                    // color: Colors.red,
                    height: SizeConfig.blockHorizotal * 35,
                    width: double.infinity,
                    child: Stack(
                      children: [
                        Container(
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  margin: EdgeInsets.only(
                                      left: SizeConfig.blockVertical * 3),
                                  child: IconButton(
                                    onPressed: () =>
                                        _scaffoldKey.currentState.openDrawer(),
                                    tooltip: MaterialLocalizations
                                        .of(context)
                                        .openAppDrawerTooltip,
                                    icon: Icon(FontAwesomeIcons.bars,
                                        color: colorPrimary, size: 30.0),
                                  )),
                            )),
                        Container(
                            margin: EdgeInsets.only(
                                right: SizeConfig.blockVertical * 5),
                            child: Align(
                              alignment: Alignment.centerRight,
                              child: Container(
                                  child: IconButton(
                                      onPressed: () =>
                                      {
                                        Navigator.push(
                                            context,
                                            PageTransition(
                                                type: PageTransitionType.fade,
                                                // duration: Duration(microseconds: 1000),
                                                child: NotificationView()))
                                      },
                                      tooltip: "Notifikasi",
                                      icon: Icon(
                                        FontAwesomeIcons.solidBell,
                                        color: colorPrimary,
                                        size: 30.0,
                                      ))),
                            )),
                      ],
                    ),
                  ),
                  Container(
                    transform: Matrix4.translationValues(0.0, -23.0, 0.0),
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 4,
                        right: SizeConfig.blockVertical * 4),
                    child: Column(
                      children: [
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
                                0,
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
                  Container(
                    transform: Matrix4.translationValues(0.0, -20.0, 0.0),
                    margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 4,
                      right: SizeConfig.blockVertical * 4,),
                    height: MediaQuery
                        .of(context)
                        .size
                        .height,
                    child: FutureBuilder(
                      future: bloc.fetchAllKolam(),
                      builder: (context, AsyncSnapshot<dynamic> snapshot) {
                        if (snapshot.hasData) {
                          return buildList(snapshot);
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        return Center(child: CircularProgressIndicator());
                      },
                    ),),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ],
        ));
  }

  Widget buildList(AsyncSnapshot<dynamic> snapshot) {
    return ListView.builder(
      physics: new BouncingScrollPhysics(),
      scrollDirection: Axis.vertical,
      itemCount: items.length,
      itemBuilder: (BuildContext context, int index) {
        return InkWell(
            onTap: () {
              check_database(items[index].id);
              if (items[index].status.toString() == "0") {
                if (!statusAktivasi) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        AlertquestionAktivasi(
                            context),
                  );
                } else {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: TambahKolam(
                            idKolam: items[index].id.toString(),)));
                }
              } else if (items[index].status.toString() == "1") {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: PenentuanPanenView(
                          idKolam: items[index].id.toString(),)));
              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: LaporanMain(
                          page: 0,
                          laporan_page: "home",
                          idKolam: items[index].id.toString(),)));
              //   Navigator.push(
              //       context,
              //       PageTransition(
              //           type: PageTransitionType.fade,
              //           child: CheckoutView(
              //             idKolam: items[index].id.toString(),)));
              }
            },
            child: Container(
              child: CardKolam(
                  context,
                  items[index].name,
                  "Pilih untuk lihat detail",
                  items[index].status.toString()),

            )
        );
      },
    );
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
                  fontSize: 15.0),
              textAlign: TextAlign.center,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                    height: 35.0,
                    margin: EdgeInsets.only(
                        left: SizeConfig.blockVertical * 1,
                        right: SizeConfig.blockVertical * 1,
                        top: SizeConfig.blockVertical * 3),
                    child: CustomElevation(
                        height: 35.0,
                        child: RaisedButton(
                          highlightColor: colorPrimary,
                          //Replace with actual colors
                          color: colorPrimary,
                          onPressed: () =>
                          {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType.fade,
                                    child: BiodataScreen()))
                          },
                          child: Text(
                            "Ya",
                            style: TextStyle(
                                color: backgroundColor,
                                fontWeight: FontWeight.w500,
                                fontFamily: 'poppins',
                                letterSpacing: 1.25,
                                fontSize: subTitleLogin),
                          ),
                          shape: new RoundedRectangleBorder(
                            borderRadius: new BorderRadius.circular(30.0),
                          ),
                        ))),
                Container(
                  height: 35.0,
                  margin: EdgeInsets.only(
                      left: SizeConfig.blockVertical * 1,
                      right: SizeConfig.blockVertical * 1,
                      top: SizeConfig.blockVertical * 3),
                  child: CustomElevation(
                      height: 35.0,
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
                              fontSize: subTitleLogin),
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
