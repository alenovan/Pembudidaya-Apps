import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModels.dart';
import 'package:lelenesia_pembudidaya/src/Models/ListKolamModelsNew.dart';
import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/KolamWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPanenView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/TambahKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/notification/NotificationView.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:toast/toast.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({Key key}) : super(key: key);

  @override
  _DashboardViewState createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
  final GlobalKey<ScaffoldState> _scaffoldKey =
  new GlobalKey<ScaffoldState>();
  DbHelper _dbHelper;
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
  onItemChanged(String query) {
    List<ListKolamModelsNew> dummySearchList = List<ListKolamModelsNew>();
    dummySearchList.addAll(dataKolam);
    if(query.isNotEmpty) {
      List<ListKolamModelsNew> dummyListData = List<ListKolamModelsNew>();

      dummySearchList.forEach((item) {

        if(item.name.toLowerCase().contains(query.toLowerCase())) {
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
  }

  void check_database(int id) async{
    var db = await _dbHelper.select_count(id);
    print(db);
    if(db == 0){
      var  data = SqliteDataPenentuanPanen(
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
                                    tooltip: MaterialLocalizations.of(context)
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
                                context, "Cari Kolam", 20.0, 0, 0, 0,gs),
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
                    height: MediaQuery.of(context).size.height,
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
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: PenentuanPakanView(idKolam: items[index].id.toString(),)));

              } else if(items[index].status.toString() == "1") {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: PenentuanPanenView(idKolam: items[index].id.toString(),)));

              } else {
                Navigator.push(
                    context,
                    PageTransition(
                        type: PageTransitionType.fade,
                        child: LaporanMain(
                          page: 0, laporan_page: "home",idKolam: items[index].id.toString(),)));
              }
            },
            child:Container(
              child:  CardKolam(
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
