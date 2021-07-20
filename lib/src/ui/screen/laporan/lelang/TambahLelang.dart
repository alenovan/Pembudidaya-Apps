import 'dart:async';

import 'package:intl/intl.dart';
import 'package:datetime_picker_formfield/datetime_picker_formfield.dart';
import 'package:flutter/material.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/LaporanMain.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangHistory.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/AcceptanceDialog.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/login/LoginWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:lelenesia_pembudidaya/src/bloc/KolamBloc.dart' as kolam;
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
class TambahLelang extends StatefulWidget {
  final String idKolam;

  const TambahLelang({Key key, @required this.idKolam}) : super(key: key);

  @override
  _TambahLelangState createState() => _TambahLelangState();
}

class _TambahLelangState extends State<TambahLelang> {
  bool _clickForgot = true;
  double _value = 0;
  double _max = 0.0;
  int harvest_id= 0;
  TextEditingController _maxValue_kilo = TextEditingController();
  TextEditingController _tglStartLelang = TextEditingController();
  TextEditingController _tglEndLelang = TextEditingController();
  TextEditingController _jenisIkanLelang = TextEditingController();
  TextEditingController _jumlahIkanPerEkorLelang = TextEditingController();
  TextEditingController _bukaHargaLelang = TextEditingController();
  int last_stock = 0;

