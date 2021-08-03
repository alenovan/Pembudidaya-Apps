import 'dart:async';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lelenesia_pembudidaya/src/Models/SqliteDataPenentuanPanen.dart';
import 'package:lelenesia_pembudidaya/src/helper/DbHelper.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/PenentuanPakanView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/kolam/menu/menu_screen.dart';
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
import 'package:dotted_border/dotted_border.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:flutter_screenutil/flutter_screenutil.dart' as fltr;
class PenentuanPanenView extends StatefulWidget {
  final String idKolam;
  final String idIkan;

  const PenentuanPanenView({Key key, @required this.idKolam, this.idIkan}) : super(key: key);

  @override
  _PenentuanPanenViewState createState() => _PenentuanPanenViewState();
}

class _PenentuanPanenViewState extends State<PenentuanPanenView> {
  bool _clickForgot = true;
  final format = DateFormat("yyyy-MM-dd HH:mm:ss");
  DbHelper _dbHelper;
  var dataPenentuan;

  void getData() async {
    dataPenentuan = await _dbHelper.select(int.parse(widget.idKolam));
    tglTebarController.text = dataPenentuan["sow_date"].toString();
    hargaBibitController.text = dataPenentuan["seed_price"].toString() == "0"
        ? null
        : dataPenentuan["seed_price"].toString();
    jumlahBibitController.text = dataPenentuan["seed_amount"].toString() == "0"
        ? null
        : dataPenentuan["seed_amount"].toString();
    gramPerEkorController.text = dataPenentuan["seed_weight"].toString() == "0"
        ? null
        : dataPenentuan["seed_weight"].toString();
    survivalRateController.text =
        dataPenentuan["survival_rate"].toString() == "0"
            ? null
            : dataPenentuan["survival_rate"].toString();
    feedConvController.text =
        dataPenentuan["feed_conversion_ratio"].toString() == "0"
            ? null
            : dataPenentuan["feed_conversion_ratio"].toString();
    targetJumlahController.text =
        dataPenentuan["target_fish_count"].toString() == "0"
            ? null
            : dataPenentuan["target_fish_count"].toString();
    targetHargaController.text = dataPenentuan["target_price"].toString() == "0"
        ? null
        : dataPenentuan["target_price"].toString();
  }

  @override
  void initState() {
    _dbHelper = DbHelper.instance;
    getData();
    super.initState();
  }

  var _tebarBibit = "-",
      _hargaBibit = "-",
      _jumlahBibit = "-",
      _gramPerEkor = "-",
      _survivalRate = "-",
      _fcr = "-",
      _tagetJumlah = "-",
      _targetHarga = "-";

  void updateSqlite() async {
    var data = SqliteDataPenentuanPanen(
        int.parse(widget.idKolam),
        int.parse(widget.idIkan),
        tglTebarController.text.toString(),
        int.parse(jumlahBibitController.text.toString() == null
            ? "0"
            : jumlahBibitController.text.toString()),
        double.parse(gramPerEkorController.text.toString() == null
            ? "0"
            : gramPerEkorController.text.toString()),
        int.parse(hargaBibitController.text.toString() == null
            ? "0"
            : hargaBibitController.text.toString()),
        int.parse(survivalRateController.text.toString() == null
            ? "0"
            : survivalRateController.text.toString()),
        int.parse(feedConvController.text.toString() == null
            ? "0"
            : feedConvController.text.toString()),
        0,
        int.parse(targetJumlahController.text.toString() == null
            ? "0"
            : targetJumlahController.text.toString()),
        int.parse(targetHargaController.text.toString() == null
            ? "0"
            : targetHargaController.text.toString()),
        0);
    var update = await _dbHelper.update(data);
   try{
     if (update == 1) {
       AppExt.popScreen(context);
       BottomSheetFeedback.show_success(context,
           title: "Selamat", description: "Penentuan Panen Berhasil");
       Timer(const Duration(seconds: 2), () {
         Navigator.push(
             context,
             PageTransition(
                 type: PageTransitionType.fade,
                 child: PenentuanPakanView(
                   idKolam: widget.idKolam,
                 )));
       });
     } else {
       AppExt.popScreen(context);
       BottomSheetFeedback.show(context,
           title: "Mohon Maaf", description: "Silahkan ulangi kembali");
     }
   }catch(e){
     AppExt.popScreen(context);
     BottomSheetFeedback.show(context,
         title: "Mohon Maaf", description: "Silahkan ulangi kembali");
   }
  }

