import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/models/ListSellModels.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualLanding.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/jual/JualScreenAdma.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class JualScreen extends StatefulWidget {
  final String idKolam;

  const JualScreen({Key key, @required this.idKolam}) : super(key: key);

  @override
  _JualScreenState createState() => _JualScreenState();
}

class _JualScreenState extends State<JualScreen> {
  bool _clickForgot = true;
  bool isSwitched = false;
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  String base64ImageProduk;
  File _imageProduk;
  TextEditingController namaProdukController = TextEditingController();
  TextEditingController beratProdukController = TextEditingController();
  TextEditingController hargaProdukController = TextEditingController();
  TextEditingController descProdukController = TextEditingController();
  TextEditingController stockProdukController = TextEditingController();
  double _value = 0;
  double _max = 0;
  int last_stock = 0;
  int harvest_id= 0;
  void update() async {

    var jual   =  lelang.bloc.getJualMarket();
    await jual.then((value) {
      value.forEach((element) {
        setState(() {
          last_stock += element.stock;
        });
      });
    });

    await lelang.bloc.getHistoryLelang().then((value) {
      value.forEach((element) {
        setState(() {
          if(element.winnerId != "0" || element.winnerId == null)last_stock += int.parse(element.quantity);
        });
      });
    });

    var detail = await kolam.bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];
    var last  = ((int.parse(data['harvest']['current_weight']) * int.parse(data['harvest']['current_amount'])) / 1000) - last_stock.toDouble();
    setState(() {
      _max = last<=0?0:last;
      harvest_id = data['harvest']['id'];
    });

