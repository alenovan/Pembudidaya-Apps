import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaDimens.dart';
import 'package:lelenesia_pembudidaya/src/typography.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/forgot/ForgotWidget.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/DetailLelangView.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/laporan/lelang/LelangHistory.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/extensions.dart' as AppExt;
import 'package:lelenesia_pembudidaya/src/ui/tools/ScreenUtil.dart';
import 'package:lelenesia_pembudidaya/src/ui/tools/SizingConfig.dart';
import 'package:lelenesia_pembudidaya/src/ui/screen/dashboard/DashboardWidget.dart';
import 'package:lelenesia_pembudidaya/src/LelenesiaColors.dart';
import 'package:flutter/services.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/BottomSheetFeedback.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/CustomElevation.dart';
import 'package:lelenesia_pembudidaya/src/ui/widget/LoadingDialog.dart';
import 'package:page_transition/page_transition.dart';
import 'package:lelenesia_pembudidaya/src/bloc/LelangBloc.dart' as lelang;
import 'package:shimmer/shimmer.dart';
class DetailPreviewBidder extends StatefulWidget {
  final String idBidder;
  final String idLelang;
  final String idKolam;
  const DetailPreviewBidder({Key key, this.idBidder, this.idLelang, this.idKolam}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<DetailPreviewBidder> {
  var _name="null",_phone="null",_price="null",_alamat="null";
  final formatter = new NumberFormat('#,##0', 'ID');
  void fetchData() async{
    var data = await lelang.bloc.getBidderDetail(widget.idBidder);
    print(data);
    setState(() {
      _name = data['name'].toString();
      _phone = "-";
      _price = "Rp.${formatter.format(int.parse(data['bid_price']))}";
      _alamat = "-";
    });
  }

  void setWinner() async{
    LoadingDialog.show(context);
    var status = await lelang.bloc.setWinnerlelang(widget.idBidder,widget.idLelang);
    if (status) {
      AppExt.popScreen(context);
      BottomSheetFeedback.show_success(context, title: "Selamat", description: "Pemilihan pemenang berhasil");
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


    } else {
      AppExt.popScreen(context);
      BottomSheetFeedback.show(context, title: "Mohon Maaf", description: "Silahkan ulangi kembali");
    }
  }
  @override
  void initState() {
    fetchData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    ScreenUtil.instance = ScreenUtil();
    return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Scaffold(
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
                                top: SizeConfig.blockHorizotal * 20,
                                left: SizeConfig.blockHorizotal * 5,
                                bottom: SizeConfig.blockHorizotal * 3,
                              ),
                              child: GestureDetector(
                                  onTap: ()=>{
                                    Navigator.of(context).pop()
                                  },
                                  child: Icon(Icons.arrow_back,
                                      color: Colors.black,
                                      size: ScreenUtil(allowFontScaling: false).setSp(80))),
                            ),
                            Expanded(
                                child: Container(
                                    margin: EdgeInsets.only(
                                        top: ScreenUtil()
                                            .setHeight(240)),
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Column(
                                        children: [
                                          new Container(
                                              child: Image.asset(
                                                "assets/png/dummy_profile.png",
                                                fit: BoxFit.cover,
                                              )),
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: Text(
                            "Nama",
                            style: subtitle1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(50)),
                          )),

                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: _name != "null"?Text(
                            "${_name}",
                            style: body2.copyWith(
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(45)),
                          ):Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white,
                              child: Container(
                                height: 20.0,
                                width: ScreenUtil().setWidth(300),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            16.0))),
                              ))),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          bottom: ScreenUtil().setHeight(20),
                        ),
                        color: editTextField,
                        height: 0.5,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: Text(
                            "Nomor Handphone",
                            style: subtitle1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(50)),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: _phone != "null"?Text(
                            "${_phone}",
                            style: body2.copyWith(
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(45)),
                          ):Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white,
                              child: Container(
                                height: 20.0,
                                width: ScreenUtil().setWidth(300),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            16.0))),
                              ))),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          bottom: ScreenUtil().setHeight(20),
                        ),
                        color: editTextField,
                        height: 0.5,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: Text(
                            "Harga",
                            style: subtitle1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(50)),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: _price != "null"?Text(
                            "${_price}",
                            style: body2.copyWith(
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(45)),
                          ):Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white,
                              child: Container(
                                height: 20.0,
                                width: ScreenUtil().setWidth(300),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            16.0))),
                              ))),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          bottom: ScreenUtil().setHeight(20),
                        ),
                        color: editTextField,
                        height: 0.5,
                      ),
                      Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: Text(
                            "Alamat",
                            style: subtitle1.copyWith(
                                fontWeight: FontWeight.w700,
                                color: Colors.black,
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(50)),
                          )),
                      Container(
                          margin: EdgeInsets.only(
                              top: ScreenUtil().setHeight(20),
                              left: ScreenUtil().setWidth(70),
                              right: ScreenUtil().setWidth(70)),
                          child: _alamat != "null"?Text(
                            "${_alamat}",
                            style: body2.copyWith(
                                fontSize: ScreenUtil(allowFontScaling: false)
                                    .setSp(45)),
                          ):Shimmer.fromColors(
                              baseColor: Colors.grey[300],
                              highlightColor: Colors.white,
                              child: Container(
                                height: 20.0,
                                width: ScreenUtil().setWidth(300),
                                decoration: BoxDecoration(
                                    color: Colors.grey[300],
                                    borderRadius:
                                    BorderRadius.all(
                                        Radius.circular(
                                            16.0))),
                              ))),
                      Container(
                        margin: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          bottom: ScreenUtil().setHeight(20),
                        ),
                        color: editTextField,
                        height: 0.5,
                      ),
                      // Container(
                      //     margin: EdgeInsets.only(
                      //         left: ScreenUtil().setWidth(70),
                      //         right: ScreenUtil().setWidth(70)),
                      //     child: Text(
                      //       "Perkiraan Keuntungan",
                      //       style: subtitle1.copyWith(
                      //           fontWeight: FontWeight.w700,
                      //           color: Colors.black,
                      //           fontSize: ScreenUtil(allowFontScaling: false)
                      //               .setSp(50)),
                      //     )),
                      // Container(
                      //     margin: EdgeInsets.only(
                      //         top: ScreenUtil().setHeight(20),
                      //         left: ScreenUtil().setWidth(70),
                      //         right: ScreenUtil().setWidth(70)),
                      //     child: Text(
                      //       "RP.17.500",
                      //       style: body2.copyWith(
                      //           fontSize: ScreenUtil(allowFontScaling: false)
                      //               .setSp(45)),
                      //     )),

                      // Container(
                      //   margin: EdgeInsets.only(
                      //     top: ScreenUtil().setHeight(50),
                      //     bottom: ScreenUtil().setHeight(20),
                      //   ),
                      //   color: editTextField,
                      //   height: 0.5,
                      // ),
                      Container(
                          margin: EdgeInsets.only(
                              left: ScreenUtil().setWidth(50),
                              right: ScreenUtil().setWidth(50)),
                          child: new Align(
                              alignment: FractionalOffset.bottomCenter,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Container(
                                    height: 45.0,
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width,
                                    margin: EdgeInsets.only(
                                        top: 15.0),
                                    child: CustomElevation(
                                        height: 30.0,
                                        child: RaisedButton(
                                          highlightColor: colorPrimary,
                                          //Replace with actual colors
                                          color: colorPrimary,
                                          onPressed: () => {
                                            setWinner()
                                          },
                                          child: Text(
                                            "Berikan",
                                            style: TextStyle(
                                                color: backgroundColor,
                                                fontWeight: FontWeight.w500,
                                                fontFamily: 'poppins',
                                                letterSpacing: 1.25,
                                                fontSize: subTitleLogin),
                                          ),
                                          shape: new RoundedRectangleBorder(
                                            borderRadius:
                                            new BorderRadius.circular(30.0),
                                          ),
                                        )),
                                  ),
                                ],
                              ))),
                      SizedBox(
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ],
            )));
  }

  Future<bool> _onBackPressed() {

    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.fade,
            child: LelangHistory(
              idKolam: widget.idKolam,
            )));
  }
}
