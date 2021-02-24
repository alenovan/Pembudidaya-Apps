import 'dart:ui';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:lelenesia_pembudidaya/src/bloc/ProfilBloc.dart' as profile;
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/models/ListAlamatModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/Alamat/TambahAlamatView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutFix.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/ChekoutReorder.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class ListAlamatPengiriman extends StatefulWidget {
  final String idKolam;
  final String feedId;
  final String idIkan;
  final String from;


  ListAlamatPengiriman(
      {Key key, this.idKolam, this.feedId, this.idIkan, this.from})
      : super(key: key);

  @override
  _ListAlamatPengirimanState createState() => _ListAlamatPengirimanState();
}

class _ListAlamatPengirimanState extends State<ListAlamatPengiriman> {
  var blox;
  var _nama = " ";
  var _alamat = " ";
  var _phone = " ";
  var _selected = false;
  var indexActive;
  var items = List<ListAlamatModels>();
  List<ListAlamatModels> dataAlamat = new List();
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  void fetchData() {
    profile.bloc.fetchAllAlamat().then((value) {
      setState(() {
        dataAlamat = value;
        items.addAll(dataAlamat);
        var i = 0;
        for (var data in items) {
          if(data.isMain == 1){
            indexActive = i;
          }
          i++;
        }
      });
    });
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
  void update() async {
    blox = await profile.bloc.getProfile();
    setState(() {
      _phone = blox['data']['phone_number'].toString() == "null"
          ? " "
          : blox['data']['phone_number'].toString();
      _nama = blox['data']['name'].toString() == "null"
          ? " "
          : blox['data']['name'].toString();
      _alamat = blox['data']['address'].toString() == "null"
          ? " "
          : blox['data']['address'].toString();
    });
  }

  @override
  void initState() {
    fetchData();
    super.initState();
  }


  void _toggleSimpan(id) async {
    var status = await profile.bloc.funSetActiveAddress(id.toString());

  }

  void check_active_alamat(int set){
    print(set);
    setState(() {
      indexActive = set;
    });
  }




  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          resizeToAvoidBottomPadding: false,
          appBar: AppBar(
            centerTitle: true,
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {
                if(widget.from == "reorder"){
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: CheckoutReorder(
                            idKolam: widget.idKolam,
                          )))
                }else{
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade,
                          child: CheckoutView(
                            idKolam: widget.idKolam,
                          )))
                }

              },
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Alamat Pengiriman",
              style: h3,
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Expanded(
                  child: Container(
                    margin: EdgeInsets.only(
                      top: SizeConfig.blockVertical * 1,
                      left: ScreenUtil().setWidth(80),
                      right: ScreenUtil().setWidth(80),
                    ),
                    height: MediaQuery.of(context).size.height,
                    child: FutureBuilder(
                      future: profile.bloc.fetchAllAlamat(),
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
                                  child: Expanded(
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
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                              children: [
                                                Shimmer.fromColors(
                                                  period:
                                                  Duration(milliseconds: 1000),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white,
                                                  child: Container(
                                                    margin: EdgeInsets.only(
                                                        left: 10.0,
                                                        top: 2.0),
                                                    width: 200,
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
                                                        top: 2.0),
                                                    width: 200,
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
                                            Shimmer.fromColors(
                                              period:
                                              Duration(milliseconds: 1000),
                                              baseColor: Colors.grey[300],
                                              highlightColor: Colors.white,

                                              child: Container(
                                                margin: EdgeInsets.only(
                                                    left: 10.0,
                                                    right: 40.0,
                                                    top: 2.0),
                                                width:
                                                ScreenUtil().setWidth(100),
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
                                        )
                                      ],
                                    ),
                                  ),
                                )));
                      },
                    ),
                  )),

            ],
          ),
        ));
  }

  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: CheckoutView(
              idKolam: widget.idKolam,
            )));
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
          return Container(
            padding: EdgeInsets.only(
                left: ScreenUtil().setWidth(20),
                right: ScreenUtil().setWidth(20),
                top: ScreenUtil().setHeight(20)),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      setState(() {
                        indexActive = index;
                        _toggleSimpan(items[index].id);
                      });
                    },
                    child: Wrap(
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              top: SizeConfig.blockVertical * 2),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: Colors.grey[100],
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.grey, spreadRadius: 0.4),
                            ],
                          ),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [

                              Flexible(
                                flex: 4,
                                child:  Container(
                                  margin: EdgeInsets.only(
                                    left: SizeConfig.blockVertical * 3,
                                    top: SizeConfig.blockVertical * 2,
                                    right: SizeConfig.blockVertical * 2,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        items[index].name.toString(),
                                        style: TextStyle(
                                            fontFamily: 'poppins',
                                            letterSpacing: 0.4,
                                            fontWeight: FontWeight.w700,
                                            fontSize: 14.0),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockVertical *
                                                2),
                                        child: Text(
                                          "${items[index].address.toString()} ${items[index].province.name.toString()}  ${items[index].city.name.toString()}   ${items[index].district.name.toString()} ",
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              letterSpacing: 0.4,
                                              fontSize: 13.0),
                                        ),
                                      ),
                                      Container(
                                        margin: EdgeInsets.only(
                                            top: SizeConfig.blockVertical *
                                                2,
                                            bottom:
                                            SizeConfig.blockVertical *
                                                2),
                                        child: Text(
                                          items[index].phoneNumber.toString(),
                                          style: TextStyle(
                                              fontFamily: 'poppins',
                                              letterSpacing: 0.4,
                                              fontSize: 13.0),
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),

                              Flexible(
                                flex: 1,
                                child:   Column(
                                  children: [
                                    Center(
                                      child: Container(
                                        margin: EdgeInsets.only(
                                            right:
                                            SizeConfig.blockVertical *
                                                3),
                                        child: Icon(
                                          index == indexActive ?  Boxicons.bxs_check_circle:Boxicons.bx_circle,
                                          color: purpleTextColor,
                                          size: 30.0,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )
                              ,
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  index == (items.length-1) ? Container(
                      margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
                      width: double.infinity,
                      child: CustomElevation(
                          height: 40.0,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () => {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: TambahAlamatView(
                                        idKolam: widget.idKolam,
                                      )))
                            },
                            child: Text(
                              "Alamat Baru",
                              style: h3.copyWith(color: Colors.white),
                            ),
                            shape: new RoundedRectangleBorder(
                              borderRadius: new BorderRadius.circular(30.0),
                            ),
                          ))): SizedBox(height: 1,)
                ],
              ),
          );
        },
      );
    }
  }
}