  void update() async {;
    var detail = await kolam.bloc.getKolamDetail(widget.idKolam);
    var data = detail['data'];

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
          if(int.parse(element.winnerId)> 0 || element.winnerId == null)last_stock += int.parse(element.quantity);
        });
      });
    });

  var last  = ((int.parse(data['harvest']['current_weight']) * int.parse(data['harvest']['current_amount'])) / 1000) - last_stock.toDouble();
    debugPrint("last Stvok"+last.toString());
    setState(() {
      _max = last<=0?0:last;
      harvest_id = data['harvest']['id'];
    });

    if(_max<=0){
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Stock habis");
    }
  }


  @override
  void initState() {
    update();
    super.initState();

    // print(_max);
  }
  void _buttonLelang() async {
    LoadingDialog.show(context);
    var status = await lelang.bloc.addlelang(harvest_id.toString(),_jenisIkanLelang.text,_maxValue_kilo.text,_jumlahIkanPerEkorLelang.text,_tglStartLelang.text,_tglEndLelang.text,_bukaHargaLelang.text);
    if(status[0]){
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "${status[1]}");
      Timer(const Duration(seconds: 2), () {
        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade,
                // duration: Duration(microseconds: 1000),
                child: LelangHistory(
                  idKolam: widget.idKolam,
                )));
      });
    }else{
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "${status[1]}");
    }


  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            elevation: 0,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.black),
              onPressed: () => {Navigator.pop(context, true)},
            ),
            actions: <Widget>[],
            backgroundColor: Colors.white,
            brightness: Brightness.light,
            title: Text(
              "Lelang",
              style: h3,
            ),
          ),
          body: Column(
            children: [
              Expanded(
                  child: SingleChildScrollView(
                      physics: new BouncingScrollPhysics(),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 3,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Produk",
                              style: subtitle2.copyWith(
                                  fontWeight: FontWeight.w700,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Jenis Ikan",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              controller: _jenisIkanLelang,
                              decoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.text,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Jumlah Stock (Kilogram)",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
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
                                            _maxValue_kilo.text =
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
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
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
                                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
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
                                      controller: _maxValue_kilo,
                                      decoration: EditTextDecorationText(
                                          context, "", 0.0, 0, 0, 0),
                                      keyboardType: TextInputType.number,
                                      onChanged: (value) {
                                        setState(() {
                                          // if(double.parse(value) > _max){
                                          //   try {
                                          //     if(int.parse(value) >= 0 && int.parse(value) <= _max) {
                                          //       _maxValue_kilo.text = value;
                                          //     }else{
                                          //       _maxValue_kilo.text = _max.toString();
                                          //     }
                                          //   } catch (e) {
                                          //
                                          //   }
                                          // }else{
                                          //   _value = double.parse(value);
                                          // }
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
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Jumlah ikan per Kilogram",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              controller: _jumlahIkanPerEkorLelang,
                              decoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 3,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Lelang",
                              style: subtitle2.copyWith(
                                  fontWeight: FontWeight.w700,fontSize: ScreenUtil(allowFontScaling: false).setSp(50)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Tanggal Mulai Lelang",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: Theme(
                                data: ThemeData(primarySwatch: Colors.blue),
                                child: Builder(
                                    builder: (context) => Container(
                                      child: DateTimeField(
                                        controller: _tglStartLelang,
                                        decoration: EditTextDecorationText(
                                            context, "", 20.0, 0, 0, 0),
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: blackTextColor,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                        format: DateFormat("yyyy-MM-dd HH:mm:ss"),
                                        onShowPicker:
                                            (context, currentValue) async {
                                          final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime(2100));
                                          if (date != null) {
                                            final time = await showTimePicker(
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
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Tanggal Berakhir Lelang",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: Theme(
                                data: ThemeData(primarySwatch: Colors.blue),
                                child: Builder(
                                    builder: (context) => Container(
                                      child: DateTimeField(
                                        controller: _tglEndLelang,
                                        decoration: EditTextDecorationText(
                                            context, "", 20.0, 0, 0, 0),
                                        keyboardType: TextInputType.number,
                                        style: TextStyle(
                                            color: blackTextColor,
                                            fontFamily: 'lato',
                                            letterSpacing: 0.4,
                                            fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                        format: DateFormat("yyyy-MM-dd HH:mm:ss"),
                                        onShowPicker:
                                            (context, currentValue) async {
                                          final date = await showDatePicker(
                                              context: context,
                                              firstDate: DateTime(1900),
                                              initialDate: currentValue ??
                                                  DateTime.now(),
                                              lastDate: DateTime(2100));
                                          if (date != null) {
                                            final time = await showTimePicker(
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
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 2,
                                right: SizeConfig.blockVertical * 5),
                            child: Text(
                              "Buka Harga",
                              style: TextStyle(
                                  color: appBarTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.only(
                                left: SizeConfig.blockVertical * 5,
                                top: SizeConfig.blockVertical * 1,
                                right: SizeConfig.blockVertical * 5),
                            child: TextFormField(
                              controller: _bukaHargaLelang,
                              decoration: EditTextDecorationText(
                                  context, "", 20.0, 0, 0, 0),
                              keyboardType: TextInputType.number,
                              style: TextStyle(
                                  color: blackTextColor,
                                  fontFamily: 'lato',
                                  letterSpacing: 0.4,
                                  fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                            ),
                          ),
                          Container(
                              margin: EdgeInsets.only(bottom: 20.0),
                              child: new Align(
                                  alignment: FractionalOffset.bottomCenter,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Container(
                                        height: 45.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockVertical * 5,
                                            right: SizeConfig.blockVertical * 5,
                                            top: 20.0),
                                        child: CustomElevation(
                                            height: 30.0,
                                            child: RaisedButton(
                                              highlightColor: colorPrimary,
                                              //Replace with actual colors
                                              color: colorPrimary,
                                              onPressed: () => {
                                                _buttonLelang()
                                              },
                                              child: Text(
                                                "Lelang",
                                                style: TextStyle(
                                                    color: backgroundColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'poppins',
                                                    letterSpacing: 1.25,
                                                    fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                              ),
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                            )),
                                      ),
                                      Container(
                                        height: 45.0,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        margin: EdgeInsets.only(
                                            left: SizeConfig.blockVertical * 5,
                                            right: SizeConfig.blockVertical * 5,
                                            top: 15.0),
                                        child: CustomElevation(
                                            height: 30.0,
                                            child: RaisedButton(
                                              highlightColor: redTextColor,
                                              //Replace with actual colors
                                              color: redTextColor,
                                              onPressed: () => {
                                                //
                                                  Navigator.push(
                                                      context,
                                                      PageTransition(
                                                          type: PageTransitionType.fade,
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
                                                "Batal",
                                                style: TextStyle(
                                                    color: backgroundColor,
                                                    fontWeight: FontWeight.w500,
                                                    fontFamily: 'poppins',
                                                    letterSpacing: 1.25,
                                                    fontSize: ScreenUtil(allowFontScaling: false).setSp(40)),
                                              ),
                                              shape: new RoundedRectangleBorder(
                                                borderRadius:
                                                    new BorderRadius.circular(
                                                        30.0),
                                              ),
                                            )),
                                      ),
                                    ],
                                  )))
                        ],
                      ))),
            ],
          ),
        ));
  }
}