  void _buttonPenentuan() async {
    LoadingDialog.show(context);
    if (jumlahBibitController.text.length <= 0 &&
        gramPerEkorController.text.length <= 0 &&
        hargaBibitController.text.length <= 0 &&
        targetJumlahController.text.length <= 0 &&
        targetHargaController.text.length <= 0 ) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context,
          title: "Mohon Maaf", description: "Pastikan data terisi semua");
    } else {
      updateSqlite();
    }
  }

  Future<File> imageFile;

  //Open gallery
  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  TextEditingController tglTebarController = TextEditingController();
  TextEditingController hargaBibitController = TextEditingController();
  TextEditingController jumlahBibitController = TextEditingController();
  TextEditingController gramPerEkorController = TextEditingController();
  TextEditingController survivalRateController = TextEditingController();
  TextEditingController feedConvController = TextEditingController();
  TextEditingController targetJumlahController = TextEditingController();
  TextEditingController targetHargaController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                      height: 200.h,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      AppBarContainer(context, "", MenuScreen(),
                          Colors.transparent),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(90),
                            top: ScreenUtil().setHeight(20),
                            right: ScreenUtil().setWidth(40)),
                        child:  Text(
                          "Penentuan Panen",
                          style: h3.copyWith(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(
                            left: ScreenUtil().setWidth(90),
                            bottom: ScreenUtil().setHeight(90),
                            right:ScreenUtil().setWidth(90)),
                        child: Text(
                          "Tentukan Berapa SR,FCR, dan Harga target anda !",
                          style: caption.copyWith(
                              color: Colors.grey,
                              fontWeight: FontWeight.w700,fontSize: 19.sp),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Expanded(
                          child: SingleChildScrollView(
                              physics: new BouncingScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil().setHeight(20),
                                        left: SizeConfig.blockVertical * 5,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Tanggal Tebar Bibit",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Theme(
                                      data: ThemeData(primarySwatch: Colors.lightBlue),
                                      child: Builder(
                                          builder: (context) => Container(
                                            margin: EdgeInsets.only(
                                                left: SizeConfig.blockVertical *
                                                    5,
                                                top: SizeConfig.blockVertical *
                                                    1,
                                                right:
                                                SizeConfig.blockVertical *
                                                    5),
                                            child: DateTimeField(
                                              controller: tglTebarController,
                                              decoration:
                                              EditTextDecorationText(
                                                  context,
                                                  "Pilih Tanggal Tebar",
                                                  10.w,
                                                  0,
                                                  0,
                                                  0),
                                              keyboardType:
                                              TextInputType.number,
                                                style: TextStyle(
                                                    color: blackTextColor,
                                                    fontFamily: 'lato',
                                                    letterSpacing: 0.4,
                                                    fontSize: 19.sp),
                                              format: format,
                                              onShowPicker: (context,
                                                  currentValue) async {
                                                final date =
                                                await showDatePicker(
                                                    context: context,
                                                    firstDate:
                                                    DateTime(1900),
                                                    initialDate:
                                                    currentValue ??
                                                        DateTime.now(),
                                                    lastDate:
                                                    DateTime(2100));
                                                if (date != null) {
                                                  final time =
                                                  await showTimePicker(
                                                    context: context,
                                                    initialTime:
                                                    TimeOfDay.fromDateTime(
                                                        currentValue ??
                                                            DateTime.now()),
                                                  );
                                                  return DateTimeField.combine(
                                                      date, time);
                                                } else {
                                                  return currentValue;
                                                }
                                              },
                                            ),
                                          ))),
                                  Visibility(
                                    visible: _tebarBibit == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _tebarBibit,
                                        style: TextStyle(
                                            color: blackTextColor,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 19.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Harga Bibit (Rupiah/Ekor)",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: hargaBibitController,
                                      decoration: EditTextDecorationText(
                                          context, "Harga Bibit", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _hargaBibit == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _hargaBibit,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Jumlah Bibit (ekor)",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: jumlahBibitController,
                                      decoration: EditTextDecorationText(
                                          context, "Jumlah bibit", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _jumlahBibit == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _jumlahBibit,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 12.0),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Berat Benih per Ekor",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: gramPerEkorController,
                                      decoration: EditTextDecorationText(
                                          context, "Berat Ikan", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _gramPerEkor == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _gramPerEkor,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 19.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Survival Rate (%)",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: survivalRateController,
                                      decoration: EditTextDecorationText(
                                          context, "85", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Feed Conv Ratio (FCR)",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: feedConvController,
                                      decoration: EditTextDecorationText(
                                          context, "1", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Target jumlah panen per Kilogram (ekor)",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: targetJumlahController,
                                      decoration: EditTextDecorationText(context,
                                          "Target Jumlah panen", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _tagetJumlah == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _tagetJumlah,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 19.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 2,
                                        right: SizeConfig.blockVertical * 5),
                                    child: Text(
                                      "Target harga panen per Kilogram",
                                      style: TextStyle(
                                          color: appBarTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Container(
                                    margin: EdgeInsets.only(
                                        left: SizeConfig.blockVertical * 5,
                                        top: SizeConfig.blockVertical * 1,
                                        right: SizeConfig.blockVertical * 5),
                                    child: TextFormField(
                                      controller: targetHargaController,
                                      decoration: EditTextDecorationText(context,
                                          "Target harga panen", 10.w, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      style: TextStyle(
                                          color: blackTextColor,
                                          fontFamily: 'lato',
                                          letterSpacing: 0.4,
                                          fontSize: 19.sp),
                                    ),
                                  ),
                                  Visibility(
                                    visible: _targetHarga == "-" ? false : true,
                                    child: Container(
                                      margin: EdgeInsets.only(
                                          left: SizeConfig.blockVertical * 7,
                                          top: SizeConfig.blockVertical * 1,
                                          right: SizeConfig.blockVertical * 3),
                                      child: Text(
                                        _targetHarga,
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: 19.sp),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      margin: EdgeInsets.only(bottom: 10.w),
                                      child: new Align(
                                          alignment: FractionalOffset.bottomCenter,
                                          child: Column(
                                            mainAxisAlignment:
                                            MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                height: 45.h,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockVertical *
                                                        5,
                                                    right:
                                                    SizeConfig.blockVertical *
                                                        5,
                                                    top: 10.w),
                                                child: CustomElevation(
                                                    height: 30.h,
                                                    child: RaisedButton(
                                                      highlightColor: colorPrimary,
                                                      //Replace with actual colors
                                                      color: _clickForgot
                                                          ? colorPrimary
                                                          : editTextBgColor,
                                                      onPressed: () => showDialog(
                                                        context: context,
                                                        builder: (BuildContext
                                                        context) =>
                                                            AlertMessage(context),
                                                      ),
                                                      child: Text(
                                                        "Tentukan Pakan",
                                                        style: TextStyle(
                                                            color: _clickForgot
                                                                ? backgroundColor
                                                                : blackTextColor,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: 'poppins',
                                                            letterSpacing: 1.25,
                                                            fontSize: 19.sp),
                                                      ),
                                                      shape:
                                                      new RoundedRectangleBorder(
                                                        borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                      ),
                                                    )),
                                              ),
                                              Container(
                                                height: 45.h,
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.only(
                                                    left: SizeConfig.blockVertical *
                                                        5,
                                                    right:
                                                    SizeConfig.blockVertical *
                                                        5,
                                                    top: 15.0),
                                                child: CustomElevation(
                                                    height: 30.h,
                                                    child: RaisedButton(
                                                      highlightColor: redTextColor,
                                                      //Replace with actual colors
                                                      color: _clickForgot
                                                          ? redTextColor
                                                          : editTextBgColor,
                                                      onPressed: () => {
                                                        Navigator.push(
                                                            context,
                                                            PageTransition(
                                                                type:
                                                                PageTransitionType
                                                                    .fade,
                                                                child:
                                                                DashboardView()))
                                                      },
                                                      // _toggleButtonForgot(),
                                                      child: Text(
                                                        "Batal",
                                                        style: TextStyle(
                                                            color: _clickForgot
                                                                ? backgroundColor
                                                                : blackTextColor,
                                                            fontWeight:
                                                            FontWeight.w500,
                                                            fontFamily: 'poppins',
                                                            letterSpacing: 1.25,
                                                            fontSize: 19.sp),
                                                      ),
                                                      shape:
                                                      new RoundedRectangleBorder(
                                                        borderRadius:
                                                        new BorderRadius
                                                            .circular(30.0),
                                                      ),
                                                    )),
                                              ),
                                            ],
                                          )))
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
            type: PageTransitionType.rightToLeft, child: DashboardView()));
  }

  Widget AlertMessage(BuildContext context) {
    final Widget data = Container(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.w),
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
                      height: 35.h,
                      margin:
                          EdgeInsets.only(top: SizeConfig.blockVertical * 3),
                      child: CustomElevation(
                          height: 35.h,
                          child: RaisedButton(
                            highlightColor: colorPrimary,
                            //Replace with actual colors
                            color: colorPrimary,
                            onPressed: () => {_buttonPenentuan()},
                            child: Text(
                              "Ya",
                              style: TextStyle(
                                  color: backgroundColor,
                                  fontWeight: FontWeight.w500,
                                  fontFamily: 'poppins',
                                  letterSpacing: 1.25,
                                  fontSize: 19.sp),
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
                                fontSize: 19.sp),
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

  Widget showImage() {
    print("di click");
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 300,
            height: 300,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
}

Widget roundedRectBorderWidget(BuildContext context) {
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
        height: 125,
        width: MediaQuery.of(context).size.width,
        color: Colors.grey[100],
        child: Column(
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
