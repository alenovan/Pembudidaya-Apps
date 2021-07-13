import 'dart:ffi';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_boxicons/flutter_boxicons.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/bloc/CheckoutBloc.dart' as pakan;
import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:lelenesia_pembudidaya/src/bloc/PakanBloc.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/models/ListPakanModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/checkout/CheckoutView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/DetailKolam.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaText.dart';
import 'package:flutter/services.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shimmer/shimmer.dart';

class DetailPenentuanPakan extends StatefulWidget {
  final String name;
  final int price;
  final double stok;
  final String size; // ukuran
  final String type; // type
  final String desc;
  final String image_url;
  final String idKolam;
  final String idIkan;
  final String nameManufacture;
  final String addressManufacture;
  final String pabrikManufacture;
  final String photoManufacture;
  final int id_pakan;

  DetailPenentuanPakan(
      {Key key,
      this.name,
      this.price,
      this.stok,
      this.desc,
      this.image_url,
      this.idKolam,
      this.id_pakan,
      this.size,
      this.type,
      this.nameManufacture,
      this.addressManufacture,
      this.pabrikManufacture,
      this.photoManufacture, this.idIkan})
      : super(key: key);

  @override
  _DetailPenentuanPakanState createState() => _DetailPenentuanPakanState();
}

class _DetailPenentuanPakanState extends State<DetailPenentuanPakan> {
  bool _clickForgot = true;
  final formatter = new NumberFormat("#,###");
  DbHelper _dbHelper;
  var dataPenentuan;
  var tglTebarController = "";
  var hargaBibitController = 0;
  var jumlahBibitController = 0;
  var gramPerEkorController = 0;
  var survivalRateController = 0;
  var feedConvController = 0;
  var targetJumlahController = 0;
  var targetHargaController = 0;
  var dataCheck;
  var idIkan;
  var items = List<ListPakanModels>();
  List<ListPakanModels> dataPakan = new List();