    debugPrint("last_stock = ${last}");
  }
  void _toggleButton() async {
    if (base64ImageProduk != null) {
      LoadingDialog.show(context);
      var status = await lelang.bloc.addJualMarket(
          namaProdukController.text.toString(),
          hargaProdukController.text.toString(),
          descProdukController.text.toString(),
          beratProdukController.text.toString(),
          "1",
          base64ImageProduk,
          stockProdukController.text.toString(),
          harvest_id.toString()
      );
      AppExt.popScreen(context);
      if (status[0]) {
        BottomSheetFeedback.show_success(
            context, title: "Selamat", description: "Penjualan anda berhasil");

        Timer(const Duration(seconds: 1), () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType
                      .fade,
                  child: LaporanMain(
                    idKolam: widget
                        .idKolam
                        .toString(),
                    page: 2,
                    laporan_page:
                    "jual",
                  )));
        });
      } else {
        AppExt.popScreen(context);
        BottomSheetFeedback.show(context,
            title: "Mohon Maaf", description: "${status[1]}");
      }
    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
    }
  }

  _imgFromCamera() async {
    File image;
    try {
      image = await ImagePicker.pickImage(
          source: ImageSource.camera, imageQuality: 50);
    } catch (e) {
      print(e);
    }

    setState(() {
      base64ImageProduk = image.path;
      _imageProduk = image;
    });
  }

  _imgFromGallery() async {
    File image = await ImagePicker.pickImage(
        source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      base64ImageProduk = image.path;
      _imageProduk = image;
    });
  }

  @override
  void initState() {

    super.initState();
    update();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil()
      ..init(context);
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: WillPopScope(
            onWillPop: _onBackPressed,
            child: Scaffold(
              backgroundColor: Colors.white,
              // resizeToAvoidBottomInset: false,
              body: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    child: Image.asset(
                      "assets/png/header_laporan.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height:200.h,
                    ),
                  ),
                  ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        color: Colors.transparent,
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(20),
                            top: 10.h),
                        child: IconButton(
                          icon: Icon(
                            Icons.arrow_back,
                            color: Colors.black,
                            size:25.sp,
                          ),
                          onPressed: () => {
                            Navigator.push(
                                context,
                                PageTransition(
                                    type: PageTransitionType
                                        .fade,
                                    child: LaporanMain(
                                      page: 2,
                                      laporan_page: "home",
                                      idKolam: widget.idKolam,
                                    )))
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: ScreenUtil().setHeight(10),
                            right: ScreenUtil().setWidth(200)),
                        child: Text(
                          "Jual Hasil Panen ",
                          style: h3.copyWith(color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontSize: 25.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            bottom: ScreenUtil().setHeight(100),
                            right: ScreenUtil().setWidth(200)),
                        child: Text(
                          "Jual hasil panen ikanmu agar anda segera mendapat keuntungan !",
                          style: caption.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,
                              fontSize: 20.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Nama Produk",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 25.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 1,
                            right: ScreenUtil().setWidth(100)),
                        child: TextFormField(
                          controller: namaProdukController,
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0,
                              0),
                          keyboardType: TextInputType.text,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 20.sp),
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       left: ScreenUtil().setWidth(100),
                      //       top: SizeConfig.blockVertical * 2,
                      //       right: ScreenUtil().setWidth(100)),
                      //   child: Text(
                      //     "Kategori",
                      //     style: TextStyle(
                      //         color: appBarTextColor,
                      //         fontFamily: 'lato',
                      //         letterSpacing: 0.4,
                      //         fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       left: ScreenUtil().setWidth(100),
                      //       top: SizeConfig.blockVertical * 1,
                      //       right: ScreenUtil().setWidth(100)),
                      //   child: TextFormField(
                      //     controller: feedConvController,
                      //     decoration: EditTextDecorationText(
                      //         context, "1", 20.0, 0, 0, 0),
                      //     keyboardType: TextInputType.number,
                      //     style: TextStyle(
                      //         color: blackTextColor,
                      //         fontFamily: 'lato',
                      //         letterSpacing: 0.4,
                      //         fontSize: 20.sp),
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 2,
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Jumlah Ikan Per Kilo",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 25.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 1,
                            right: ScreenUtil().setWidth(100)),
                        child: TextFormField(
                          controller: beratProdukController,
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 20.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 2,
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Jumlah Stock (Kilogram)",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 25.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 1,
                            right:ScreenUtil().setWidth(100)),
                        child: Row(
                          children: [
                            Flexible(
                                flex: 3,
                                child: SizedBox(
                                  child: Column(
                                    children: [
                                      SliderTheme(
                                        data:  SliderThemeData(
                                            thumbColor: colorPrimary,
                                            activeTrackColor: colorPrimary,
                                            inactiveTrackColor: Colors.purple[50],
                                            thumbShape: RoundSliderThumbShape(enabledThumbRadius: 10)),
                                        child:Slider(
                                          min: 0,
                                          max: _max,
                                          value: _value,
                                          label: _value.toString(),
                                          // divisions: 15,
                                          onChanged: (value) {
                                            setState(() {
                                              _value = value;
                                              stockProdukController.text =
                                                  value.floor().toStringAsFixed(0);
                                            });
                                          },
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(
                                              left: SizeConfig.blockVertical * 3,),
                                            child: Text(
                                              '0',
                                              style: TextStyle(
                                                  color: appBarTextColor,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: 25.sp),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                              right: SizeConfig.blockVertical * 3,),
                                            child: Text(
                                              '${_max.floor().toStringAsFixed(0)}',
                                              style: TextStyle(
                                                  color: appBarTextColor,
                                                  fontFamily: 'lato',
                                                  letterSpacing: 0.4,
                                                  fontSize: 25.sp),
                                            ),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                )),
                            Flexible(
                                child: SizedBox(
                                  width: 100,
                                  child: Container(
                                    alignment: Alignment.center,
                                    child: TextFormField(
                                      readOnly: true,
                                      textAlign: TextAlign.center,
                                      controller: stockProdukController,
                                      decoration: EditTextDecorationText(
                                          context, "", 0.0, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          if(double.parse(value) > _max){
                                            debugPrint("kena ini");
                                            try {
                                              if(int.parse(value) >= 0 && int.parse(value) <= _max) {
                                                stockProdukController.text = value;
                                              }else{
                                                stockProdukController.text = _max.toString();
                                              }
                                            } catch (e) {
                                              stockProdukController.text = _max.toString();
                                            }
                                          }else{
                                            _value = double.parse(value);
                                          }
                                        });
                                      },
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 2,
                            right: ScreenUtil().setWidth(100)),
                        child: Text(
                          "Harga per 1 Kg",
                          style: TextStyle(
                              color: appBarTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 25.sp),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 1,
                            right: ScreenUtil().setWidth(100)),
                        child: TextFormField(
                          controller: hargaProdukController,
                          decoration: EditTextDecorationText(
                              context, "", 20.0, 0, 0, 0),
                          keyboardType: TextInputType.number,
                          style: TextStyle(
                              color: blackTextColor,
                              fontFamily: 'lato',
                              letterSpacing: 0.4,
                              fontSize: 20.sp),
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 2,
                            right: ScreenUtil().setWidth(100)),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Deskripsi Produk",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: 25.sp),
                                )),
                            Container(
                                padding: EdgeInsets.all(
                                    SizeConfig.blockVertical * 2),
                                height: 150.0,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius
                                      .circular(20),
                                  color: Colors.grey[100],
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey[100],
                                        spreadRadius: 0.4),
                                  ],
                                ),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockVertical *
                                        2),
                                alignment: Alignment.centerLeft,
                                child: TextField(
                                  controller: descProdukController,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontFamily: 'poppins',
                                      letterSpacing: 1.25,
                                      fontSize: 20.sp),
                                  maxLines: 8,
                                  decoration: InputDecoration
                                      .collapsed(
                                      hintText: ""),
                                ))
                          ],
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(100),
                            top: SizeConfig.blockVertical * 2,
                            right: ScreenUtil().setWidth(100)),
                        child: Column(
                          children: [
                            Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "Foto Produk",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontFamily: 'lato',
                                      letterSpacing: 0.4,
                                      fontSize: 25.sp),
                                )),
                            Container(
                                height: ScreenUtil().setHeight(500),
                                margin: EdgeInsets.only(
                                    top: SizeConfig.blockVertical *
                                        2),
                                alignment: Alignment.centerLeft,
                                child: InkWell(
                                  onTap: () {
                                    _showPicker(context);
                                  },
                                  child:
                                  roundedRectBorderWidget(
                                      context, _imageProduk),
                                ))
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       left: ScreenUtil().setWidth(100),
                      //       top: ScreenUtil().setHeight(10),
                      //       right: ScreenUtil().setWidth(100)),
                      //   child: Row(
                      //     children: [
                      //       Transform.scale( scale: 1.5,
                      //         child: Switch(
                      //           value: isSwitched,
                      //           onChanged: (value) {
                      //             setState(() {
                      //               isSwitched = value;
                      //               print(isSwitched);
                      //             });
                      //           },
                      //           activeTrackColor: colorPrimary,
                      //           activeColor: Colors.white,
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(
                      //             left: ScreenUtil().setWidth(30),),
                      //         child: Text(
                      //           "Channel distribusi",
                      //           style: caption.copyWith(
                      //               color: Colors.grey,
                      //               fontWeight: FontWeight.w700),
                      //           textAlign: TextAlign.start,
                      //         ),
                      //       ),
                      //
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       left: ScreenUtil().setWidth(100),
                      //       top: ScreenUtil().setHeight(20),
                      //       right: ScreenUtil().setWidth(100)),
                      //   child: Text(
                      //     "Fee / Kg",
                      //     style: TextStyle(
                      //         color: appBarTextColor,
                      //         fontFamily: 'lato',
                      //         letterSpacing: 0.4,
                      //         fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.only(
                      //       left: ScreenUtil().setWidth(100),
                      //       top: SizeConfig.blockVertical * 1,
                      //       right: ScreenUtil().setWidth(100)),
                      //   child: TextFormField(
                      //     enabled: isSwitched,
                      //     controller: survivalRateController,
                      //     decoration: EditTextDecorationText(
                      //         context, "Nama Produk", 20.0, 0, 0, 0),
                      //     keyboardType: TextInputType.number,
                      //     style: TextStyle(
                      //         color: blackTextColor,
                      //         fontFamily: 'lato',
                      //         letterSpacing: 0.4,
                      //         fontSize: 20.sp),
                      //   ),
                      // ),
                      Container(
                          margin: EdgeInsets.only(bottom: 20.0),
                          child: new Align(
                              alignment: FractionalOffset
                                  .bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment
                                    .end,
                                children: [
                                  Container(
                                    height: 45.h,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(
                                            100),
                                        right: ScreenUtil()
                                            .setWidth(100),
                                        top: 20.0),
                                    child: CustomElevation(
                                        height: 30.h,
                                        child: RaisedButton(
                                          highlightColor: colorPrimary,
                                          //Replace with actual colors
                                          color: _clickForgot
                                              ? colorPrimary
                                              : editTextBgColor,
                                          onPressed: () =>
                                              showDialog(
                                                context: context,
                                                builder:
                                                    (
                                                    BuildContext context) =>
                                                    AlertMessage(
                                                        context),
                                              ),
                                          child: Text(
                                            "SIMPAN PRODUK",
                                            style: TextStyle(
                                                color: _clickForgot
                                                    ? backgroundColor
                                                    : blackTextColor,
                                                fontWeight: FontWeight
                                                    .w700,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: 20.sp),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius
                                                .circular(
                                                30.0),
                                          ),
                                        )),
                                  ),
                                  Container(
                                    height: 45.h,
                                    width:
                                    MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        left: ScreenUtil().setWidth(
                                            100),
                                        right: ScreenUtil()
                                            .setWidth(100),
                                        top: 15.0),
                                    child: CustomElevation(
                                        height: 30.h,
                                        child: RaisedButton(
                                          highlightColor: redTextColor,
                                          //Replace with actual colors
                                          color: _clickForgot
                                              ? redTextColor
                                              : editTextBgColor,
                                          onPressed: () =>
                                          {
                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType
                                                        .fade,
                                                    child: LaporanMain(
                                                      idKolam: widget
                                                          .idKolam
                                                          .toString(),
                                                      page: 1,
                                                      laporan_page:
                                                      "jual",
                                                    )))
                                          },
                                          // _toggleButtonForgot(),
                                          child: Text(
                                            "BATAL",
                                            style: TextStyle(
                                                color: _clickForgot
                                                    ? backgroundColor
                                                    : blackTextColor,
                                                fontWeight: FontWeight
                                                    .w700,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: 20.sp),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius
                                                .circular(
                                                30.0),
                                          ),
                                        )),
                                  ),
                                ],
                              ))),
                    ],
                  )
                ],
              ),
            )));
  }


  Future<bool> _onBackPressed() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: LaporanMain(
              idKolam: widget
                  .idKolam
                  .toString(),
              page: 2,
              laporan_page:
              "jual",
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
                "Apakah anda yakin",
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
                      height: 40.h,
                      margin: EdgeInsets.only(
                          top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 40.h,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () =>
                            {
                              _toggleButton()
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
                    height: 40.h,
                    margin: EdgeInsets.only(
                        top: SizeConfig.blockVertical * 3),
                    child: CustomElevation(
                        height: 40.h,
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

  Widget roundedRectBorderWidget(BuildContext context, File _image) {
    return DottedBorder(
      color: greyLineColor,
      dashPattern: [8, 4],
      strokeWidth: 2,
      strokeCap: StrokeCap.round,
      borderType: BorderType.RRect,
      radius: Radius.circular(12),
      child: ClipRRect(
        borderRadius: BorderRadius.all(Radius.circular(12)),
        child: Container(
          height: ScreenUtil().setHeight(800),
          width: MediaQuery
              .of(context)
              .size
              .width,
          color: Colors.grey[100],
          child: _image != null
              ? Image.file(
            _image,
            fit: BoxFit.fill,
            height: 100.0,
          )
              : Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                FontAwesomeIcons.upload,
                color: Colors.grey[400],
                size: 26.0,
              ),
              Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Text(
                    "Unggah Gambar",
                    style: TextStyle(
                        color: Colors.grey[600],
                        fontWeight: FontWeight.w500,
                        fontFamily: 'poppins',
                        letterSpacing: 1.25,
                        fontSize: 15.0),
                  ))
            ],
          ),
        ),
      ),
    );
  }


  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              height: 120.h,
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              child: new Row(
                children: <Widget>[
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _imgFromGallery();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.image,
                            color: colorPrimary,
                            size: 50,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Galeri",
                            style:
                            caption.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _imgFromCamera();
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            FontAwesome.camera,
                            color: colorPrimary,
                            size: 50,
                          ),
                          SizedBox(height: 5),
                          Text(
                            "Camera",
                            style:
                            caption.copyWith(fontWeight: FontWeight.w700),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

}