  void _toggleButtonSave(int statusx) async {
    getData();

    Navigator.of(context).push(new MaterialPageRoute<Null>(
        builder: (BuildContext context) {
          return LoadingShow(context);
        },
        fullscreenDialog: true));
    var data = SqliteDataPenentuanPanen(
        int.parse(widget.idKolam),
        int.parse(idIkan),
        tglTebarController.toString(),
        int.parse(jumlahBibitController.toString()),
        double.parse(gramPerEkorController.toString()),
        int.parse(hargaBibitController.toString()),
        int.parse(survivalRateController.toString()),
        int.parse(feedConvController.toString()),
        widget.id_pakan,
        int.parse(targetJumlahController.toString()),
        int.parse(targetHargaController.toString()),
        0);
    var update = await _dbHelper.update(data);
    if (update == 1) {
      if (statusx == 1) {
        Navigator.of(context).pop();

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: CheckoutView(
                  idKolam: widget.idKolam,
                )));
      } else {
        Navigator.of(context).pop();

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                child: DetailKolam(
                  idKolam: widget.idKolam,
                )));
      }
    } else {
      Navigator.of(context).pop();
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }

  void getData() async {
    dataPenentuan = await _dbHelper.select(int.parse(widget.idKolam));
    setState(() {
      idIkan = dataPenentuan["fish_type_id"].toString();
      dataCheck = dataPenentuan["seed_amount"].toString();
      tglTebarController = dataPenentuan["sow_date"].toString();
      hargaBibitController = dataPenentuan["seed_price"];
      jumlahBibitController = dataPenentuan["seed_amount"];
      gramPerEkorController = dataPenentuan["seed_weight"];
      survivalRateController = dataPenentuan["survival_rate"];
      feedConvController = dataPenentuan["feed_conversion_ratio"];
      targetJumlahController = dataPenentuan["target_fish_count"];
      targetHargaController = dataPenentuan["target_price"];
    });
    getDataPanen();
  }

  void getDataPanen() async {
    // dataPenentuan = await _dbHelper.select(int.parse(widget.idKolam));
    //
    //  pakan.bloc.getFeedDetail(widget.id_pakan.toString()).then((value) {
    //   setState(() {
    //     dataPakan = value;
    //     items.addAll(dataPakan);
    //   });
    // });
  }

  @override
  void initState() {
    super.initState();
    _dbHelper = DbHelper.instance;
    getData();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()..init(context);
    final double _screenWidth = MediaQuery.of(context).size.width;
    if (dataCheck == "0") {
      // getData();
    }
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
            backgroundColor: Colors.grey[100],
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                icon: Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.rightToLeft,
                          child: PenentuanPakanView(
                            idKolam: widget.idKolam,
                          )))
                },
              ),
              backgroundColor: Colors.white,
              brightness: Brightness.light,
              title: Text(
                "Detail Produk",
                style: h3.copyWith(color: Colors.black),
              ),
            ),
            body: ListView(
              children: [

                SizedBox(
                  height: 20,
                ),

                Container(
                  height: 200,
                  child: Container(
                    padding: EdgeInsets.only(top:10.0,bottom:10.0),
                    child: Center(
                      child: Image.network(
                        widget.image_url,
                        fit: BoxFit.fitWidth,
                        errorBuilder: (BuildContext context, Object exception,
                            StackTrace stackTrace) {
                          return Image.network("https://via.placeholder.com/300");
                        },
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 3,
                                right: SizeConfig.blockVertical * 3,
                                top: SizeConfig.blockVertical * 2),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Container(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "Rp.${formatter.format(widget.price)}",
                                          style: subtitle2.copyWith(
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 1.25),
                                        )),
                                    Container(
                                        margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 2,
                                          bottom: 3.0,
                                        ),
                                        child: Row(
                                          children: [
                                            Container(
                                                margin:
                                                    EdgeInsets.only(left: 2.0),
                                                child: Icon(
                                                  Boxicons.bx_dollar_circle,
                                                  color: colorPrimary,
                                                  size: 20,
                                                )),
                                            Container(
                                              margin:
                                                  EdgeInsets.only(left: 3.0),
                                              child: Text(
                                                " Pay Later",
                                                style: caption.copyWith(
                                                    color: colorPrimary,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            )
                                          ],
                                        ))
                                  ],
                                ),
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "${widget.name}",
                                      style: subtitle2.copyWith(
                                          fontSize: ScreenUtil(
                                                  allowFontScaling: false)
                                              .setSp(40)),
                                    )),
                                Container(
                                    padding: EdgeInsets.only(top: 5.0),
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Kota Distribusi : ",
                                      style: subtitle2.copyWith(
                                          color: greyTextColor,
                                          fontSize: ScreenUtil(
                                                  allowFontScaling: false)
                                              .setSp(40)),
                                    )),
                                Container(
                                    transform: Matrix4.translationValues(
                                        -8.0, 00.0, 0.0),
                                    margin: EdgeInsets.only(top: 2.0),
                                    alignment: Alignment.centerLeft,
                                    child: FutureBuilder(
                                      future: pakan.bloc.getFeedDetail(
                                          widget.id_pakan.toString()),
                                      builder: (context,
                                          AsyncSnapshot<dynamic> snapshot) {
                                        if (snapshot.hasData) {
                                          // print(snapshot.data["data"]["manufacturer"]["coverages"].length);
                                          // return Text("${snapshot.data["data"]["manufacturer"]["coverages"].length}");
                                          return snapshot.data["data"]["manufacturer"]["coverages"].isEmpty ? Center(child: Text('')) : Wrap(
                                              spacing: 2.0,
                                              runSpacing: -ScreenUtil().setHeight(20),
                                              children: List<Widget>.generate(snapshot.data["data"]["manufacturer"]["coverages"].length < 1 ?0:snapshot.data["data"]["manufacturer"]["coverages"].length, (int index) {
                                                return Container(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Chip(
                                                    label: Text(
                                                      '${snapshot.data["data"]["manufacturer"]["coverages"][index]["city_name"]}',
                                                      style: TextStyle(
                                                          color: colorPrimary,
                                                          fontSize: ScreenUtil(
                                                              allowFontScaling:
                                                              false)
                                                              .setSp(35)),
                                                    ),
                                                    elevation: 1.0,
                                                    shadowColor:
                                                    Colors.grey[60],
                                                    backgroundColor:
                                                    Colors.transparent,
                                                  ),
                                                );
                                              }));
                                        } else if (snapshot.hasError) {
                                          return Text(
                                              snapshot.error.toString());
                                        }
                                        return Wrap(
                                            spacing: 2.0,
                                            runSpacing: -ScreenUtil().setHeight(20),
                                            children: List<Widget>.generate(2, (int index) {
                                              return Container(
                                                  padding: EdgeInsets.only(
                                                  left: 8.0),
                                              child: Shimmer.fromColors(
                                                  period: Duration(milliseconds: 1000),
                                                  baseColor: Colors.grey[300],
                                                  highlightColor: Colors.white,
                                                  child: Chip(
                                                    label: Text(
                                                      '--------------------------------------',
                                                      style: TextStyle(
                                                          color: colorPrimary,
                                                          fontSize: ScreenUtil(
                                                              allowFontScaling:
                                                              false)
                                                              .setSp(35)),
                                                    ),
                                                    elevation: 1.0,
                                                    shadowColor:
                                                    Colors.grey[60],
                                                    backgroundColor:
                                                    Colors.transparent,
                                                  )));
                                            }));
                                      },
                                    )),
                                SizedBox(
                                  height: 20,
                                )
                              ],
                            ))
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: [
                        Container(
                          height: 90,
                          child: Container(
                              padding: EdgeInsets.only(left: 10.0, right: 15.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                    width: ScreenUtil().setWidth(250),
                                    child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          widget.photoManufacture,
                                          fit: BoxFit.cover,
                                          height:
                                              SizeConfig.blockHorizotal * 17,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Image.network(
                                              widget.photoManufacture,
                                              height:
                                                  SizeConfig.blockHorizotal *
                                                      17,
                                              fit: BoxFit.cover,
                                              frameBuilder: (context,
                                                  child,
                                                  frame,
                                                  wasSynchronouslyLoaded) {
                                                if (wasSynchronouslyLoaded) {
                                                  return child;
                                                } else {
                                                  return AnimatedSwitcher(
                                                    duration: const Duration(
                                                        milliseconds: 500),
                                                    child: frame != null
                                                        ? child
                                                        : Shimmer.fromColors(
                                                            baseColor: Colors
                                                                .grey[300],
                                                            highlightColor:
                                                                Colors
                                                                    .grey[200],
                                                            period: Duration(
                                                                milliseconds:
                                                                    1000),
                                                            child: Container(
                                                              width:
                                                                  _screenWidth *
                                                                      (20 /
                                                                          100),
                                                              height:
                                                                  _screenWidth *
                                                                      (15 /
                                                                          100),
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10),
                                                                  color: Colors
                                                                      .white),
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
                                    child: Container(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              widget.nameManufacture,
                                              overflow: TextOverflow.ellipsis,
                                              style: subtitle2.copyWith(
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 1.25,
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                              false)
                                                      .setSp(40)),
                                            ),
                                          ),
                                          Container(
                                            padding: EdgeInsets.only(left: 10),
                                            child: Text(
                                              widget.addressManufacture,
                                              overflow: TextOverflow.ellipsis,
                                              style: caption.copyWith(
                                                  color: greyTextColor,
                                                  fontSize: ScreenUtil(
                                                          allowFontScaling:
                                                              false)
                                                      .setSp(35)),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                        )
                      ],
                    )),
                Container(
                    margin: EdgeInsets.only(top: SizeConfig.blockVertical * 2),
                    color: Colors.white,
                    width: MediaQuery.of(context).size.width,
                    child: Wrap(
                      children: [
                        Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 3,
                                right: SizeConfig.blockVertical * 3,
                                top: SizeConfig.blockVertical * 2),
                            child: Column(
                              children: [
                                Container(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Info produk",
                                      style: subtitle2.copyWith(
                                          fontWeight: FontWeight.bold),
                                    )),
                                Container(
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Flexible(
                                          child: Container(
                                        margin: EdgeInsets.only(
                                          top: SizeConfig.blockVertical * 2,
                                          right: SizeConfig.blockVertical * 2,
                                        ),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                                child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                      TextSpan(
                                                        text:
                                                            "Jumlah dalam kg : ",
                                                        style: caption,
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            " ${widget.stok} ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'lato',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.25,
                                                            fontSize: 13.0),
                                                      ),
                                                      TextSpan(
                                                        text: "Kg",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'lato',
                                                            letterSpacing: 0.25,
                                                            fontSize: 13.0),
                                                      )
                                                    ]))),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockVertical *
                                                        1),
                                                child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                      TextSpan(
                                                        text: "Ukuran : ",
                                                        style: caption,
                                                      ),
                                                      TextSpan(
                                                        text:
                                                            " ${widget.size} ",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'lato',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.25,
                                                            fontSize: 13.0),
                                                      ),
                                                    ]))),
                                            Container(
                                                margin: EdgeInsets.only(
                                                    top: SizeConfig
                                                            .blockVertical *
                                                        1),
                                                child: RichText(
                                                    textAlign: TextAlign.left,
                                                    text: TextSpan(children: <
                                                        TextSpan>[
                                                      TextSpan(
                                                        text: "Jenis produk : ",
                                                        style: caption,
                                                      ),
                                                      TextSpan(
                                                        text: "${widget.type}",
                                                        style: TextStyle(
                                                            color: Colors.black,
                                                            fontFamily: 'lato',
                                                            fontWeight:
                                                                FontWeight.bold,
                                                            letterSpacing: 0.25,
                                                            fontSize: 13.0),
                                                      ),
                                                    ]))),
                                            SizedBox(
                                              height: 20,
                                            )
                                          ],
                                        ),
                                      ))
                                    ],
                                  ),
                                ),
                              ],
                            ))
                      ],
                    )),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: SizeConfig.blockVertical * 1),
                  child: Column(
                    children: [
                      Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 3,
                              right: SizeConfig.blockVertical * 3,
                              top: SizeConfig.blockVertical * 2),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            "Deskripsi produk",
                            style:
                                subtitle2.copyWith(fontWeight: FontWeight.bold),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              left: SizeConfig.blockVertical * 3,
                              right: SizeConfig.blockVertical * 3,
                              top: SizeConfig.blockVertical * 2),
                          alignment: Alignment.centerLeft,
                          child: Text(
                            widget.desc,
                            style: body2.copyWith(
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(45)),
                          )),
                      Container(
                        height: 45.0,
                        width: MediaQuery.of(context).size.width,
                        margin: EdgeInsets.only(
                            left: SizeConfig.blockVertical * 3,
                            right: SizeConfig.blockVertical * 3,
                            top: SizeConfig.blockVertical * 3),
                        child: CustomElevation(
                            height: 30.0,
                            child: RaisedButton(
                              highlightColor: colorPrimary,
                              //Replace with actual colors
                              color: colorPrimary,
                              onPressed: () => {
                                showDialog(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      AlertMessage(context),
                                )
                              },
                              child: Text(
                                "Pakai Pakan ini",
                                style: TextStyle(
                                    color: Colors.white,
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
                      SizedBox(
                        height: 80,
                      )
                    ],
                  ),
                )
              ],
            )));
  }

  Widget AlertMessage(BuildContext context) {
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
                "apakah anda ingin melakukan pembayaran  ?",
                style: TextStyle(
                    color: blackTextColor,
                    fontFamily: 'poppins',
                    letterSpacing: 0.25,
                    fontSize: 15.0),
                textAlign: TextAlign.center,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                      height: 35.0,
                      margin:
                          EdgeInsets.only(top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 35.0,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () => {_toggleButtonSave(1)},
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
                    margin: EdgeInsets.only(top: SizeConfig.blockVertical * 3),
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
}
